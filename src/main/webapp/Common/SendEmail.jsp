<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8" />
<title>이메일 전송</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', 'Arial', sans-serif;
	background: linear-gradient(135deg, #e0f7fa, #f9fff9);
	color: #333;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.container {
	max-width: 720px;
	width: 100%;
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 6px 25px rgba(0, 0, 0, 0.12);
	padding: 30px 25px;
	animation: fadeIn 0.6s ease-in-out;
}

h1 {
	text-align: center;
	color: mediumseagreen;
	margin-bottom: 25px;
	font-size: 28px;
	font-weight: bold;
}

label {
	display: block;
	margin: 12px 0 6px;
	font-weight: bold;
	color: seagreen;
	font-size: 14px;
}

input[type="text"], input[type="email"], textarea {
	width: 100%;
	padding: 12px 14px;
	border: 1px solid #cce0d6;
	border-radius: 8px;
	font-size: 15px;
	transition: all 0.25s ease;
}

input:focus, textarea:focus {
	border-color: mediumseagreen;
	box-shadow: 0 0 6px rgba(60, 179, 113, 0.4);
	outline: none;
}

textarea {
	height: 240px;
	resize: vertical;
}

.radio-group {
	display: flex;
	gap: 16px;
	margin-top: 6px;
}

.radio-group label {
	font-weight: normal;
	color: #444;
}

.actions {
	margin-top: 20px;
	text-align: center;
}

button {
	padding: 14px 22px;
	font-size: 16px;
	font-weight: bold;
	border: none;
	border-radius: 8px;
	background: mediumseagreen;
	color: white;
	cursor: pointer;
	transition: all 0.3s ease;
}

button:hover {
	background: seagreen;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(60, 179, 113, 0.4);
}

/* 반응형 */
@media ( max-width : 480px) {
	.container {
		padding: 20px;
	}
	h1 {
		font-size: 22px;
	}
	input, textarea, button {
		font-size: 14px;
	}
}

/* 애니메이션 */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<div class="container">
		<h1>임시 비밀번호 전송</h1>
		<form method="post" action="SendProcess.jsp" accept-charset="UTF-8">
			<input type="email" id="from" name="from" value="yhyh5926@naver.com"
				hidden /> <label for="userId">찾을 아이디</label> <input type="text"
				id="userId" name="userId" required /> <label for="to">등록한
				이메일 주소</label> <input type="email" id="to" name="to"
				placeholder="recipient@domain.com" required /> <input type="text"
				id="subject" name="subject" value="임시 비밀번호입니다." hidden /> <input
				type="radio" name="format" value="text" checked hidden />
			<textarea id="body" name="content" hidden></textarea>
			<div class="actions">
				<button type="submit">임시 비밀번호 받기</button>
				<button type="button" onclick="history.back()">뒤로 가기</button>
			</div>
		</form>
	</div>
</body>