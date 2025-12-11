package comments;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/comments/Delete.do")
public class DeleteController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 확인
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", "../06Session/LoginForm.jsp");
			return;
		}

		String cNum = req.getParameter("cNum");

		System.out.println("삭제 요청받음, 삭제할 댓글 번호:" + cNum);

		CommentsDAO dao = new CommentsDAO();

		// 댓글 삭제
		int result = dao.deleteComment(cNum);

		PrintWriter out = resp.getWriter();

		if (result == 1) { // 댓글 수정 성공
			out.print("{\"success\":true, \"message\":\"댓글 삭제 성공\"}");
		} else { // 실패
			out.print("{\"success\":false, \"message\":\"댓글 삭제 실패\"}");
		}

		// PrintWriter의 버퍼에 남아있는 데이터를 실제로 클라이언트로 전송
		out.flush();
		dao.close();
	}

}
