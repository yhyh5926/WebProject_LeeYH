<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
<style>
/* ===== 댓글 작성 폼 ===== */
form {
	background: #fff;
	padding: 25px 30px;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	max-width: 900px;
	margin: 20px auto;
	font-family: "Segoe UI", Arial, sans-serif;
}

textarea {
	width: 100%;
	height: 120px;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 6px;
	resize: none;
	font-size: 14px;
	transition: border-color 0.3s;
}

textarea:focus {
	border-color: #0078d7;
	outline: none;
}

.write-buttons {
	display: flex;
	justify-content: flex-end;
	margin-top: 15px;
	gap: 10px;
}

.write-buttons button {
	padding: 10px 20px;
	border: none;
	border-radius: 6px;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.2s;
}

.write-buttons button[type="submit"] {
	background-color: #0078d7;
	color: #fff;
}

.write-buttons button[type="submit"]:hover {
	background-color: #005fa3;
	transform: translateY(-2px);
}

.write-buttons button[type="reset"] {
	background-color: #e0e0e0;
	color: #333;
}

.write-buttons button[type="reset"]:hover {
	background-color: #c7c7c7;
	transform: translateY(-2px);
}

/* ===== 댓글 리스트와 동일한 구조 ===== */
.comment-item {
	border-bottom: 1px solid #eee;
	padding: 12px 0;
}

.comment-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 14px;
	margin-bottom: 6px;
}

.comment-author {
	font-weight: 600;
	color: #333;
}

.comment-id {
	color: #666;
	margin-left: 4px;
}

.comment-date {
	margin-left: auto;
	font-size: 13px;
	color: #999;
}

.comment-content {
	font-size: 15px;
	color: #444;
	line-height: 1.5;
	white-space: pre-line;
}
</style>
</head>

<body>
	<!-- 댓글 작성 폼 -->
	<%
	if (session.getAttribute("userId") != null) {
	%>
	<form id="commentForm">
		<input type="hidden" name="category" value="${dto.category}">
		<input type="hidden" name="pNum" value="${dto.pNum}">
		<textarea name="content" placeholder="댓글을 입력하세요"></textarea>
		<div class="write-buttons">
			<button type="submit">등록</button>
			<button type="reset">RESET</button>
		</div>
	</form>
	<%
	}
	%>

</body>

<script>

function writeComment(pNum) {
	  const form = document.querySelector("#commentForm");

	  
	  form.addEventListener("submit", (e) => {
	    e.preventDefault();

	    const content = form.content.value.trim();
	    if (content === "") {
	      alert("내용을 입력하세요");
	      form.content.focus();
	      return;
	    }

	    const formData = new FormData(form);
	    
	    fetch(contextPath + "/comments/Write.do", {
	      method: "POST",
	      body: formData,
	    })
	      .then((res) => res.json())
	      .then((data) => {
	        if (data.success) {
	          // 댓글 작성 후 목록 갱신
	          loadComments(pNum);
	          form.reset();
	        } else {
	          alert(data.message);
	        }
	      })
	      .catch((err) => console.error(err));
	  });
	}

	document.addEventListener("DOMContentLoaded", () => {
	  writeComment(pNum); // 부모에서 내려온 pNum 사용
	});

</script>
</html>