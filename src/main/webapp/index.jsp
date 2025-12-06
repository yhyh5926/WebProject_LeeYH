<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH - 메인</title>

<style>
/* -------------------- 기본 초기화 -------------------- */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f5f7fa;
	color: #333;
	line-height: 1.6;
}

/* -------------------- 헤더 배너 -------------------- */
.header-banner {
	width: 100%;
	height: 250px;
	background-image:
		url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1470&q=80');
	/* 추천 이미지: Unsplash */
	background-size: cover;
	background-position: center;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 12px;
	margin-bottom: 30px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
}

.header-banner h1 {
	color: white;
	font-size: 42px;
	font-weight: 700;
	text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5);
}

/* -------------------- 메인 컨테이너 -------------------- */
.main-container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto 50px auto;
	display: flex;
	flex-direction: column;
	gap: 30px;
}

/* -------------------- 환영 메시지 카드 -------------------- */
.welcome-card {
	background-color: #fff;
	padding: 25px 30px;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
	text-align: center;
}

.welcome-card h2 {
	color: #27ae60;
	font-size: 32px;
	margin-bottom: 15px;
}

/* -------------------- 버튼 그룹 -------------------- */
.button-group {
	display: flex;
	justify-content: center;
	gap: 15px;
	flex-wrap: wrap;
	margin-top: 15px;
}

.button-group a {
	text-decoration: none;
	background-color: #27ae60;
	color: white;
	padding: 10px 20px;
	border-radius: 8px;
	font-weight: 600;
	transition: all 0.2s ease;
}

.button-group a:hover {
	background-color: #2ecc71;
	transform: translateY(-2px);
}

/* -------------------- 이미지 추천 섹션 -------------------- */
.featured-section {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 20px;
}

.featured-card {
	flex: 1 1 250px;
	background-color: #fff;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
	overflow: hidden;
	transition: transform 0.2s ease;
}

.featured-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

.featured-card .card-content {
	padding: 15px;
}

.featured-card .card-content h3 {
	font-size: 20px;
	color: #27ae60;
	margin-bottom: 10px;
}

.featured-card .card-content p {
	font-size: 14px;
	color: #555;
}

.featured-card:hover {
	transform: translateY(-5px);
}

/* -------------------- 반응형 -------------------- */
@media ( max-width : 768px) {
	.featured-section {
		flex-direction: column;
	}
	.header-banner h1 {
		font-size: 32px;
	}
}
</style>
</head>
<body>
	<jsp:include page="./Common/Link.jsp" />

	<!-- 헤더 배너 -->
	<div class="header-banner">
		<h1>환영합니다, WebProject_LeeYH</h1>
	</div>

	<div class="main-container">
		<!-- 환영 메시지 카드 -->
		<div class="welcome-card">
			<h2>오늘도 즐거운 게시판 활동을 시작해보세요!</h2>
			<p>게시판 글 작성, 검색, 다운로드 등 다양한 기능을 활용해보세요.</p>

			<div class="button-group">
				<a href="./board/Board.do?category=free">자유게시판</a> <a
					href="./board/Board.do?category=qna">QnA게시판</a> <a
					href="./board/Board.do?category=data">자료게시판</a>
			</div>
		</div>

		<!-- 추천 이미지/컨텐츠 섹션 -->
		<div class="featured-section">
			<div class="featured-card">
				<img
					src="https://images.unsplash.com/photo-1517816743773-6e0fd518b4a6?auto=format&fit=crop&w=800&q=80"
					alt="추천 이미지1">
				<div class="card-content">
					<h3>새로운 기능 안내</h3>
					<p>최근 업데이트된 게시판 기능을 확인하고 이용해보세요.</p>
				</div>
			</div>
			<div class="featured-card">
				<img
					src="https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=80"
					alt="추천 이미지2">
				<div class="card-content">
					<h3>자료 공유</h3>
					<p>다양한 학습 자료와 참고 자료를 자유롭게 확인하고 다운로드할 수 있습니다.</p>
				</div>
			</div>
			<div class="featured-card">
				<img
					src="https://images.unsplash.com/photo-1485217988980-11786ced9454?auto=format&fit=crop&w=800&q=80"
					alt="추천 이미지3">
				<div class="card-content">
					<h3>QnA 지원</h3>
					<p>질문과 답변을 통해 효율적으로 학습하고 정보를 공유할 수 있습니다.</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
