package Friends;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/AcceptFriendRequestServlet")
public class AcceptFriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AcceptFriendRequestServlet() {
        super();
    }
    public void init() {
		// 1. Load JDBC driver
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		//int userID1 = (int) session.getAttribute("userID");
		int userID1 = 1;
		String friendUsername = request.getParameter("friend-input");
		Connection connection = null;
		PreparedStatement st = null;
		PreparedStatement getUsername = null;
		PreparedStatement acceptUser = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		int userID2 = 0;
		try {
			//Using prepared statement to see if the username password combination returns a user
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/SportsWebsite?user=root&password=&serverTimezone=UTC");
			st = connection.prepareStatement("SELECT * FROM Friends WHERE userID1=? AND userID2=? AND acceptedStatus=2");
			getUsername = connection.prepareStatement("SELECT * FROM users WHERE username=?");
			acceptUser = connection.prepareStatement("UPDATE Friends SET acceptedStatus=2 WHERE userID1=? AND userID2=?"); 
			getUsername.setString(1, friendUsername);
			rs1 = getUsername.executeQuery();
			System.out.print(friendUsername);
			if(!rs1.next()) {
				System.out.print("The user you are trying to add does not exist");
				return;
			}
			userID2 = rs1.getInt("userID");
			st.setInt(1, userID1);
			st.setInt(2, userID2);
			rs = st.executeQuery();
			if(rs.next()){
				System.out.print("The user is already a friend");
				return;
			}
			else {
				acceptUser.setInt(1, userID1);
				acceptUser.setInt(2, userID2);
				acceptUser.executeUpdate();
				acceptUser.setInt(1,  userID2);
				acceptUser.setInt(2, userID1);
				acceptUser.executeUpdate();
			}
			st.close();
			getUsername.close();
			acceptUser.close();
			connection.close();
			rs.close();
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} 
		String next = "/profile.jsp";
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}