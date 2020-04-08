import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class UserGames {
	public static void main(String[] args) {
		try {
			UserGames();
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	private static void UserGames() throws SQLException {
		//Entering a username and password for testing
				System.out.print("Enter your user id: ");
				Scanner scan = new Scanner(System.in);
				int userID = scan.nextInt();
				
				
				//Connecting to SQL database
				Connection connection = null;
				PreparedStatement st = null;
				ResultSet rs = null;
				
				try {
					//Using prepared statement to see if the username password combination returns a user
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsbetting?user=root&password=root");
					st = connection.prepareStatement("SELECT * FROM games WHERE userID1=? OR userID2=?");
					st.setInt(1, userID);
					st.setInt(2, userID);
					rs = st.executeQuery();
					
					if(rs.next()) {
						System.out.println("List of games user is in: ");
						do {
							String gameName = rs.getString("gameName");
							System.out.println(gameName);
						} while(rs.next());
					}
					else {
						System.out.println("User not in any games");
					}
					
				} catch (SQLException sqle) {
					System.out.println(sqle.getMessage());
				} finally {
					st.close();
					connection.close();
					rs.close();
				}
	}
}
