package board;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/board/View.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 첨부파일 MIME 타입 확인
	public String mimeTypeConfirm(String ext) {
		String mimeType = null;
		String[] extArray1 = { "png", "jpg", "gif", "pcx", "bmp", "jpeg", "svg" };
		String[] extArray2 = { "mp3", "wav" };
		String[] extArray3 = { "mp4", "avi", "wmv" };

		List<String> mimeList1 = Arrays.asList(extArray1);
		List<String> mimeList2 = Arrays.asList(extArray2);
		List<String> mimeList3 = Arrays.asList(extArray3);

		if (mimeList1.contains(ext))
			mimeType = "img";
		else if (mimeList2.contains(ext))
			mimeType = "audio";
		else if (mimeList3.contains(ext))
			mimeType = "video";

		return mimeType;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 불러오기
		BoardDAO dao = new BoardDAO();
		String pNum = req.getParameter("pNum");

		if (pNum == null || pNum.trim().isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/board/Board.do"); // pNum 없으면 리스트로 리다이렉트
			return;
		}

		// 쿠키 확인
		boolean visited = false;
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("visited_" + pNum)) {
					visited = true;
					break;
				}
			}
		}

		// 하루에 한 번만 조회수 증가
		if (!visited) {
			dao.updateVisitCount(pNum);

			Cookie visitCookie = new Cookie("visited_" + pNum, "true");
			visitCookie.setMaxAge(24 * 60 * 60); // 1일 유지
			resp.addCookie(visitCookie);
		}

		BoardDTO dto = dao.selectView(pNum);
		// 로그인한 사용자가 좋아요 했는지 여부
		String userId = (String) req.getSession().getAttribute("userId");
		if (userId != null) {
			boolean liked = dao.hasFavorite(dto.getpNum(), userId);
			dto.setLikedByUser(liked);
		}
		
		dao.close();

		// 줄바꿈 처리
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));

		// 첨부파일 확장자 추출 및 MIME 타입 확인
		String ext = null;
		String fileName = dto.getSfile();
		if (fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			req.setAttribute("mimeType", mimeTypeConfirm(ext));
		}

		// 게시물 저장 후 JSP로 포워드
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/board/View.jsp").forward(req, resp);
	}
}
