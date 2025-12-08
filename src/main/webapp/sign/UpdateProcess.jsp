<%@page import="utils.JSFunction"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("userId");
String userName = request.getParameter("userName");
String userPwd = request.getParameter("userPwd");
//이메일
String emailId = request.getParameter("emailId");
String emailDomain = request.getParameter("emailDomain");
String emailCustom = request.getParameter("emailCustom");
String userEmail = emailDomain.equals("직접입력") ? emailId + "@" + emailCustom : emailId + "@" + emailDomain;
//전화번호
String phone1 = request.getParameter("phone1");
String phone2 = request.getParameter("phone2");
String phone3 = request.getParameter("phone3");
String userPhone = phone1 + "-" + phone2 + "-" + phone3;

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDTO dto = new MemberDTO();
dto.setId(userId);
dto.setPassword(userPwd);
dto.setName(userName);
dto.setEmail(userEmail);
dto.setPhone(userPhone);

MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

int result = dao.updateMember(dto);

dao.close();

if (result > 0) {
	session.setAttribute("userId", userId); // 수정된 회원정보로 세션 업데이트
	JSFunction.alertLocation("회원정보 수정 성공!", request.getContextPath() + "/index.jsp", out);
} else {
	JSFunction.alertBack("회원정보 수정 실패!", out);
}
%>


%>
