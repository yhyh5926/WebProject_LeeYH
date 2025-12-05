package board;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/download.do")
public class DownloadController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ofile = req.getParameter("ofile"); // 원본 파일명
		String sfile = req.getParameter("sfile"); // 저장된 파일명
		String idx = req.getParameter("idx"); // 게시물 일련번호

		// 다운로드 처리
		FileUtil.download(req, resp, "/Uploads", sfile, ofile);

		// DAO 인스턴스 생성 후 다운로드 횟수 증가
		BoardDAO dao = new BoardDAO();
		dao.close();
	}
}
