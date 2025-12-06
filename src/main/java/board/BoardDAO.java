package board;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

//커넥션풀을 통한 DB연결을 위해 클래스 상속
public class BoardDAO extends DBConnPool {
	public BoardDAO() {
		super();
	}

	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM board WHERE category = ?";

		// 검색어가 있으면 AND로 추가
		if (map.get("searchWord") != null) {
			query += " AND " + map.get("searchField") + " LIKE ?";
		}

		try {
			psmt = con.prepareStatement(query);

			psmt.setString(1, (String) map.get("category"));
			if (map.get("searchWord") != null) {
				psmt.setString(2, "%" + map.get("searchWord") + "%");
			}

			rs = psmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}

		return totalCount;
	}

	public int insertWrite(BoardDTO dto) {
		int result = 0;

		try {
			String query = "INSERT INTO board (pnum, id, title, content, ofile, sfile, category) "
					+ "VALUES (seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, ?)";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getCategory());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public BoardDTO selectView(String pNum) {
		BoardDTO dto = new BoardDTO();
		String query = "SELECT Bo.*, Me.name FROM board Bo " + " INNER JOIN member Me ON Bo.id=Me.id" + " WHERE pnum=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setpNum(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostDate(rs.getDate(5));
				dto.setVisitCount(rs.getInt(6));
				dto.setOfile(rs.getString(7));
				dto.setSfile(rs.getString(8));
				dto.setCategory(rs.getString(9));
				dto.setName(rs.getString(10));
			}
		} catch (Exception e) {
			System.err.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;

	}

	public void updateVisitCount(String pNum) {
		String query = "UPDATE board SET " + " visitcount=visitcount+1 " + " WHERE pnum=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			psmt.executeQuery();
		} catch (Exception e) {
			System.err.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}

	public int deletePost(String pNum) {
		int result = 0;
		try {
			String query = "DELETE FROM board WHERE pnum=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public int updatePost(BoardDTO dto) {
		int result = 0;
		try {
			String query = "UPDATE board" + " SET title=?, content=?, ofile=?, sfile=? " + " WHERE pnum=? and id=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setString(5, dto.getpNum());
			psmt.setString(6, dto.getId());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		List<BoardDTO> board = new Vector<BoardDTO>();

		String query = "SELECT * FROM ( " + "    SELECT Tb.*, ROWNUM rNum FROM ( "
				+ "        SELECT b.*, m.name FROM board b " + "        JOIN member m ON b.id = m.id ";

		// category 조건 추가
		query += " WHERE b.category = ? ";

		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " AND " + map.get("searchField") + " LIKE ? ";
		}

		query += "        ORDER BY b.pnum DESC " + "    ) Tb " + ") " + "WHERE rNum BETWEEN ? AND ?";

		try {
			psmt = con.prepareStatement(query);

			int idx = 1;
			// 1) category
			psmt.setString(idx++, (String) map.get("category"));

			// 2) searchWord
			if (map.get("searchWord") != null) {
				psmt.setString(idx++, "%" + map.get("searchWord") + "%");
			}

			// 3) start, end
			psmt.setInt(idx++, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(idx++, Integer.parseInt(map.get("end").toString()));

			rs = psmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setpNum(rs.getString("pNum"));
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostDate(rs.getDate("postDate"));
				dto.setVisitCount(rs.getInt("visitCount"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setCategory(rs.getString("category"));
				dto.setName(rs.getString("name")); // member 테이블의 name

				board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}

		return board;
	}

}
