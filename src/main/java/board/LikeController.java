package board;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/board/Like.do")
public class LikeController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter out = resp.getWriter();

		String userId = (String) req.getSession().getAttribute("userId");
		String pNum = req.getParameter("pNum");
		BoardDAO dao = new BoardDAO();

		boolean alreadyLiked = dao.hasFavorite(pNum, userId);
		int likeCount;

		if (alreadyLiked) {
			dao.removeFavorite(pNum, userId);
			likeCount = dao.getLikeCount(pNum);
			out.print("{\"success\":true, \"liked\":false, \"likeCount\":" + likeCount + "}");
		} else {
			dao.addFavorite(pNum, userId);
			likeCount = dao.getLikeCount(pNum);
			out.print("{\"success\":true, \"liked\":true, \"likeCount\":" + likeCount + "}");
		}
	}
}