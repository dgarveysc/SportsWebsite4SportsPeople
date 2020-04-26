

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;

/**
 * Servlet implementation class brackedIdServlet
 */
@WebServlet("/brackedIdServlet")
public class brackedIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public brackedIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userIDString = request.getParameter("userID");
		System.out.println(userIDString);
		int userID = Integer.parseInt(userIDString);
		//String inputScore = request.getParameter("input-score");
		List<String> gameNameList = 
		           Collections.synchronizedList(new ArrayList<String>()); 
		
		// make call to SQL database for bracketId using userId
		//Connecting to SQL database
		Connection connection = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			//Using prepared statement to see if the username password combination returns a user
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportswebsite?user=root&password=root");
			st = connection.prepareStatement("SELECT * FROM usertobracket WHERE userID=?");
			st.setInt(1, userID);
			rs = st.executeQuery();
			System.out.println("Saev me");
			if(rs.next()) {
				System.out.println("List of games user is in: ");
				do {
					String gameName = rs.getString("bracketID");
					System.out.println(gameName);
					gameNameList.add(gameName);
				} while(rs.next());
			}
			else {
				System.out.println("User not in any games");
			}
			
		} catch (SQLException | ClassNotFoundException sqle) {
			System.out.println("Help" + sqle.getMessage());
		} finally {
			try {
				connection.close();
				st.close();
				rs.close();
			}
			catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		
		int numGames = gameNameList.size();
		request.setAttribute("numGames", numGames);
		for(int i = 0; i < gameNameList.size(); i++)
		{
			request.setAttribute("gameName" + i, gameNameList.get(i));
		}
		
		String next = "/profile.jsp";
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
