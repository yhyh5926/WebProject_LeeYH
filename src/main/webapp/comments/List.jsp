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

/* 페이징 영역 전체 */
#pagingArea {
	text-align: center;
	margin-top: 20px;
	font-family: "Segoe UI", Arial, sans-serif;
}

/* 현재 페이지 */
#pagingArea .current {
	display: inline-block;
	padding: 6px 12px;
	background-color: #3498db; /* 파란색 배경 */
	color: #fff; /* 흰색 글자 */
	font-weight: bold;
	border-radius: 6px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

/* 다른 페이지 링크 */
#pagingArea .other {
	display: inline-block;
	padding: 6px 12px;
	background-color: #f0f0f0; /* 연한 회색 배경 */
	color: #333;
	text-decoration: none;
	border-radius: 6px;
	transition: background 0.2s ease, color 0.2s ease;
}

/* hover 효과 */
#pagingArea .other:hover {
	background-color: #3498db;
	color: #fff;
}

/* 수정, 삭제*/
.edit-btn, .delete-btn {
	padding: 6px 12px;
	margin-left: 6px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
}

.edit-btn {
	background-color: #2ecc71; /* 초록색 */
	color: #fff;
}

.edit-btn:hover {
	background-color: #27ae60;
}

.delete-btn {
	background-color: #e74c3c; /* 빨간색 */
	color: #fff;
}

.delete-btn:hover {
	background-color: #c0392b;
}

/* 저장 버튼 */
.save-btn {
	padding: 6px 12px;
	margin-left: 6px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
	background-color: #2ecc71; /* 초록색 */
	color: #fff;
	transition: background 0.2s ease;
}

.save-btn:hover {
	background-color: #27ae60; /* hover 시 진한 초록 */
}

/* 취소 버튼 */
.cancel-btn {
	padding: 6px 12px;
	margin-left: 6px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
	background-color: #e74c3c; /* 빨간색 */
	color: #fff;
	transition: background 0.2s ease;
}

.cancel-btn:hover {
	background-color: #c0392b; /* hover 시 진한 빨강 */
}
</style>

<script>
const contextPath = "${pageContext.request.contextPath}";
const pNum = "${dto.pNum}";
const category = "${dto.category}";
const userId = "${sessionScope.userId}";

function loadComments(pNum, pageNum = 1) {
  fetch(
    contextPath +
      "/comments/List.do?pNum=" +
      pNum +
      "&category=" +
      category +
      "&pageNum=" +
      pageNum
  )
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

          // 수정/삭제 버튼
          if (userId && userId === c.id) {
            const btnGroup = document.createElement("div");
            btnGroup.style.textAlign = "right";
            btnGroup.style.marginTop = "8px";

            const editBtn = document.createElement("button");
            editBtn.textContent = "수정";
            editBtn.classList.add("edit-btn");
            editBtn.onclick = () => {
              content.style.display = "none";
              btnGroup.style.display = "none";

              const textarea = document.createElement("textarea");
              textarea.value = c.content;
              textarea.style.width = "100%";
              textarea.style.minHeight = "80px";

              // 저장/취소 버튼 그룹
              const actionGroup = document.createElement("div");
              actionGroup.style.textAlign = "right";
              actionGroup.style.marginTop = "8px";

              const saveBtn = document.createElement("button");
              saveBtn.textContent = "저장";
              saveBtn.classList.add("save-btn");
              saveBtn.onclick = () => {
                const formData = new FormData();
                formData.append("cNum", c.cNum); // 댓글 번호
                formData.append("content", textarea.value);

                fetch(contextPath + "/comments/Edit.do", {
                  method: "POST",
                  body: formData,
                })
                  .then((res) => res.json())
                  .then((data) => {
                    if (data.success) {
                      // 성공 시 댓글 다시 로드
                      loadComments(pNum);
                    } else {
                      alert(data.message);
                    }
                  });
              };

              const cancelBtn = document.createElement("button");
              cancelBtn.textContent = "취소";
              cancelBtn.classList.add("cancel-btn");
              cancelBtn.onclick = () => {
                textarea.remove();
                actionGroup.remove();
                content.style.display = "block";
                btnGroup.style.display = "block";
              };

              actionGroup.appendChild(saveBtn);
              actionGroup.appendChild(cancelBtn);

              div.appendChild(textarea);
              div.appendChild(actionGroup);
            };

            const deleteBtn = document.createElement("button");
            deleteBtn.textContent = "삭제";
            deleteBtn.classList.add("delete-btn");
            deleteBtn.onclick = () => {
              if (confirm("정말 삭제하시겠습니까?")) {
                fetch(contextPath + "/comments/Delete.do?cNum=" + c.cNum, {
                  method: "POST",
                })
                  .then((res) => res.json())
                  .then((data) => {
                    if (data.success) {
                      loadComments(pNum);
                    } else {
                      alert(data.message);
                    }
                  });
              }
            };

            btnGroup.appendChild(editBtn);
            btnGroup.appendChild(deleteBtn);
            div.appendChild(btnGroup);
          }

          area.appendChild(div);
        });
      } else {
        area.textContent = "댓글이 없습니다.";
      }
      // 페이징 버튼 출력
      document.querySelector("#pagingArea").innerHTML = data.pagingImg;

      // 페이징 버튼 클릭 이벤트 연결
      document.querySelectorAll("#pagingArea a").forEach((a) => {
        a.addEventListener("click", (e) => {
          e.preventDefault();
          const pageNum = new URL(a.href).searchParams.get("pageNum");
          loadComments(pNum, pageNum);
        });
      });
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
	<div id="pagingArea" style="text-align: center; margin-top: 15px;"></div>
	<jsp:include page="./Write.jsp"></jsp:include>

</body>
</html>