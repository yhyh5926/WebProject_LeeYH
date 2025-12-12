<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%
String category = request.getParameter("category") == null ? "free" : request.getParameter("category");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH - 수정하기(Edit)</title>

<script type="text/javascript">
	function validateForm(form) {
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

	window.onload = function() {
		const fileInput = document.getElementById("ofile");
		const preview = document.getElementById("preview");

		if (fileInput) {
			fileInput.addEventListener("change", function() {
				const file = this.files[0];
				if (!file) {
					preview.src = "";
					preview.style.display = "none";
					return;
				}
				const ext = file.name.substring(file.name.lastIndexOf(".") + 1)
						.toLowerCase();
				const imgExts = [ "png", "jpg", "jpeg", "gif", "bmp" ];
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
	}

	function toggleFileInput() {
		const category = document.querySelector(".category").value;
		const fileRow = document.querySelector(".file-row");
		if (category === "data") {
			fileRow.style.display = "table-row";
		} else {
			fileRow.style.display = "none";
		}
	}
</script>

<style>
/* 기존 스타일 그대로 사용 */
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

.write-title {
	text-align: center;
	color: mediumseagreen;
	font-size: 28px;
	font-weight: bold;
	padding: 20px 0;
}

.write-form {
	max-width: 900px;
	margin: 20px auto;
	padding: 20px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

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

.write-table input[type="text"], .write-table select, .write-table textarea,
	.write-table input[type="file"] {
	width: 100%;
	padding: 8px 10px;
	border: 1px solid mediumseagreen;
	border-radius: 5px;
	font-size: 14px;
	outline: none;
}

.write-table textarea {
	min-height: 120px;
	resize: vertical;
}

#preview {
	display: block;
	max-width: 200px;
	margin-top: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

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
}

.write-buttons button[type="submit"] {
	background: mediumseagreen;
	color: #fff;
	border: 1px solid mediumseagreen;
}

.write-buttons button[type="reset"] {
	background: coral;
	color: #fff;
	border: 1px solid coral;
}

.write-buttons button[type="button"] {
	background: steelblue;
	color: #fff;
	border: 1px solid steelblue;
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />
	<h2 class="write-title">게시글 수정(Edit)</h2>

	<form name="editFrm" method="post" enctype="multipart/form-data"
		action="./Edit.do" onsubmit="return validateForm(this);"
		class="write-form">
		<input type="hidden" name="pNum" value="${dto.pNum}" /> <input
			type="hidden" name="id" value="${dto.id}" />
		<table class="write-table">
			<tr>
				<td>카테고리</td>
				<td><select class="category" name="category"
					onchange="toggleFileInput()">
						<option value="free" ${dto.category eq 'free' ? 'selected' : ''}>자유게시판</option>
						<option value="qna" ${dto.category eq 'qna' ? 'selected' : ''}>QnA게시판</option>
						<option value="data" ${dto.category eq 'data' ? 'selected' : ''}>자료게시판</option>
				</select></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${dto.title}" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content">${dto.content}</textarea></td>
			</tr>
			<tr class="file-row"
				style="${dto.category eq 'data' ? '' : 'display:none'}">
				<td>첨부 파일</td>
				<td>
					<input type="file" name="ofile" id="ofile" accept="image/*" />
					<!-- 기존 파일명 hidden으로 전달 --> 
					<input type="hidden" name="prevOfile" value="${dto.ofile}" /> 
					<input type="hidden" name="prevSfile" value="${dto.sfile}" /> 
					<c:if test="${not empty dto.ofile}">
						<p>현재 첨부: ${dto.ofile}</p>
						<img id="preview" src="../Uploads/${dto.sfile}" alt="첨부 이미지"
							style="max-width: 200px; margin-top: 10px;" />
					</c:if> 
					<c:if test="${empty dto.ofile}">
						<img id="preview" src="" alt="이미지 미리보기"
							style="max-width: 200px; margin-top: 10px; display: none;" />
					</c:if></td>
			</tr>
		</table>

		<div class="write-buttons">
			<button type="submit">수정 완료</button>
			<button type="reset">RESET</button>
			<button type="button"
				onclick="location.href='./Board.do?category=<%=category%>'">목록
				바로가기</button>
		</div>
	</form>
</body>
</html>