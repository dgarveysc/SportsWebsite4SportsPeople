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
@WebServlet("/GetFriendServlet")
public class GetFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GetFriendServlet() {
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
		PreparedStatement addUser = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		int userID2 = 0;
		ArrayList<String> friendsList = new ArrayList<String>();
		try {
			//Using prepared statement to see if the username password combination returns a user
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsbetting?user=root&password=root&serverTimezone=UTC");
			st = connection.prepareStatement("SELECT * FROM Friends WHERE userID1=? AND acceptedStatus=2");
			getUsername = connection.prepareStatement("SELECT * FROM users WHERE UserID=?");
			st.setInt(1, userID1);
			rs = st.executeQuery();
			
			if(rs.next()) {
				System.out.println("List of Friends");
				int UserID2 = 0;
				do {
					UserID2 = rs.getInt("userID2");				
					getUsername.setInt(1, UserID2);
					rs1 = getUsername.executeQuery();
					String friendName = rs1.getString("username");
					friendsList.add(friendName);
				} while(rs.next());
				rs1.close();
			}
			else {
				System.out.println("User does not any friends");
			}
			st.close();
			getUsername.close();
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