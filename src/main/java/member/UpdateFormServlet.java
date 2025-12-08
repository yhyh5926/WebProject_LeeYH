package member;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sign/UpdateForm.do")
public class UpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			// 로그인 안 된 상태 → 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath() + "/LoginForm.jsp");
			return;
		}

		// DB 연결 정보 가져오기 (web.xml context-param)
		String oracleDriver = getServletContext().getInitParameter("OracleDriver");
		String oracleURL = getServletContext().getInitParameter("OracleURL");
		String oracleId = getServletContext().getInitParameter("OracleId");
		String oraclePwd = getServletContext().getInitParameter("OraclePwd");

		MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
		MemberDTO member = dao.getMemberDTOById(userId); // userId로 회원정보 조회
		dao.close();

		if (member != null) {
			request.setAttribute("member", member);
			// JSP로 forward
			request.getRequestDispatcher("/sign/UpdateForm.jsp").forward(request, response);
		} else {
			// 조회 실패 시 에러 메시지
			request.setAttribute("UpdateErrMsg", "회원 정보를 불러올 수 없습니다.");
			request.getRequestDispatcher("/sign/UpdateForm.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}