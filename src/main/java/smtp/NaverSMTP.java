package smtp;

import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import jakarta.servlet.ServletContext;
import member.MemberDAO;

public class NaverSMTP {
	private final Properties serverInfo; // 서버 정보
	private final Authenticator auth; // 인증 정보

	private ServletContext application;

	public NaverSMTP(ServletContext application) {
		this.application = application;

		// 네이버 SMTP 서버 접속 정보
		serverInfo = new Properties();
		serverInfo.put("mail.smtp.host", "smtp.naver.com");
		serverInfo.put("mail.smtp.port", "465");
		serverInfo.put("mail.smtp.starttls.enable", "true");
		serverInfo.put("mail.smtp.auth", "true");
		serverInfo.put("mail.smtp.debug", "true");
		serverInfo.put("mail.smtp.socketFactory.port", "465");
		serverInfo.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		serverInfo.put("mail.smtp.socketFactory.fallback", "false");

		
		// 사용자 인증 정보
		String smtpUser = System.getenv("NAVER_SMTP_USER");
		String smtpPassword = System.getenv("NAVER_SMTP_PASSWORD");

		auth = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(smtpUser, smtpPassword);
			}
		};
	}

	// 주어진 메일 내용을 네이버 SMTP 서버를 통해 전송
	// 주어진 메일 내용을 네이버 SMTP 서버를 통해 전송
	public boolean emailSending(Map<String, String> info) {
		try {
			// DB접근
			String oracleDriver = application.getInitParameter("OracleDriver");
			String oracleURL = application.getInitParameter("OracleURL");
			String oracleId = application.getInitParameter("OracleId");
			String oraclePwd = application.getInitParameter("OraclePwd");

			MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

			// 이메일 존재 여부 확인
			String toEmail = info.get("to");
			String userId = info.get("userId");
			if (!dao.isEmailExists(toEmail, userId)) {
				System.out.println("아이디에 해당 이메일은 존재하지 않습니다.");
				return false;
			}

			// 임시 비밀번호 추출 후 DB 업데이트
			String content = info.get("content");
			String tempPassword = null;
			if (content.contains(":")) {
				tempPassword = content.split(":")[1].trim();
				dao.updatePasswordByEmail(toEmail, tempPassword);
			}

			// 1. 세션 생성
			Session session = Session.getInstance(serverInfo, auth);
			session.setDebug(true);

			// 2. 메시지 작성
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(info.get("from")));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(info.get("to")));
			msg.setSubject(info.get("subject"), "UTF-8");
			msg.setContent(info.get("content"), info.get("format"));

			// 3. 전송
			Transport.send(msg);

			return true; // 성공 시 true 반환
		} catch (Exception e) {
			e.printStackTrace();
			return false; // 실패 시 false 반환
		}
	}

}
