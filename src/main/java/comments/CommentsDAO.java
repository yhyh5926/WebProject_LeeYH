package comments;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import board.BoardDTO;
import common.DBConnPool;

public class CommentsDAO extends DBConnPool {

	public CommentsDAO() {
		super();
	}

	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM comments WHERE pNum = ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, (String) map.get("pNum"));

			rs = psmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("댓글 카운트 중 예외 발생");
			e.printStackTrace();
		}

		return totalCount;
	}

	public int insertWrite(CommentsDTO dto) {
		int result = 0;
		String query = "INSERT INTO comments (cnum, pnum, id, content) "
				+ "VALUES (TO_CHAR(seq_comments_cnum.NEXTVAL), ?, ?, ?)";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getpNum());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getContent());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public int deleteComment(String cNum) {
		int result = 0;
		String query = "DELETE FROM comments WHERE cnum=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, cNum);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public int updateComment(CommentsDTO dto) {
		int result = 0;
		String query = "UPDATE comments" + " SET content=? " + " WHERE cnum=? and id=?";
		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getContent());
			psmt.setString(2, dto.getcNum());
			psmt.setString(3, dto.getId());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("댓글 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public List<CommentsDTO> selectListPage(Map<String, Object> map) {
		List<CommentsDTO> comments = new Vector<CommentsDTO>();

		String query = "SELECT * FROM ( " + "   SELECT Tc.*, ROWNUM rNum FROM ( "
				+ "       SELECT c.cnum, c.pnum, c.id, c.content, c.regidate, m.name " + "       FROM comments c "
				+ "       JOIN member m ON c.id = m.id " + "       WHERE c.pnum = ? " + "       ORDER BY c.cnum DESC "
				+ "   ) Tc " + ") WHERE rNum BETWEEN ? AND ?";

		try {
			psmt = con.prepareStatement(query);

			// 3) start, end

			psmt.setString(1, map.get("pNum").toString());
			psmt.setInt(2, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(3, Integer.parseInt(map.get("end").toString()));

			rs = psmt.executeQuery();

			while (rs.next()) {
				CommentsDTO dto = new CommentsDTO();

				dto.setpNum(rs.getString("pNum"));
				dto.setId(rs.getString("id"));
				dto.setcNum(rs.getString("cNum"));
				dto.setContent(rs.getString("content"));
				dto.setRegidate(rs.getDate("regidate"));
				dto.setName(rs.getString("name"));
				comments.add(dto);
			}

		} catch (Exception e) {
			System.out.println("댓글 조회 중 예외 발생");
			e.printStackTrace();
		}

		return comments;
	}

	public String getRegidate(String id, String pNum) {
		String regidate = null;
		try {
			String sql = "SELECT regidate FROM comments " + "WHERE id=? AND pnum=? "
					+ "ORDER BY cnum DESC FETCH FIRST 1 ROWS ONLY";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pNum);
			rs = psmt.executeQuery();
			if (rs.next()) {
				regidate = rs.getString("regidate");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return regidate;
	}

}
