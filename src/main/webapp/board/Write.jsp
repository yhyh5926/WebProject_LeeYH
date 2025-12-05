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

.category {
	padding: 8px;
	border: 1px solid yellowgreen;
	border-radius: 5px;
}

.write-title {
	color: yellowgreen;
	text-align: center;
	margin: 20px 0;
}

.write-form {
	width: 90%;
	margin: 20px auto;
	border: 2px solid yellowgreen;
	border-radius: 8px;
	padding: 15px;
}

.write-table {
	width: 100%;
	border-collapse: collapse;
}

.write-table td {
	padding: 10px;
	border: 1px solid #ccc;
}

.write-table input[type="text"], .write-table textarea, .write-table input[type="file"]
	{
	width: 95%;
	padding: 8px;
	border: 1px solid yellowgreen;
	border-radius: 5px;
}

.write-buttons {
	text-align: center;
	margin-top: 15px;
}

.write-buttons button {
	background-color: yellowgreen;
	color: white;
	padding: 8px 15px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin: 0 5px;
}

.write-buttons button:hover {
	background-color: green;
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />
	<h2 class="write-title">파일 첨부형 게시판 - 글쓰기(Write)</h2>

	<form name="writeFrm" method="post" enctype="multipart/form-data"
		action="../board/write.do" onsubmit="return validateForm(this);"
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
			<button type="button"
				onclick="location.href='/WebProject_LeeYH/index.jsp';">목록
				바로가기</button>
		</div>
	</form>
</body>
</html>