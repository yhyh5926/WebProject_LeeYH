<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.view-title {
	color: yellowgreen;
	text-align: center;
	margin: 20px 0;
}

.view-table {
	width: 90%;
	margin: 20px auto;
	border-collapse: collapse;
	border: 2px solid yellowgreen;
}

.view-table th, .view-table td {
	padding: 10px;
	border: 1px solid #ccc;
}

.view-table th {
	background-color: yellowgreen;
	color: white;
}

.view-table a {
	text-decoration: none;
	color: black;
}

.view-table a:hover {
	text-decoration: underline;
	color: yellowgreen;
}

.view-buttons {
	text-align: center;
	margin: 20px 0;
}

.view-buttons button {
	background-color: yellowgreen;
	color: white;
	padding: 8px 15px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin: 0 5px;
}

.view-buttons button:hover {
	background-color: green;
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />
	<h2 class="view-title">파일 첨부형 게시판 - 상세 보기(View)</h2>

	<table class="view-table">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="*" />
		</colgroup>
		<tr>
			<th>번호</th>
			<td>${dto.idx }</td>
			<th>작성자</th>
			<td>${dto.name }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${dto.postdate }</td>
			<th>조회수</th>
			<td>${dto.visitcount }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3">${dto.title }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3" height="100">${dto.content}<c:if
					test="${not empty dto.ofile }">
					<br>
					<c:choose>
						<c:when test="${mimeType eq 'img' }">
							<img src="../Uploads/${dto.sfile }" style="max-width: 300px">
						</c:when>
						<c:when test="${mimeType eq 'audio' }">
							<audio controls="controls">
								<source src="../Uploads/${dto.sfile }" type="audio/mp3">
							</audio>
						</c:when>
						<c:when test="${mimeType eq 'video' }">
							<video controls>
								<source src="../Uploads/${dto.sfile }" type="video/mp4">
								Your browser does not support the video tag
							</video>
						</c:when>
					</c:choose>

				</c:if>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td><c:if test="${not empty dto.ofile}">
					${dto.ofile}
					<a
						href="../mvcboard/download.do?ofile=${dto.ofile}&sfile=${dto.sfile}&idx=${dto.idx}">
						[다운로드] </a>
				</c:if></td>
			<th>다운로드수</th>
			<td>${dto.downcount }</td>
		</tr>
	</table>


	<div class="view-buttons">
		<!-- sessionScope.UserId에서 값이 유일하면 UserId만 써도 됨 -->
		<c:if test="${not empty UserId and sessionScope.UserId eq dto.id }">
			<button type="button"
				onclick="location.href='../mvcboard/edit.do?idx=${param.idx}'">수정하기</button>
			<button type="button"
				onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='../mvcboard/delete.do?idx=${param.idx}'">삭제하기</button>
		</c:if>

		<button type="button" onclick="location.href='../mvcboard/list.do'">목록
			바로가기</button>
		<button type="button" onclick="location.href='../mvcboard/listPage.do'">페이징 목록
			바로가기</button>
	</div>
</body>
</html>