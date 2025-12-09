package comments;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/comments/Write.do")
//폼데이터 보낼 시 설정해야 함
@MultipartConfig
public class WriteController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 로그인 확인
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");

		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();

		if (userId == null) {
			out.print("{\"success\":false, \"message\":\"로그인 후 이용해주세요.\"}");
			out.flush();
			return;
		}

		// 폼값을 DTO에 저장
		CommentsDTO dto = new CommentsDTO();
		String content = req.getParameter("content");
		String pNum = req.getParameter("pNum");

		dto.setId(userId);
		dto.setContent(content);
		dto.setpNum(pNum);

		// DAO를 통해 DB에 댓글 내용 저장

		CommentsDAO dao = new CommentsDAO();
		int result = dao.insertWrite(dto);

		if (result == 1) { // 댓글 쓰기 성공
			// 방금 등록한 댓글의 작성일 가져오기
			String regidate = dao.getRegidate(dto.getId(), dto.getpNum());

			// DB에 저장된 작성자 이름, 작성일 등을 dto에 채워 json으로 보내기
			out.print("{\"success\":true," + "\"comment\":{" + "\"id\":\"" + dto.getId() + "\"," + "\"name\":\""
					+ userName + "\"," + "\"content\":\"" + dto.getContent() + "\"," + "\"regidate\":\"" + regidate
					+ "\"" + "}}");
		} else { // 실패
			out.print("{\"success\":false, \"message\":\"댓글 등록 실패\"}");
		}
		out.flush();
		dao.close();

	}
}