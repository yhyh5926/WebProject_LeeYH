package utils;

public class BoardPage {

	public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String reqUrl) {

		String pagingStr = "";

		int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));
		int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;

		// ?가 이미 있는지 체크
		String paramJoin = reqUrl.contains("?") ? "&" : "?";

		if (pageTemp != 1) {
			pagingStr += "<a class='page-button' href='" + reqUrl + paramJoin + "pageNum=1'>[첫 페이지]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a class='page-button' href='" + reqUrl + paramJoin + "pageNum=" + (pageTemp - 1)
					+ "'>[이전 블록]</a>";
		}

		int blockCount = 1;
		while (blockCount <= blockPage && pageTemp <= totalPages) {
			if (pageTemp == pageNum) {
				pagingStr += "&nbsp;<span class='current'>" + pageTemp + "</span>&nbsp;";
			} else {
				pagingStr += "&nbsp;<a class='other' href='" + reqUrl + paramJoin + "pageNum=" + pageTemp + "'>"
						+ pageTemp + "</a>&nbsp;";
			}
			pageTemp++;
			blockCount++;
		}

		if (pageTemp <= totalPages) {
			pagingStr += "<a class='page-button' href='" + reqUrl + paramJoin + "pageNum=" + pageTemp + "'>[다음 블록]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a class='page-button' href='" + reqUrl + paramJoin + "pageNum=" + totalPages
					+ "'>[마지막 페이지]</a>";
		}

		return pagingStr;
	}
}
