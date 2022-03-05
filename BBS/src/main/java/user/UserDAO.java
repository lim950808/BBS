package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//DAO(Data Access Objects): 데이터베이스의 접근객체 -> 실질적으로 회원정보를 불러오거나 저장할때 사용
public class UserDAO {
	
	private Connection conn; //connection: 데이터베이스에 접근하게 해주는 하나의 객체
	private PreparedStatement pstmt; //
	private ResultSet rs;
	
	public UserDAO() { //데이터베이스의 커넥션이 자동적으로 실행될 수 있도록 객체를 생성
		try { //예외처리 대비 try-catch문 생성
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; //본인 컴퓨터의 주소
			String dbID = "BBS";
			String dbPassword = "oracle";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			//driverManager가 db의 url, id, pw를 get할수있도록 연결시킴 
		} catch (Exception e) {
			e.printStackTrace(); //오류가 뭔지 출력
		}
	}
	
	public int login(String userID, String userPassword) { //로그인을 실행하는 함수 login 생성
		String SQL = "SELECT userPassword FROM MEMBER WHERE userID = ?";
		//sql명령어 생성
		try {
			pstmt = conn.prepareStatement(SQL); //sql문장을 db에 삽입하는 인스턴스 생성
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); //결과를 담을 수 있는 rs라는 객체에 실행한 결과를 대입
			if (rs.next()) { //결과가 존재한다면
				if(rs.getString(1).equals(userPassword))
					return 1; //로그인 성공
				else
					return 0; //비밀번호 불일치
			}
			return -1; //id데이터가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류를 -2로 표현
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO MEMBER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

}
