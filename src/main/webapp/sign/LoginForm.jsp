<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

h2 {
	text-align: center;
}

.login-form {
	margin: 0 auto;
	display: flex;
	max-width: 300px;
	flex-direction: column;
	align-items: center;
	border-radius: 20px;
	padding: 30px;
	background-color: yellowgreen;
	border-radius: 20px;
	max-width: 300px;
	border-radius: 20px;
	display: flex;
}

span {
	display: inline-block;
	width: 200px;
	color: white;
	width: 70px;
}

.login-btn {
	margin-top: 30px;
	background-color: skyblue;
	border-radius: 10px;
	padding: 5px 15px;
	font-weight: bold;
	color: white;
	background-color: skyblue;
	cursor: pointer;
}

.login-btn:hover {
	background-color: blue;
}
</style>
</head>
<body>
	<!-- 
JSP에서 인클루드는 2가지 방식이 있다.
1. include 지시어를 이용한 방법
2. 액션 태그를 사용하는 방법
 -->
	<jsp:include page="../Common/Link.jsp" />
	<h2>로그인 페이지</h2>

	<!-- 로그인을 위해 폼값을 전송한 후 만약 조건에 맞는 회원정보가 없다면 
	request 영역에 에러 메시지를 저장한 후 현재 페이지로 forward 할 것이다.
	request 영역은 forward된 페이지까지는 데이터를 공유하므로 아래 메시지를 출력할 수 있다.
	 -->
	<span style="color: red; font-size: 1.2em"> <%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg")%>
	</span>
	<%
	if (session.getAttribute("UserId") == null) {
		//로그아웃 상태
	%>
	<script>
		function validateForm(form) {
			if (!form.user_id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (form.user_pw.value == "") {
				alert("패스워드를 입력하세요")
				return false;
			}
		}
	</script>

	<form class="login-form" action="LoginProcess.jsp" method="post"
		name="loginFrm" onsubmit="return validateForm(this)">
		<div>
			<span>아이디</span><input type="text" name="userId" />
		</div>
		<div>
			<span>패스워드</span><input type="password" name="userPwd" />
		</div>
		<input class="login-btn" type="submit" value="로그인하기" /><br />
	</form>

	<%
	}
	%>
</body>
</html>