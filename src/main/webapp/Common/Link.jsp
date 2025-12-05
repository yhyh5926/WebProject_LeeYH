<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 페이지</title>
<style>
.header {
	width: 100%;
	background-color: yellowgreen;
	padding: 10px;
}

.header tr td {
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.header a {
	text-decoration: none;
	margin-left: 15px;
	font-size: 16px;
	font-weight: bold;
	color: white;
	transition: color 0.3s ease;
}

.header div {
	margin-right: 15px;
	color: white;
	font-weight: bold;
}

.header-login:hover {
	color: red;
}

.header-logout:hover {
	color: orange;
}

.header-board1:hover {
	color: yellow;
}

.header-board2:hover {
	color: blue;
}

.header-board3:hover {
	color: purple;
}
</style>
</head>
<body>
	<table class="header">
		<tr>
			<td>
				<%
				if (session.getAttribute("userId") == null) {
				%> <a href="<%=request.getContextPath()%>/sign/LoginForm.jsp"
				class="header-login">로그인</a> <%
 } else {
 %>
				<div>
					<%=session.getAttribute("userName")%>
					회원님, 로그인하셨습니다.
				</div> <a href="<%=request.getContextPath()%>/sign/Logout.jsp"
				class="header-logout">로그아웃</a> <%
 }
 %> <!-- 게시판 링크 --> <a href="<%=request.getContextPath()%>/index.jsp"
				class="header-board1">자유게시판</a> <a
				href="<%=request.getContextPath()%>/board/QnABoard.jsp"
				class="header-board2">QnA게시판</a> <a
				href="<%=request.getContextPath()%>/board/DataBoard.jsp"
				class="header-board3">자료게시판</a>
			</td>
		</tr>
	</table>
</body>
</html>