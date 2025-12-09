<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>댓글 리스트</title>
<style>
.comment-list {
	max-width: 900px;
	margin: 20px auto;
	padding: 20px;
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	font-family: "Segoe UI", Arial, sans-serif;
}

.comment-item {
	border-bottom: 1px solid #eee;
	padding: 12px 0;
}

.comment-item:last-child {
	border-bottom: none;
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

.comment-date {
	font-size: 13px;
	color: #999; /* 회색 처리 */
}

.comment-content {
	font-size: 15px;
	color: #444;
	line-height: 1.5;
	white-space: pre-line;
}

.comments-count {
	font-size: 18px;
	font-weight: bold;
	color: #2c3e50;
	background: #f0f8ff;
	padding: 8px 14px;
	border-radius: 20px;
	display: inline-block;
	margin-bottom: 15px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.comments-count::before {
	content: "💬 ";
	font-size: 18px;
}
</style>

<script>
const contextPath = "${pageContext.request.contextPath}";
const pNum = "${dto.pNum}";

function loadComments(pNum) {
  fetch(contextPath + "/comments/List.do?pNum=" + pNum)
    .then((res) => res.json())
    .then((data) => {
      console.log(data);
      const area = document.querySelector("#commentArea");
      area.innerHTML = ""; // 초기화

      const h3 = document.createElement("h3");
      h3.classList.add("comments-count");
      h3.textContent =
        data.totalCount > 0
          ? data.totalCount + "개의 댓글"
          : "등록된 댓글이 없습니다.";
      area.appendChild(h3);

      if (data.success && Array.isArray(data.comments)) {
        data.comments.forEach((c) => {
          // 댓글 전체 컨테이너
          const div = document.createElement("div");
          div.classList.add("comment-item");

          // 메타 정보 (작성자 + 날짜)
          const meta = document.createElement("div");
          meta.classList.add("comment-meta");

          const author = document.createElement("span");
          author.classList.add("comment-author");
          author.textContent = c.name;

          const date = document.createElement("span");
          date.classList.add("comment-date");
          date.textContent = c.regidate;

          meta.appendChild(author);
          meta.appendChild(date);

          // 내용
          const content = document.createElement("div");
          content.classList.add("comment-content");
          content.textContent = c.content;

          // DOM에 추가
          div.appendChild(meta);
          div.appendChild(content);
          area.appendChild(div);
        });
      } else {
        area.textContent = "댓글이 없습니다.";
      }
    })
    .catch((err) => {
      console.error(err);
      document.querySelector("#commentArea").textContent =
        "댓글을 불러오는 중 오류가 발생했습니다.";
    });
}

document.addEventListener("DOMContentLoaded", () => {
  loadComments(pNum);
});

</script>
</head>
<body>

	<!-- 댓글 출력 영역 -->
	<div id="commentArea" class="comment-list"></div>
	<jsp:include page="./Write.jsp"></jsp:include>

</body>
</html>