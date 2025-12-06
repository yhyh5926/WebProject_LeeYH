<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH - 로그인</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.container {
	max-width: 400px;
	margin: 100px auto;
	background-color: white;
	border: 2px solid mediumseagreen;
	border-radius: 12px;
	padding: 30px 25px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
	background-color: white;
}

h2 {
	text-align: center;
	color: mediumseagreen;
	margin-bottom: 20px;
	font-size: 28px;
	font-weight: bold;
}

.error-msg {
	color: red;
	text-align: center;
	margin-bottom: 15px;
	font-size: 1em;
}

/* 로그인 폼 */
.login-form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.login-form .input-group {
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.login-form label {
	font-weight: bold;
	color: mediumseagreen;
}

.login-form input[type="text"], .login-form input[type="password"] {
	padding: 10px 12px;
	border: 1px solid mediumseagreen;
	border-radius: 6px;
	font-size: 14px;
	transition: border 0.2s ease;
}

.login-form input[type="text"]:focus, .login-form input[type="password"]:focus
	{
	border-color: seagreen;
	outline: none;
}

.login-btn {
	padding: 10px 20px;
	background-color: mediumseagreen;
	border: 1px solid mediumseagreen;
	border-radius: 6px;
	color: white;
	font-weight: bold;
	cursor: pointer;
	font-size: 16px;
	transition: all 0.2s ease-in-out;
}

.login-btn:hover {
	background-color: seagreen;
	border-color: seagreen;
}

.extra-actions {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
}

.extra-actions button {
	padding: 8px 14px;
	border-radius: 5px;
	border: 1px solid #ccc;
	background-color: #eee;
	cursor: pointer;
	transition: all 0.2s ease;
}

.extra-actions button:hover {
	background-color: #ddd;
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />
	<div class="container">
		<h2>로그인 페이지</h2>

		<span class="error-msg"> <%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg")%>
		</span>

		<%
		if (session.getAttribute("UserId") == null) {
		%>
		<script>
			function validateForm(form) {
				if (!form.userId.value) {
					alert("아이디를 입력하세요.");
					form.userId.focus();
					return false;
				}
				if (!form.userPwd.value) {
					alert("패스워드를 입력하세요");
					form.userPwd.focus();
					return false;
				}
			}
		</script>

		<form class="login-form" action="./LoginProcess.jsp" method="post"
			name="loginFrm" onsubmit="return validateForm(this)">
			<div class="input-group">
				<label for="userId">아이디</label> <input type="text" name="userId"
					id="userId" />
			</div>
			<div class="input-group">
				<label for="userPwd">패스워드</label> <input type="password"
					name="userPwd" id="userPwd" />
			</div>
			<input type="submit" class="login-btn" value="로그인하기" />

			<div class="extra-actions">
				<button type="button" onclick="history.back()">뒤로가기</button>
				<button type="button" onclick="location.href='./SignupForm.jsp'">회원가입</button>
			</div>
		</form>
		<%
		}
		%>
	</div>
</body>
</html>
