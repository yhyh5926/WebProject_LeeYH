<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebProject_LeeYH</title>

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

	// 이미지 미리보기 기능
	window.onload = function() {
		const fileInput = document.getElementById("ofile");
		const preview = document.getElementById("preview");

		fileInput.addEventListener("change", function() {
			const file = this.files[0];
			if (file) {
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
</script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.edit-title {
	color: orange;
	text-align: center;
	margin: 20px 0;
}

.edit-form {
	width: 90%;
	margin: 20px auto;
	border: 2px solid orange;
	border-radius: 8px;
	padding: 15px;
}

.edit-table {
	width: 100%;
	border-collapse: collapse;
}

.edit-table td {
	padding: 10px;
	border: 1px solid #ccc;
}

.edit-table input[type="text"], .edit-table textarea, .edit-table input[type="file"]
	{
	width: 95%;
	padding: 8px;
	border: 1px solid orange;
	border-radius: 5px;
}

.edit-buttons {
	text-align: center;
	margin-top: 15px;
}

.edit-buttons button {
	background-color: orange;
	color: white;
	padding: 8px 15px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin: 0 5px;
}

.edit-buttons button:hover {
	background-color: darkorange;
}
</style>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" />
	<h2 class="edit-title">파일 첨부형 게시판 - 수정하기(Edit)</h2>

	<form name="editFrm" method="post" enctype="multipart/form-data"
		action="../mvcboard/edit.do" onsubmit="return validateForm(this);"
		class="edit-form">

		<!-- 수정할 게시물의 일련번호 설정 -->
		<input type="hid den" name="idx" value="${ dto.idx }" />
		<!-- 게시물 작성자의 ID 설정 -->
		<input type="hid den" name="id" value="${ dto.id }" />
		<!-- 기존에 등록한 파일명(새로운 파일을 첨부하지 않는 경우 사용) -->
		<input type="hid den" name="prevOfile" value="${ dto.ofile }" /> <input
			type="hid den" name="prevSfile" value="${ dto.sfile }" />
		<!-- 이와 같이 hidden 타입의 입력상자는 웹브라우저에서는 표시되지 않아야 하지만
		서버로 전송은 되어야하는 값을 설정할 때 사용 -->

		<table class="edit-table">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${ dto.title }" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content">${ dto.content }</textarea></td>
			</tr>
			<tr>
				<td>첨부 파일</td>
				<td><input type="file" name="ofile" id="ofile" /> <br> <img
					id="preview" src="" alt="이미지 미리보기"
					style="max-width: 200px; margin-top: 10px; display: none; border: 1px solid #ccc;" />
				</td>
			</tr>
		</table>

		<div class="edit-buttons">
			<button type="submit">수정 완료</button>
			<button type="reset">RESET</button>
			<button type="button" onclick="location.href='../mvcboard/list.do';">목록
				바로가기</button>
		</div>
	</form>
</body>
</html>

