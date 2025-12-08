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

	// 생성자 4개의 접속 정보를 얻은 후 전달
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}

	/*
	 * 생성자2: application 내장 객체만 전달하여 생성자 내부에서 web.xml에 접근하도록 처리 public
	 * MemberDAO(ServletContext application) { super(application); }
	 */

	/*
	 * 사용자가 입력한 아이디, 패스워드를 통해 회원 테이블을 select한 후 존재하는 회원 정보인 경우 DTO 객체에 인출한 레코드를 저장한
	 * 후 반환
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
				dto.setEmail(rs.getString(4));
				dto.setPhone(rs.getString(5));
				dto.setRegidate(rs.getString(6));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	public int insertMember(MemberDTO dto) {
		int result = 0;
		String query = "INSERT INTO member (id, password, name, email, phone) VALUES(?,?,?,?,?)";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPassword());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getPhone());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 중 에러 발생");
		}

		return result;
	}

	public MemberDTO getMemberDTOById(String uid) {
		MemberDTO dto = new MemberDTO();
		String query = "SELECT id, name, email, phone, regidate FROM member WHERE id=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString(2));
				dto.setEmail(rs.getString(3));
				dto.setPhone(rs.getString(4));
				dto.setRegidate(rs.getString(5));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	public boolean isIdExists(String id) {
		boolean exists = false;
		String query = "SELECT COUNT(*) FROM member WHERE id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				exists = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return exists;
	}

	public int updateMember(MemberDTO dto) {
		int result = 0;
		String query = "UPDATE member SET name=?, password=?, email=?,phone=? WHERE id=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getPassword());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getId());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 수정 중 에러 발생");
		}

		return result;
	}

}
