package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnPool {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;

	public DBConnPool() {
		try {
			//Context 인스턴스 생성(Tomcat 컨테이너 생성)
			Context initCtx = new InitialContext();
			//Tomcat의 Root 디렉토리를 얻어온다
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			//그 안에서 미리 생성한 커넥션 풀 객체를 얻어온다
			DataSource source = (DataSource) ctx.lookup("dbcp_myoracle");
			//이를 통해 DB에 연결, 즉 커넥션 객체를 가져다가 사용한다
			con = source.getConnection();
			System.out.println("DB 커넥션 풀 연결 성공");
		} catch (Exception e) {
			System.out.println("DB 커넥션 풀 연결 실패");
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();

			System.out.println("DB 커넥션 풀 자원 반납");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
