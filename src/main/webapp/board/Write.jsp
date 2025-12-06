<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH</title>

<script type="text/javascript">
	function validateForm(form) { // 필수 항목 입력 확인
		if (form.title.value == "") {
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.content.value == "") {
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
	}
	// 이미지 미리보기 기능
	window.onload = function() {
		const fileInput = document.getElementById("ofile");
		const preview = document.getElementById("preview");

		fileInput.addEventListener("change",
				function() {
					const file = this.files[0];

					if (!file) {
						preview.src = "";
						preview.style.display = "none";
						return;
					}

					const ext = file.name
							.substring(file.name.lastIndexOf(".") + 1);
					const imgExts = [ "png", "jpg", "gif", "pcx", "bmp",
							"jepg", "sgv" ];

					if (imgExts.includes(ext)) {
						const reader = new FileReader();
						reader.onload = function(e) {
							preview.src = e.target.result;
							preview.style.display = "block";
						}
						reader.readAsDataURL(file);
					} else {
						preview.src = "";
						preview.style.display = "none";
					}
				});
	}

	function toggleFileInput() {
		const category = document.querySelector(".category").value;
		const fileRow = document.querySelector(".file-row");
		if (category === "data") {
			fileRow.style.display = "table-row";
		} else {
			fileRow.style.display = "none"
		}
	}
</script>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #f0f4f8;
	color: #333;
	font-family: 'Arial', sans-serif;
}

/* 페이지 제목 */
.write-title {
	text-align: center;
	color: mediumseagreen;
	font-size: 28px;
	font-weight: bold;
	padding: 20px 0;
}

/* 글쓰기 폼 */
.write-form {
	max-width: 900px;
	margin: 20px auto;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* 테이블 스타일 */
.write-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.write-table td {
	padding: 12px 10px;
	vertical-align: middle;
}

.write-table td:first-child {
	width: 150px;
	font-weight: bold;
	color: #555;
}

/* 입력 필드, 텍스트 영역, 셀렉트 */
.write-table input[type="text"], .write-table select, .write-table textarea,
	.write-table input[type="file"] {
	width: 100%;
	padding: 8px 10px;
	border: 1px solid mediumseagreen;
	border-radius: 5px;
	font-size: 14px;
	outline: none;
	transition: all 0.2s ease-in-out;
}

.write-table input[type="text"]:focus, .write-table textarea:focus,
	.write-table select:focus {
	border-color: seagreen;
	box-shadow: 0 0 5px rgba(46, 139, 87, 0.2); /* mediumseagreen 계열 그림자 */
}

.write-table textarea {
	min-height: 120px;
	resize: vertical;
}

/* 첨부파일 미리보기 */
#preview {
	display: block;
	max-width: 200px;
	margin-top: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

/* 버튼 영역 */
.write-buttons {
	text-align: center;
	margin-top: 10px;
}

.write-buttons button {
	padding: 8px 16px;
	margin: 0 5px;
	border-radius: 5px;
	font-weight: bold;
	font-size: 14px;
	cursor: pointer;
	transition: all 0.2s ease-in-out;
}

/* 작성 완료 버튼 */
.write-buttons button[type="submit"] {
	background-color: mediumseagreen;
	color: white;
	border: 1px solid mediumseagreen;
}

.write-buttons button[type="submit"]:hover {
	background-color: seagreen;
	border-color: seagreen;
}

/* 리셋 버튼 */
.write-buttons button[type="reset"] {
	background-color: coral;
	color: white;
	border: 1px solid coral;
}

.write-buttons button[type="reset"]:hover {
	background-color: orangered;
	border-color: orangered;
}

/* 목록 바로가기 버튼 */
.write-buttons button[type="button"] {
	background-color: steelblue;
	color: white;
	border: 1px solid steelblue;
}

.write-buttons button[type="button"]:hover {
	background-color: dodgerblue;
	border-color: dodgerblue;
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />
	<h2 class="write-title">파일 첨부형 게시판 - 글쓰기(Write)</h2>

	<form name="writeFrm" method="post" enctype="multipart/form-data"
		action="./Write.do?" onsubmit="return validateForm(this);"
		class="write-form">
		<table class="write-table">
			<tr>
				<td>카테고리</td>
				<td><select class="category" name="category"
					onchange="toggleFileInput()">
						<option value="free">자유게시판</option>
						<option value="qna">QnA게시판</option>
						<option value="data">자료게시판</option>
				</select></td>

			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr class="file-row" style="display: none">
				<td>첨부 파일</td>
				<td><input type="file" name="ofile" id="ofile" accept="image/*" />
					<br /> <!-- 미리보기 영역 --> <img id="preview" src="" alt="이미지 미리보기"
					style="max-width: 200px; margin-top: 10px; display: none; border: 1px solid #ccc;" />
				</td>
			</tr>
		</table>
		<div class="write-buttons">
			<button type="submit">작성 완료</button>
			<button type="reset">RESET</button>
			<button type="button" onclick="history.back();">목록 바로가기</button>
		</div>
	</form>
</body>
</html>