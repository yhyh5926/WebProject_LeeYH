package board;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/board/view.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * service() 메서드 :서블릿의 수명주기에서 요청을 먼저 받아 get 혹은 post 방식인지 판단하여 분기하는 함수로 2가지 방식의
	 * 요청을 모두 처리 가능 여기서는 doGet 대신 사용해 보았다.
	 */

	public String mimeTypeConfirm(String ext) {
		String mimeType = null;
		String[] extArray1 = { "png", "jpg", "gif", "pcx", "bmp", "jepg", "sgv" };
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
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 불러오기
		BoardDAO dao = new BoardDAO();
		String pNum = req.getParameter("pNum");
		dao.updateVisitCount(pNum); // 조회수 1 증가
		BoardDTO dto = dao.selectView(pNum);
		dao.close();

		// 줄바꿈 처리
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));

		// 첨부파일 확장자 추출 및 이미지 타입 확인
		String ext = null, fileName = dto.getSfile();
		if (fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".") + 1);
			req.setAttribute("mimeType", mimeTypeConfirm(ext));
		}

		// 게시물(dto) 저장 후 뷰로 포워드
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14Board/View.jsp").forward(req, resp);
	}
}