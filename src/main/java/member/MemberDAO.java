package member;

import common.JDBConnect;
import jakarta.servlet.ServletContext;
/*
DAO(Data Access Object)
:실제 데이터베이스에 접근하여 기본적인 CRUD 작업을 하기 위한 객체
DB 접속 및 select, insert와 같은 쿼리문 실행한 후 결과를 반환
*/

//JDBC를 위한 클래스를 상속하여 DB에 연결
public class MemberDAO extends JDBConnect {
	
	//생성자1: 4개의 접속 정보를 얻은 후 전달
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}

	//생성자2: application 내장 객체만 전달하여 생성자 내부에서 web.xml에 접근하도록 처리
	public MemberDAO(ServletContext application) {
		super(application);
	}

	/*
	사용자가 입력한 아이디, 패스워드를 통해 회원 테이블을 select한 후 존재하는 회원 정보인 경우 
	DTO 객체에 인출한 레코드를 저장한 후 반환
	*/
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		String query = "SELECT * FROM member WHERE id=? AND password=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}
}
