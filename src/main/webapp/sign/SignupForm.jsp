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

.signup-form {
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

#userId {
	width: 75%;
}

.input-group input:focus, .input-group select:focus {
	border-color: mediumseagreen;
	box-shadow: 0 0 6px rgba(60, 179, 113, 0.4);
	outline: none;
}

/* 중복확인 버튼 스타일 */
.input-group button {
	padding: 10px 16px;
	border-radius: 6px;
	border: none;
	background-color: #4caf50; /* 기본 초록색 */
	color: white;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.25s ease;
}

.input-group button:hover {
	background-color: #43a047; /* hover 시 더 진한 초록 */
	transform: translateY(-2px);
	box-shadow: 0 3px 8px rgba(76, 175, 80, 0.4);
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

.signup-btn {
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

.signup-btn:hover {
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
<script>
function checkDuplicateId() {
    const userId = document.getElementById("userId").value;
    const msg = document.getElementById("idCheckMsg");

    if (!userId) {
        alert("아이디를 입력하세요.");
        return;
    }

    fetch("<%=request.getContextPath()%>/CheckId.do?userId=" + encodeURIComponent(userId))
        .then(response => response.json())
        .then(data => {
            if (data.exists) {
                msg.innerText = "이미 사용 중인 아이디입니다.";
                msg.className = "error";
            } else {
                msg.innerText = "사용 가능한 아이디입니다.";
                msg.className = "success";
            }
        })
        .catch(err => console.error(err));
}


</script>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"></jsp:include>
	<div class="container">
		<h2>회원가입</h2>
		<span class="error-msg"> <%=request.getAttribute("SignupErrMsg") == null ? "" : request.getAttribute("SignupErrMsg")%>
		</span>

		<form class="signup-form" action="./SignupProcess.jsp" method="post"
			name="signupFrm">
			<div class="input-group">
				<label for="userId">아이디</label>
				<div style="display: flex; gap: 6px;">
					<input type="text" name="userId" id="userId" required>
					<button type="button" onclick="checkDuplicateId()">중복확인</button>
				</div>
				<span id="idCheckMsg" style="font-size: 13px; color: crimson;"></span>
			</div>

			<div class="input-group">
				<label for="userName">이름</label> <input type="text" name="userName"
					id="userName" required>
			</div>

			<div class="input-group">
				<label for="userPwd">비밀번호</label> <input type="password"
					name="userPwd" id="userPwd" required>
			</div>

			<div class="input-group">
				<label for="userPwdConfirm">비밀번호 확인</label> <input type="password"
					name="userPwdConfirm" id="userPwdConfirm" required>
			</div>

			<div class="input-group">
				<label for="userEmail">이메일</label>
				<div class="email-group">
					<input type="text" name="emailId" id="emailId" placeholder="이메일 입력"
						required> <span>@</span> 
					<select name="emailDomain" id="emailDomain">
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="직접입력">직접입력</option>
					</select>
				</div>
				<input type="text" name="emailCustom" id="emailCustom"
					placeholder="직접 입력" style="display: none;">
			</div>

			<div class="input-group">
				<label for="userPhone">전화번호</label>
				<div class="phone-group">
					<input type="text" name="phone1" id="phone1" maxlength="3"
						placeholder="010" required> <input type="text"
						name="phone2" id="phone2" maxlength="4" placeholder="1234"
						required> <input type="text" name="phone3" id="phone3"
						maxlength="4" placeholder="5678" required>
				</div>
			</div>

			<input type="submit" class="signup-btn" value="회원가입">

			<div class="extra-actions">
				<button type="button" onclick="history.back()">뒤로가기</button>
				<button type="button" onclick="location.href='LoginForm.jsp'">로그인</button>
			</div>
		</form>
	</div>

	<script>
	// 이메일 도메인 처리
    document.getElementById("emailDomain").addEventListener("change", function() {
        if (this.value === "직접입력") {
            document.getElementById("emailCustom").style.display = "block";
        } else {
            document.getElementById("emailCustom").style.display = "none";
        }
    });

    // 비밀번호 확인 체크
    document.querySelector(".signup-form").addEventListener("submit", function(e) {
        const pwd = document.getElementById("userPwd").value;
        const pwdConfirm = document.getElementById("userPwdConfirm").value;

        if (pwd !== pwdConfirm) {
            e.preventDefault(); // 폼 제출 막기
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            document.getElementById("userPwdConfirm").focus();
        }
    });

	</script>
</body>
</html>