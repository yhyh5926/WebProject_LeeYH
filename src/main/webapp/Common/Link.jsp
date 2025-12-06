<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 요청 파라미터로 카테고리 받기
String category = request.getParameter("category");
if (category == null)
	category = "free"; // 기본값
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메뉴 페이지</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Arial', sans-serif;
}

/* -------------------- 헤더 -------------------- */
.header {
	width: 100%;
	padding: 12px 20px;
	display: flex;
	align-items: center;
	gap: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	position: sticky;
	top: 0;
	z-index: 1000;
	transition: background-color 0.3s ease;
}

/* 카테고리별 배경색 */
.header-free {
	background-color: mediumseagreen;
}

.header-qna {
	background-color: steelblue;
}

.header-data {
	background-color: purple;
}

/* 홈 버튼 */
.header-home {
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: white;
	padding: 6px 12px;
	border-radius: 5px;
	transition: all 0.3s ease;
}

.header-home:hover {
	background-color: #4caf50;
	transform: translateY(-2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

/* 오른쪽 메뉴 그룹 */
.header-right {
	margin-left: auto;
	display: flex;
	gap: 10px;
	align-items: center;
}

/* 로그인/로그아웃 */
.header-login, .header-logout {
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: white;
	padding: 6px 10px;
	border-radius: 5px;
	transition: all 0.3s ease;
}

.header-login:hover {
	background-color: #f44336;
} /* 빨강 */
.header-logout:hover {
	background-color: #ff9800;
} /* 주황 */

/* 게시판 버튼 */
.header-board1, .header-board2, .header-board3 {
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: white;
	padding: 6px 10px;
	border-radius: 5px;
	transition: all 0.3s ease;
}

.header-board1:hover {
	background-color: #ffeb3b;
	color: #333;
} /* 노랑 */
.header-board2:hover {
	background-color: #2196f3;
} /* 파랑 */
.header-board3:hover {
	background-color: #9c27b0;
} /* 보라 */

/* 사용자 이름 */
.user-info {
	color: white;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="header <%="header-" + category%>">
		<!-- 홈 버튼 -->
		<a href="<%=request.getContextPath()%>/" class="header-home">홈</a>

		<!-- 오른쪽 메뉴 -->
		<div class="header-right">
			<%
			if (session.getAttribute("userId") == null) {
			%>
			<a href="<%=request.getContextPath()%>/sign/LoginForm.jsp"
				class="header-login">로그인</a>
			<%
			} else {
			%>
			<div class="user-info"><%=session.getAttribute("userName")%>
				회원님
			</div>
			<a href="<%=request.getContextPath()%>/sign/Logout.jsp"
				class="header-logout">로그아웃</a>
			<%
			}
			%>

			<!-- 게시판 링크 -->
			<a href="<%=request.getContextPath()%>/board/Board.do?category=free"
				class="header-board1">자유게시판</a> <a
				href="<%=request.getContextPath()%>/board/Board.do?category=qna"
				class="header-board2">QnA게시판</a> <a
				href="<%=request.getContextPath()%>/board/Board.do?category=data"
				class="header-board3">자료게시판</a>
		</div>
	</div>
</body>
</html>
