package board;

import java.sql.SQLException;
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
		String query = "INSERT INTO board (pnum, id, title, content, ofile, sfile, category) "
				+ "VALUES (TO_CHAR(seq_board_num.NEXTVAL), ?, ?, ?, ?, ?, ?)";

		try {

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
				dto.setLikeCount(rs.getInt(10));
				dto.setName(rs.getString(11));
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
			psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}

	public int deletePost(String pNum) {
		int result = 0;
		String query = "DELETE FROM board WHERE pnum=?";
		try {

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
		String query = "UPDATE board" + " SET title=?, content=?, ofile=?, sfile=? " + " WHERE pnum=? and id=?";
		try {

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
		List<BoardDTO> board = new Vector<>();

		String query = "SELECT * FROM ( " + "    SELECT Tb.*, ROWNUM rNum FROM ( "
				+ "        SELECT b.*, m.name, NVL(c.commentsCount, 0) AS commentsCount " + "        FROM board b "
				+ "        JOIN member m ON b.id = m.id " + "        LEFT JOIN ( "
				+ "            SELECT pnum, COUNT(*) AS commentsCount " + "            FROM comments "
				+ "            GROUP BY pnum " + "        ) c ON b.pnum = c.pnum " + "        WHERE b.category = ? ";

		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " AND " + map.get("searchField") + " LIKE ? ";
		}

		query += "  ORDER BY b.pnum DESC " + "    ) Tb " + ") WHERE rNum BETWEEN ? AND ?";

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
				dto.setLikeCount(rs.getInt("likeCount"));
				dto.setName(rs.getString("name"));
				dto.setCommentsCount(rs.getInt("commentsCount")); // 댓글 수 추가

				board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}

		return board;
	}

	// 좋아요
	public boolean addFavorite(String pNum, String userId) {
		String query = "INSERT INTO favorite(fnum, pnum, id) VALUES(seq_favorite_num.NEXTVAL, ?, ?)";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			psmt.setString(2, userId);
			psmt.executeUpdate();

			// board 테이블 likeCount 증가
			query = "UPDATE board SET likecount = likecount + 1 WHERE pnum=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			psmt.executeUpdate();
			return true;
		} catch (Exception e) {
			System.out.println("게시물 좋아요 중 예외 발생");
			e.printStackTrace();
			return false;
		}
	}

	// 좋아요 수 얻기
	public int getLikeCount(String pNum) {
		String query = "SELECT likecount FROM board WHERE pnum=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			rs = psmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println("좋아요 수 얻기 중 예외 발생");
			e.printStackTrace();
			return 0;
		}
		return 0;

	}

	// 특정 사용자가 해당 글에 좋아요 했는지 확인
	public boolean hasFavorite(String pNum, String userId) {
		String query = "SELECT COUNT(*) FROM favorite WHERE pnum=? AND id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			psmt.setString(2, userId);
			rs = psmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			System.out.println("좋아요 여부 확인 중 예외 발생");
			e.printStackTrace();
		}
		return false;
	}

	// 좋아요 취소
	public boolean removeFavorite(String pNum, String userId) {
		try {
			// favorite 테이블에서 삭제
			String query = "DELETE FROM favorite WHERE pnum=? AND id=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, pNum);
			psmt.setString(2, userId);
			int result = psmt.executeUpdate();

			if (result > 0) {
				// board 테이블 likeCount 감소
				query = "UPDATE board SET likecount = likecount - 1 WHERE pnum=?";
				psmt = con.prepareStatement(query);
				psmt.setString(1, pNum);
				psmt.executeUpdate();
				return true;
			}
		} catch (Exception e) {
			System.out.println("좋아요 취소 중 예외 발생");
			e.printStackTrace();
		}
		return false;
	}

}
