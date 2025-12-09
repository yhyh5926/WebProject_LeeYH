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
	background-color: #f5f6fa;
	font-family: 'Arial', sans-serif;
	color: #333;
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

/* -------------------- 헤더 -------------------- */
header {
	text-align: center;
	padding: 30px 0;
}

header h1 {
	font-size: 32px;
	font-weight: bold;
	color: var(--color-primary);
	border-bottom: 3px solid var(--color-primary);
	display: inline-block;
	padding-bottom: 5px;
}

/* -------------------- 게시글 카드 -------------------- */
.article-card {
	max-width: 900px;
	margin: 20px auto;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
	padding: 25px 30px;
}

/* -------------------- 글 정보 -------------------- */
.article-meta {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	border-bottom: 1px solid #e0e0e0;
	padding-bottom: 15px;
	margin-bottom: 20px;
	font-size: 15px;
	color: #555;
}

.meta-item {
	flex: 1 1 45%;
	margin-bottom: 8px;
}

.meta-item span:first-child {
	font-weight: bold;
	color: #777;
}

/* -------------------- 제목 -------------------- */
.article-title {
	font-size: 26px;
	font-weight: bold;
	color: var(--color-primary);
	margin-bottom: 15px;
}

/* -------------------- 내용 -------------------- */
.article-content {
	background: #f9fafc;
	padding: 20px;
	border-radius: 8px;
	min-height: 200px;
	white-space: pre-line;
	box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.05);
}

/* -------------------- 첨부파일 -------------------- */
.media-container {
	margin-top: 15px;
}

.media-container img, .media-container video, .media-container audio {
	max-width: 100%;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.attachment {
	margin-top: 10px;
	font-size: 14px;
}

.attachment::before {
	content: "📎 ";
}

.attachment a {
	color: var(--color-primary);
	font-weight: bold;
	text-decoration: none;
}

.attachment a:hover {
	text-decoration: underline;
}

/* -------------------- 버튼 그룹 -------------------- */
.button-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 20px;
}

.button-group button {
	padding: 10px 18px;
	border: none;
	border-radius: 6px;
	background: var(--color-primary);
	color: #fff;
	font-weight: bold;
	cursor: pointer;
	transition: background 0.2s ease;
}

.button-group button:hover {
	background: var(--color-primary-dark);
}

/* -------------------- 좋아요 -------------------- */
.like-button {
	background: none;
	border: none;
}

.fa-heart {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 20px;
	transition: transform 0.2s ease, color 0.3s ease;
}

.fa-heart:hover {
	transform: scale(1.2);
}

.fa-heart {
	color: #e74c3c;
}
</style>
</head>
<body class="category-<%=category%>">
	<jsp:include page="../Common/Link.jsp" />

	<header>
		<h1>게시판 상세보기</h1>
	</header>

	<main>
		<article class="article-card">
			<!-- 글 정보 -->
			<div class="article-meta">
				<div class="meta-item">
					<span>번호</span> <span>${dto.pNum}</span>
				</div>
				<div class="meta-item">
					<span>작성자</span> <span>${dto.name}</span>
				</div>
				<div class="meta-item">
					<span>작성일</span> <span>${dto.postDate}</span>
				</div>
				<div class="meta-item">
					<span>조회수</span> <span>${dto.visitCount}</span>
				</div>
			</div>

			<!-- 제목 -->
			<div class="article-title">${dto.title}</div>

			<!-- 내용 -->
			<div class="article-content">
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

			<!-- 좋아요 수 -->
			<div style="color: red; text-align: right; margin-top: 20px;">
				<span class="like-count">좋아요 ${dto.likeCount}</span>
				<c:if test="${not empty userId}">
					<c:choose>
						<c:when test="${dto.likedByUser}">
							<button type="button" class="like-button" data-pnum="${dto.pNum}">
								<i class="fa-solid fa-heart liked"></i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="like-button" data-pnum="${dto.pNum}">
								<i class="fa-regular fa-heart"></i>
							</button>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>


			<!-- 버튼 그룹 -->
			<div class="button-group">
				<c:if test="${not empty userId and sessionScope.userId eq dto.id}">
					<button type="button"
						onclick="location.href='./Edit.do?categoty=<%=category%>&pNum=${dto.pNum}'">
						수정하기</button>
					<button type="button"
						onclick="if(confirm('정말 삭제하시겠습니까?')) 
             				location.href='./Delete.do?category=<%=category%>&pNum=${dto.pNum}'">
						삭제하기</button>

				</c:if>
				<button type="button"
					onclick="location.href='./Board.do?category=<%=category%>'">목록
					바로가기</button>
			</div>

		</article>
	</main>

	<%
	if (category.equals("qna")) {
	%>
	<jsp:include page="../comments/List.jsp"></jsp:include>
	<%
	}
	%>
	<script>
	document.addEventListener("DOMContentLoaded", function() {
		  document.addEventListener("click", function(e) {
		    if (e.target.closest(".like-button")) {
		      const btn = e.target.closest(".like-button");
		      const pNum = btn.getAttribute("data-pnum");

		      fetch("./Like.do?pNum=" + pNum, { method: "POST" })
		        .then(res => res.json())
		        .then(data => {
		          if (data.success) {
		            const icon = btn.querySelector("i");
		            if (data.liked) {
		              icon.classList.remove("fa-regular");
		              icon.classList.add("fa-solid", "liked");
		            } else {
		              icon.classList.remove("fa-solid", "liked");
		              icon.classList.add("fa-regular");
		            }  
		            // 좋아요 수 갱신
		            const likeCountSpan = btn.parentElement.querySelector(".like-count");
		            likeCountSpan.textContent = "좋아요 " + data.likeCount;

		          } else {
		            alert(data.message);
		          }
		        });
		    }
		  });
		});
	
	
	</script>
</body>
</html>