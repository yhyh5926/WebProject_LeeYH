<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String category = request.getParameter("category") == null ? "free" : request.getParameter("category");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="get" class="search-form">
		<input type="hidden" name="category" value="<%=category%>" /> <select
			name="searchField">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="name">작성자</option>
		</select> <input type="text" name="searchWord" /> <input type="submit"
			value="검색하기" />
	</form>
</body>
</html>