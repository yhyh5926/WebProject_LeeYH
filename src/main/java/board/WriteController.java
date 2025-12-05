package board;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/board/write.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 임시 파일 크기 (1MB)
		maxFileSize = 1024 * 1024 * 10, // 최대 크기 (10MB)
		maxRequestSize = 1024 * 1024 * 50 // 전체 크기 (50MB)
)

public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 로그인 확인을 위한 session 내장객체 얻기
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");

		/*
		 * session 영역에 회원인증에 관련된 속성이 없다면 로그아웃 상태이므로 로그인 페이지로 이동
		 */
		if (userId == null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", "../sign/LoginForm.jsp");
			return;
		}

		// 로그인 되면 쓰기 페이지로 포워드
		req.getRequestDispatcher("/board/Write.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 확인
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");

		/*
		 * session 영역에 회원인증에 관련된 속성이 없다면 로그아웃 상태이므로 로그인 페이지로 이동
		 */
		if (userId == null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", "../sign/LoginForm.jsp");
			return;
		}

		// 1. 파일 업로드 처리 =============================
		// 업로드 디렉터리의 물리적 경로 확인
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");

		// 파일 업로드
		String originalFileName = "";
		try {
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		} catch (Exception e) {
			e.printStackTrace();
			JSFunction.alertLocation(resp, "파일 업로드 오류입니다.", "../board/write.do");
			return;
		}

		// 2. 파일 업로드 외 처리 =============================
		// 폼값을 DTO에 저장
		BoardDTO dto = new BoardDTO();
		dto.setId(userId);
		dto.setName(req.getParameter("name"));
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		dto.setCategory(req.getParameter("category"));
		// 원본 파일명과 저장된 파일 이름 설정
		if (originalFileName != "") {
			// 파일명 변경
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);

			dto.setOfile(originalFileName); // 원래 파일 이름
			dto.setSfile(savedFileName); // 서버에 저장된 파일 이름
		}

		// DAO를 통해 DB에 게시 내용 저장
		BoardDAO dao = new BoardDAO();
		int result = dao.insertWrite(dto);
		dao.close();

		// 성공 or 실패?
		if (result == 1) { // 글쓰기 성공
			resp.sendRedirect("../board/list.do");
		} else { // 글쓰기 실패
			JSFunction.alertLocation(resp, "글쓰기에 실패했습니다.", "../board/write.do");
		}
	}

}
