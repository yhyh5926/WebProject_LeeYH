<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String category = request.getParameter("category") == null ? "free" : request.getParameter("category");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH - 게시판 상세보기</title>
<style>
/* -------------------- 초기화 -------------------- */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #f0f2f5;
	color: #333;
	font-family: 'Arial', sans-serif;
	line-height: 1.6;
}

/* -------------------- 카테고리 색상 -------------------- */
body.category-free {
	--color-primary: #2ecc71;
	--color-primary-dark: #27ae60;
}

body.category-qna {
	--color-primary: #3498db;
	--color-primary-dark: #2980b9;
}

body.category-data {
	--color-primary: #9b59b6;
	--color-primary-dark: #8e44ad;
}

/* -------------------- 페이지 헤더 -------------------- */
.page-header {
	text-align: center;
	margin-block: 30px;
}

.page-header h2 {
	color: var(--color-primary);
	font-size: 32px;
	font-weight: 700;
	border-bottom: 3px solid var(--color-primary);
	display: inline-block;
	padding-bottom: 5px;
}

/* -------------------- 카드형 상세보기 -------------------- */
.card {
	background-color: #fff;
	max-width: 900px;
	margin: 0 auto 20px auto;
	padding: 25px 30px;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
	display: flex;
	flex-direction: column;
	gap: 25px;
}

/* -------------------- 글 정보 -------------------- */
.card .info {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	gap: 15px;
	font-size: 16px;
	color: #555;
	border-bottom: 1px solid #e0e0e0;
	padding-bottom: 15px;
}

.info-item {
	flex: 1 1 45%;
	display: flex;
	justify-content: space-between;
}

.info-item span:first-child {
	font-weight: 600;
	color: #777;
}

/* -------------------- 글 제목 -------------------- */
.card .title {
	font-size: 28px;
	font-weight: 700;
	color: var(--color-primary);
	border-bottom: 1px solid #e0e0e0;
	padding-bottom: 10px;
}

/* -------------------- 글 내용 -------------------- */
.card .content {
	min-height: 220px;
	padding: 20px;
	background-color: #f9fafc;
	border-radius: 8px;
	font-size: 16px;
	white-space: pre-line;
	box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.05);
}

/* -------------------- 첨부파일 & 미디어 -------------------- */
.card .media-container {
	margin-top: 15px;
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.card .media-container img, .card .media-container video, .card .media-container audio
	{
	max-width: 100%;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* 첨부파일 다운로드 */
.card .attachment {
	margin-top: 10px;
	font-size: 14px;
	display: flex;
	align-items: center;
	gap: 5px;
}

.card .attachment::before {
	content: "📎";
}

.card .attachment a {
	color: var(--color-primary);
	font-weight: bold;
	text-decoration: none;
}

.card .attachment a:hover {
	text-decoration: underline;
}

/* -------------------- 버튼 그룹 -------------------- */
.button-group {
	max-width: 900px;
	margin: 10px auto;
	display: flex;
	justify-content: flex-end;
	flex-wrap: wrap;
	gap: 10px;
}

.button-group button {
	padding: 12px 20px;
	border: none;
	border-radius: 6px;
	background-color: var(--color-primary);
	color: #fff;
	font-weight: 600;
	font-size: 16px;
	cursor: pointer;
	transition: background 0.2s ease, transform 0.1s ease;
}

.button-group button:hover {
	background-color: var(--color-primary-dark);
	transform: translateY(-1px);
}

.card a {
	color: var(--color-primary);
	text-decoration: none;
	font-weight: 600;
}

.card a:hover {
	text-decoration: underline;
}
</style>
</head>
<body class="category-<%=category%>">
	<jsp:include page="../Common/Link.jsp" />

	<header class="page-header">
		<h2>게시판 상세보기</h2>
	</header>

	<main>
		<div class="card">
			<!-- 글 정보 -->
			<div class="info">
				<div class="info-item">
					<span>번호</span> <span>${dto.pNum}</span>
				</div>
				<div class="info-item">
					<span>작성자</span> <span>${dto.name}</span>
				</div>
				<div class="info-item">
					<span>작성일</span> <span>${dto.postDate}</span>
				</div>
				<div class="info-item">
					<span>조회수</span> <span>${dto.visitCount}</span>
				</div>
			</div>

			<!-- 글 제목 -->
			<div class="title">${dto.title}</div>

			<!-- 글 내용 -->
			<div class="content">
				${dto.content}

				<!-- 첨부 미디어 -->
				<c:if test="${not empty dto.ofile}">
					<div class="media-container">
						<c:choose>
							<c:when test="${mimeType eq 'img'}">
								<img src="../Uploads/${dto.sfile}" alt="첨부 이미지">
							</c:when>
							<c:when test="${mimeType eq 'audio'}">
								<audio controls>
									<source src="../Uploads/${dto.sfile}" type="audio/mp3">
									브라우저가 오디오를 지원하지 않습니다.
								</audio>
							</c:when>
							<c:when test="${mimeType eq 'video'}">
								<video controls>
									<source src="../Uploads/${dto.sfile}" type="video/mp4">
									브라우저가 비디오를 지원하지 않습니다.
								</video>
							</c:when>
						</c:choose>
					</div>

					<!-- 첨부파일 다운로드 -->
					<div class="attachment">
						<a
							href="./download.do?ofile=${dto.ofile}&sfile=${dto.sfile}&pNum=${dto.pNum}">
							${dto.ofile} [다운로드] </a>
					</div>
				</c:if>
			</div>
		</div>

		<!-- 버튼 그룹 -->
		<div class="button-group">
			<c:if test="${not empty userId and sessionScope.userId eq dto.id}">
				<button type="button"
					onclick="location.href='./edit.do?pNum=${param.pNum}'">수정하기</button>
				<button type="button"
					onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='./delete.do?pNum=${param.pNum}'">삭제하기</button>
			</c:if>
			<button type="button" onclick="history.back()">목록 바로가기</button>
		</div>
	</main>
</body>
</html>
