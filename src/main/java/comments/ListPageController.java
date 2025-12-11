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
import utils.BoardPage;

@WebServlet("/comments/List.do")
public class ListPageController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<String, Object>();

		/* 페이지 처리 start */
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);

		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);
		/* 페이지 처리 end */

		String pNum = req.getParameter("pNum");

		map.put("pNum", pNum);

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
		json.append("\"page\":").append(pageNum).append(",");
		json.append("\"pageSize\":").append(pageSize).append(",");
		json.append("\"comments\":[");

		for (int i = 0; i < commentsList.size(); i++) {
			CommentsDTO dto = commentsList.get(i);
			// JSON 깨짐 방지: 따옴표/줄바꿈 이스케이프
			String safeContent = dto.getContent().replace("\\", "\\\\") // 역슬래시 먼저 처리
					.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t")
					.replace("\b", "\\b").replace("\f", "\\f");

			json.append("{").append("\"cNum\":\"").append(dto.getcNum()).append("\",").append("\"id\":\"")
					.append(dto.getId()).append("\",").append("\"name\":\"").append(dto.getName()).append("\",")
					.append("\"content\":\"").append(safeContent).append("\",").append("\"regidate\":\"")
					.append(dto.getRegidate()).append("\"").append("}");
			if (i < commentsList.size() - 1)
				json.append(",");
		}

		json.append("],");

		// 페이지 버튼 추가
		String category = req.getParameter("category");
		String baseUrl = "/board/View.do?category=" + category + "&pNum=" + pNum;
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum,
				req.getContextPath() + baseUrl);

		json.append("\"pagingImg\":\"").append(pagingImg.replace("\"", "\\\"")).append("\"}");

		out.print(json.toString());
		out.flush();

	}
}