<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="utils.JSFunction"%>
<%@page import="smtp.NaverSMTP"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%!// 임시 비밀번호 생성 메서드
	public String generateTempPassword(int length) {
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder sb = new StringBuilder();
		java.util.Random random = new java.util.Random();

		for (int i = 0; i < length; i++) {
			int index = random.nextInt(chars.length());
			sb.append(chars.charAt(index));
		}
		return sb.toString();
	}%>

<%
//폼값(이메일 내용) 저장
Map<String, String> info = new HashMap<String, String>();
info.put("from", request.getParameter("from")); //보내는 사람
info.put("to", request.getParameter("to")); //받는 사람
info.put("subject", request.getParameter("subject")); //제목
info.put("userId", request.getParameter("userId")); //아이디
//임시 비밀번호 생성 (10자리)
String tempPassword = generateTempPassword(10);

//이메일 본문에 임시 비밀번호 추가
String content = "password: " + tempPassword;

//내용은 메일 포맷에 따라 다르게 처리
String format = request.getParameter("format"); //메일 포맷(text or html)
if (format.equals("text")) {
	//텍스트 포맷일 때는 그대로 저장
	info.put("content", content);
	info.put("format", "text/plain; charset=UTF-8");
} else if (format.equals("html")) {
	//html 포맷일 때는 html 형태로 변환해 저장
	content = content.replace("\r\n", "<br/>");//줄바꿈을 html 형태로 수정
	String htmlContent = "";

	try {
		//html 메일용 템플릿 파일 읽기
		String templatePath = application.getRealPath("/Common/MailForm.html");
		BufferedReader br = new BufferedReader(new FileReader(templatePath));

		//한 줄씩 읽어 htmlContent 변수에 저장
		String oneLine;
		while ((oneLine = br.readLine()) != null) {
	htmlContent += oneLine + "\n";
		}
		br.close();
	} catch (Exception e) {
		e.printStackTrace();
	}

	//템플릿의 "__CONTENT__" 부분을 메일 내용으로 대체(변환 완료)
	htmlContent = htmlContent.replace("__CONTENT__", content);
	//변환된 내용을 저장
	info.put("content", htmlContent);
	info.put("format", "text/html; charset=UTF-8");

}

//메일 전송 클래스 생성
NaverSMTP smtpServer = new NaverSMTP(application);
boolean result = smtpServer.emailSending(info);

if (result) {
	JSFunction.alertLocation("메일 전송 성공!", "../sign/LoginForm.jsp", out);
} else {
	JSFunction.alertLocation("메일 전송 실패!", "./SendEmail.jsp", out);
}
%>