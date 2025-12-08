package member;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CheckId.do")
public class CheckIdController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userId = request.getParameter("userId");
		boolean exists = false;

		String oracleDriver = getServletContext().getInitParameter("OracleDriver");
		String oracleURL = getServletContext().getInitParameter("OracleURL");
		String oracleId = getServletContext().getInitParameter("OracleId");
		String oraclePwd = getServletContext().getInitParameter("OraclePwd");

		MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

		exists = dao.isIdExists(userId);
		dao.close();

		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{\"exists\":" + exists + "}");
		out.flush();
	}
}