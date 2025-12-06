<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%
// 카테고리 받아오기 (기본: free)
String category = request.getParameter("category") == null ? "free" : request.getParameter("category");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/board/board.css">
</head>
<body class="category-<%=category%>">
	<jsp:include page="../Common/Link.jsp" />

	<h2 class="page-title">QnA 게시판</h2>

	<!-- 검색 폼 -->
	<form method="get" class="search-form">
		<select name="searchField">
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select> <input type="text" name="searchWord" /> <input type="submit"
			value="검색하기" />
	</form>

	<!-- 게시판 목록 -->
	<table class="board-table">
		<tr>
			<th width="10%">번호</th>
			<th>제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="8%">첨부</th>
		</tr>
		<c:choose>
			<c:when test="${empty boardLists}">
				<tr>
					<td colspan="6">등록된 게시물이 없습니다^^*</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${boardLists}" var="row" varStatus="loop">
					<tr>
						<td>${map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index)}</td>
						<td align="left"><a
							href="./View.do?category=${row.category}&pNum=${row.pNum}">${row.title}</a>
						</td>
						<td>${row.name}</td>
						<td>${row.visitCount}</td>
						<td>${row.postDate}</td>
						<td><c:if test="${not empty row.ofile}">
								<a class="download-link"
									href="./download.do?ofile=${row.ofile}&sfile=${row.sfile}&pNum=${row.pNum}">[Down]</a>
							</c:if></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

	<!-- 하단 메뉴 -->
	<div class="bottom-menu">
		<div>${map.pagingImg}</div>
		<button type="button" class="write-btn"
			onclick="location.href='./Write.do';">글쓰기</button>
	</div>
</body>
</html>
