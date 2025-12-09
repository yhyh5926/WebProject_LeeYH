<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("userId");
String userPwd = request.getParameter("userPwd");

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
dao.close();

if (memberDTO.getId() != null) {
	//세션 저장
	session.setAttribute("userId", memberDTO.getId());
	session.setAttribute("userName", memberDTO.getName());
	//쿠키 생성
	Cookie cookie = new Cookie("userId", memberDTO.getId());
	cookie.setMaxAge(60 * 60 * 24); // 쿠키 유효기간: 1일 (초 단위)
	cookie.setPath("/"); // 애플리케이션 전체에서 접근 가능하도록 설정
	response.addCookie(cookie); // 응답에 쿠키 추가

	response.sendRedirect(request.getContextPath() + "/board/Board.do");
} else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
}
%>