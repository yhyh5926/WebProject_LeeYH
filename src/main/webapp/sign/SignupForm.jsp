<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH - 회원가입</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Arial', sans-serif;
}

.container {
	max-width: 450px;
	margin: 80px auto;
	background-color: white;
	border: 2px solid mediumseagreen;
	border-radius: 12px;
	padding: 30px 25px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
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

/* 회원가입 폼 */
.signup-form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.signup-form .input-group {
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.signup-form label {
	font-weight: bold;
	color: mediumseagreen;
}

.signup-form input[type="text"], .signup-form input[type="password"],
	.signup-form input[type="email"] {
	padding: 10px 12px;
	border: 1px solid mediumseagreen;
	border-radius: 6px;
	font-size: 14px;
	transition: border 0.2s ease;
}

.signup-form input[type="text"]:focus, .signup-form input[type="password"]:focus,
	.signup-form input[type="email"]:focus {
	border-color: seagreen;
	outline: none;
}

.signup-btn {
	padding: 12px 20px;
	background-color: mediumseagreen;
	border: 1px solid mediumseagreen;
	border-radius: 6px;
	color: white;
	font-weight: bold;
	cursor: pointer;
	font-size: 16px;
	transition: all 0.2s ease-in-out;
}

.signup-btn:hover {
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

<script>
	function validateSignupForm(form) {
		if (!form.userId.value) {
			alert("아이디를 입력하세요.");
			form.userId.focus();
			return false;
		}
		if (!form.userPwd.value) {
			alert("비밀번호를 입력하세요.");
			form.userPwd.focus();
			return false;
		}
		if (!form.userName.value) {
			alert("이름을 입력하세요.");
			form.userName.focus();
			return false;
		}
		if (!form.userEmail.value) {
			alert("이메일을 입력하세요.");
			form.userEmail.focus();
			return false;
		}
		// 비밀번호 확인 체크
		if (form.userPwd.value !== form.userPwdConfirm.value) {
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			form.userPwdConfirm.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />

	<div class="container">
		<h2>회원가입</h2>

		<span class="error-msg"> <%=request.getAttribute("SignupErrMsg") == null ? "" : request.getAttribute("SignupErrMsg")%>
		</span>

		<form class="signup-form" action="SignupProcess.jsp" method="post"
			name="signupFrm" onsubmit="return validateSignupForm(this)">
			<div class="input-group">
				<label for="userId">아이디</label> <input type="text" name="userId"
					id="userId">
			</div>
			<div class="input-group">
				<label for="userName">이름</label> <input type="text" name="userName"
					id="userName">
			</div>
			<div class="input-group">
				<label for="userPwd">비밀번호</label> <input type="password"
					name="userPwd" id="userPwd">
			</div>
			<div class="input-group">
				<label for="userPwdConfirm">비밀번호 확인</label> <input type="password"
					name="userPwdConfirm" id="userPwdConfirm">
			</div>

			<input type="submit" class="signup-btn" value="회원가입">

			<div class="extra-actions">
				<button type="button" onclick="history.back()">뒤로가기</button>
				<button type="button" onclick="location.href='LoginForm.jsp'">로그인</button>
			</div>
		</form>
	</div>
</body>
</html>
