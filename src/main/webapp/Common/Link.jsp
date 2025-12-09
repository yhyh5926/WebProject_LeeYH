<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String category = request.getParameter("category");
if (category == null)
	category = "free";

String userId = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie c : cookies) {
		if ("userId".equals(c.getName())) {
	userId = c.getValue();
	break;
		}
	}
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메뉴 페이지</title>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
	justify-content: space-around;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	position: sticky;
	top: 0;
	z-index: 1000;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.header-free {
	background: mediumseagreen;
}

.header-qna {
	background: steelblue;
}

.header-data {
	background: purple;
}

/* 네비게이션 */
nav ul {
	list-style: none;
	display: flex;
}

nav ul li a {
	text-decoration: none;
	font-size: 15px;
	font-weight: bold;
	color: white;
	padding: 8px 14px;
	border-radius: 6px;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s ease;
}

nav ul li a:hover {
	background: rgba(255, 255, 255, 0.2);
	transform: translateY(-2px);
}

/* 사용자 메뉴 */
.user-menu {
	display: flex;
	align-items: center;
	gap: 15px;
}

.user-info {
	color: white;
	font-weight: bold;
}

.user-menu a {
	text-decoration: none;
	font-size: 14px;
	font-weight: bold;
	color: white;
	padding: 6px 10px;
	border-radius: 5px;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	gap: 6px;
}

.user-menu a:hover {
	background: rgba(255, 255, 255, 0.25);
}

/* 햄버거 버튼 */
.menu-toggle {
	display: none;
	font-size: 22px;
	color: white;
	cursor: pointer;
}

/* -------------------- 반응형 -------------------- */
@media ( max-width : 768px) {
	nav ul {
		flex-direction: column;
		background: rgba(0, 0, 0, 0.8);
		position: absolute;
		top: 60px;
		left: 0;
		width: 100%;
		padding: 10px 0;
		display: none;
	}
	nav ul.show {
		display: flex;
	}
	.menu-toggle {
		display: block;
	}
	.user-menu * {
		font-size: 0.9rem;
	}
}
</style>
</head>
<body>
	<div class="header <%="header-" + category%>">

		<nav>
			<ul id="nav-links">
				<!-- 홈 버튼 -->
				<li class="menu-toggle" onclick="toggleMenu()"><i
					class="fa-solid fa-bars"></i></li>

				<li><a href="<%=request.getContextPath()%>/"><i
						class="fa-solid fa-house"></i> 홈</a></li>
				<li><a
					href="<%=request.getContextPath()%>/board/Board.do?category=free"><i
						class="fa-solid fa-comments"></i> 자유게시판</a></li>
				<li><a
					href="<%=request.getContextPath()%>/board/Board.do?category=qna"><i
						class="fa-solid fa-circle-question"></i> QnA게시판</a></li>
				<li><a
					href="<%=request.getContextPath()%>/board/Board.do?category=data"><i
						class="fa-solid fa-folder-open"></i> 자료게시판</a></li>
			</ul>
		</nav>

		<!-- 사용자 메뉴 -->
		<div class="user-menu">
			<%
			if (session.getAttribute("userId") == null) {
			%>
			<a href="<%=request.getContextPath()%>/sign/LoginForm.jsp"><i
				class="fa-solid fa-right-to-bracket"></i> 로그인</a>
			<%
			} else {
			%>
			<div class="user-info">
				<i class="fa-solid fa-user"></i>
				<%=session.getAttribute("userName")%>
				회원님
			</div>
			<a href="<%=request.getContextPath()%>/sign/UpdateForm.do"><i
				class="fa-solid fa-user-gear"></i> 회원정보 수정</a> <a
				href="<%=request.getContextPath()%>/sign/Logout.jsp"><i
				class="fa-solid fa-right-from-bracket"></i> 로그아웃</a>
			<%
			}
			%>
		</div>
	</div>

	<script>
		function toggleMenu() {
			const nav = document.getElementById("nav-links");
			const toggleIcon = document.querySelector(".menu-toggle i");

			nav.classList.toggle("show");

			if (nav.classList.contains("show")) {
				// 메뉴가 열렸을 때 → X 아이콘
				toggleIcon.classList.remove("fa-bars");
				toggleIcon.classList.add("fa-xmark");
			} else {
				// 메뉴가 닫혔을 때 → 햄버거 아이콘
				toggleIcon.classList.remove("fa-xmark");
				toggleIcon.classList.add("fa-bars");
			}
		}
	</script>

</body>
</html>