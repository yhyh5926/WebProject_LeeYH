<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
	color: black;
}

.page-title {
	color: yellowgreen;
	text-align: center;
	padding: 15px;
}

.search-form {
	margin: 20px auto;
	width: 90%;
	border: 2px solid yellowgreen;
	padding: 10px;
	border-radius: 8px;
}

.search-form select, .search-form input[type="text"], .search-form input[type="submit"]
	{
	padding: 5px;
	margin: 5px;
	border: 1px solid yellowgreen;
	border-radius: 5px;
}

.search-form input[type="submit"] {
	background-color: yellowgreen;
	color: white;
	cursor: pointer;
}

.search-form input[type="submit"]:hover {
	background-color: green;
}

.board-table {
	width: 90%;
	margin: 20px auto;
	border-collapse: collapse;
}

.board-table th {
	background-color: yellowgreen;
	color: white;
	padding: 10px;
}

.board-table td {
	padding: 8px;
	border: 1px solid #ccc;
}

.board-table a {
	text-decoration: none;
	color: black;
}

.board-table a:hover {
	text-decoration: underline;
}

.download-link {
	color: yellowgreen;
	font-weight: bold;
}

.download-link:hover {
	color: yellowgreen;
	text-decoration: underline;
}

.bottom-menu {
	width: 90%;
	margin: 20px auto;
	text-align: center;
}

.page-button {
	background-color: yellowgreen;
	color: white;
	padding: 4px 8px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.page-button:hover {
	background-color: green;
}

.write-btn {
	background-color: yellowgreen;
	color: white;
	padding: 8px 15px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.write-btn:hover {
	background-color: green;
}

.current {
	background-color: yellowgreen;
	color: white;
	padding: 4px 8px;
	border: none;
	border-radius: 5px;
}

.other:hover {
	background-color: green;
	padding: 4px 0;
	color: white;
	border: none;
	border-radius: 5px;
}
</style>
</head>
<body class="body-bg">
	<jsp:include page="../Common/Link.jsp" />
	<h2 class="page-title">QnA 게시판</h2>

	<!-- 검색 폼 -->
	<form method="get" class="search-form">
		<table width="100%">
			<tr>
				<td align="center"><select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
				</select> <input type="text" name="searchWord" /> <input type="submit"
					value="검색하기" /></td>
			</tr>
		</table>
	</form>

	<!-- 목록 테이블 -->
	<table class="board-table">
		<tr>
			<th width="10%">번호</th>
			<th width="*">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="8%">첨부</th>
		</tr>
		<c:choose>
			<c:when test="${ empty boardLists }">
				<tr>
					<td colspan="6" align="center">등록된 게시물이 없습니다^^*</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${ boardLists }" var="row" varStatus="loop">
					<tr align="center">
						<td>${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index)}</td>
						<td align="left"><a
							href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a></td>
						<td>${ row.name }</td>
						<td>${ row.visitcount }</td>
						<td>${ row.postdate }</td>
						<td><c:if test="${ not empty row.ofile }">
								<a class="download-link"
									href="../mvcboard/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a>
							</c:if></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

	<!-- 하단 메뉴 -->
	<table class="bottom-menu">
		<tr>
			<td>${map.pagingImg }</td>
			<td>
				<button type="button" class="write-btn"
					onclick="location.href='/WebProject_LeeYH/board/write.do';">글쓰기</button>
			</td>
		</tr>
	</table>
</body>
</html>