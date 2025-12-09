package comments;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/comments/List.do")
public class ListPageController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<String, Object>();

		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int page = 1;

		// 페이지 번호 파라미터 처리
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}

		int start = (page - 1) * pageSize + 1;
		int end = page * pageSize;
		String pNum = req.getParameter("pNum");

		map.put("pNum", pNum);
		map.put("start", start);
		map.put("end", end);

		CommentsDAO dao = new CommentsDAO();
		List<CommentsDTO> commentsList = dao.selectListPage(map);
		int totalCount = dao.selectCount(map);

		dao.close();

		// JSON 응답
		resp.setContentType("application/json; charset=UTF-8");
		PrintWriter out = resp.getWriter();

		StringBuilder json = new StringBuilder();
		json.append("{\"success\":true,");
		json.append("\"totalCount\":").append(totalCount).append(",");
		json.append("\"page\":").append(page).append(",");
		json.append("\"pageSize\":").append(pageSize).append(",");
		json.append("\"comments\":[");

		for (int i = 0; i < commentsList.size(); i++) {
			CommentsDTO dto = commentsList.get(i);
			// JSON 깨짐 방지: 따옴표/줄바꿈 이스케이프
			String safeContent = dto.getContent().replace("\"", "\\\"").replace("\n", "\\n");

			json.append("{").append("\"cnum\":\"").append(dto.getcNum()).append("\",").append("\"id\":\"")
					.append(dto.getId()).append("\",").append("\"name\":\"").append(dto.getName()).append("\",")
					.append("\"content\":\"").append(safeContent).append("\",").append("\"regidate\":\"")
					.append(dto.getRegidate()).append("\"").append("}");
			if (i < commentsList.size() - 1)
				json.append(",");
		}

		json.append("]}");
		out.print(json.toString());
		out.flush();

	}
}