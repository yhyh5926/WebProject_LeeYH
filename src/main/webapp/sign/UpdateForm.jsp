<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO"%>
<%
MemberDTO member = (MemberDTO) request.getAttribute("member");

// 전화번호 분리
String phone1 = "";
String phone2 = "";
String phone3 = "";
if (member.getPhone() != null && member.getPhone().contains("-")) {
	String[] phoneParts = member.getPhone().split("-");
	if (phoneParts.length == 3) {
		phone1 = phoneParts[0];
		phone2 = phoneParts[1];
		phone3 = phoneParts[2];
	}
}

// 이메일 분리
String emailId = "";
String emailDomain = "";
if (member.getEmail() != null && member.getEmail().contains("@")) {
	String[] emailParts = member.getEmail().split("@");
	if (emailParts.length == 2) {
		emailId = emailParts[0];
		emailDomain = emailParts[1];
	}
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH - 회원정보 수정</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', 'Arial', sans-serif;
	background: linear-gradient(135deg, #e0f7e9, #f9fff9);
	color: #333;
}

.container {
	max-width: 480px;
	margin: 10px auto;
	background-color: #fff;
	border-radius: 16px;
	padding: 40px 30px;
	box-shadow: 0 6px 25px rgba(0, 0, 0, 0.12);
}

h2 {
	text-align: center;
	color: mediumseagreen;
	margin-bottom: 25px;
	font-size: 28px;
	font-weight: bold;
}

.error-msg {
	color: crimson;
	text-align: center;
	margin-bottom: 15px;
	font-size: 0.95em;
}

.update-form {
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.input-group {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.input-group label {
	font-weight: bold;
	color: seagreen;
	font-size: 14px;
}

.input-group input, .input-group select {
	width: 100%;
	padding: 12px 14px;
	border: 1px solid #cce0d6;
	border-radius: 8px;
	font-size: 15px;
	transition: all 0.25s ease;
}

.input-group input:focus, .input-group select:focus {
	border-color: mediumseagreen;
	box-shadow: 0 0 6px rgba(60, 179, 113, 0.4);
	outline: none;
}

/* 이메일 그룹 */
.email-group {
	display: grid;
	grid-template-columns: 1fr auto 1fr;
	gap: 6px;
	align-items: center;
}

/* 전화번호 그룹 */
.phone-group {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	gap: 6px;
}

.update-btn {
	padding: 14px 22px;
	background: mediumseagreen;
	border: none;
	border-radius: 8px;
	color: white;
	font-weight: bold;
	cursor: pointer;
	font-size: 17px;
	transition: all 0.3s ease;
}

.update-btn:hover {
	background: seagreen;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(60, 179, 113, 0.4);
}

.extra-actions {
	display: flex;
	justify-content: space-between;
	margin-top: 15px;
}

.extra-actions button {
	padding: 10px 16px;
	border-radius: 6px;
	border: 1px solid #ccc;
	background-color: #f5f5f5;
	cursor: pointer;
	transition: all 0.25s ease;
	font-size: 14px;
}

.extra-actions button:hover {
	background-color: #e0e0e0;
	transform: translateY(-1px);
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"></jsp:include>
	<div class="container">
		<h2>회원정보 수정</h2>
		<span class="error-msg"> <%=request.getAttribute("UpdateErrMsg") == null ? "" : request.getAttribute("UpdateErrMsg")%>
		</span>

		<form class="update-form" action="./UpdateProcess.jsp" method="post"
			name="updateFrm">
			<div class="input-group">
				<label for="userId">아이디</label> <input type="text" name="userId"
					id="userId" value="<%=member.getId()%>" readonly>
			</div>

			<div class="input-group">
				<label for="userName">이름</label> <input type="text" name="userName"
					id="userName" value="<%=member.getName()%>">
			</div>

			<div class="input-group">
				<label for="userPwd">새 비밀번호</label> <input type="password"
					name="userPwd" id="userPwd">
			</div>

			<div class="input-group">
				<label for="userPwdConfirm">비밀번호 확인</label> <input type="password"
					name="userPwdConfirm" id="userPwdConfirm">
			</div>

			<!-- 이메일 -->
			<div class="input-group">
				<label for="userEmail">이메일</label>
				<div class="email-group">
					<input type="text" name="emailId" id="emailId" value="<%=emailId%>">
					<span>@</span> <select name="emailDomain" id="emailDomain">
						<option value="naver.com"
							<%="naver.com".equals(emailDomain) ? "selected" : ""%>>naver.com</option>
						<option value="gmail.com"
							<%="gmail.com".equals(emailDomain) ? "selected" : ""%>>gmail.com</option>
						<option value="daum.net"
							<%="daum.net".equals(emailDomain) ? "selected" : ""%>>daum.net</option>
						<option value="직접입력">직접입력</option>
					</select>
				</div>
				<input type="text" name="emailCustom" id="emailCustom"
					placeholder="직접 입력" style="display: none;">
			</div>

			<!-- 전화번호 -->
			<div class="input-group">
				<label for="userPhone">전화번호</label>
				<div class="phone-group">
					<input type="text" name="phone1" id="phone1" maxlength="3"
						value="<%=phone1%>"> <input type="text" name="phone2"
						id="phone2" maxlength="4" value="<%=phone2%>"> <input
						type="text" name="phone3" id="phone3" maxlength="4"
						value="<%=phone3%>">
				</div>
			</div>

			<input type="submit" class="update-btn" value="정보 수정">

			<div class="extra-actions">
				<button type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</form>
	</div>

	<script>
		document
				.getElementById("emailDomain")
				.addEventListener(
						"change",
						function() {
							if (this.value === "직접입력") {
								document.getElementById("emailCustom").style.display = "block";
							} else {
								document.getElementById("emailCustom").style.display = "none";
							}
						});
	</script>
</body>
</html>