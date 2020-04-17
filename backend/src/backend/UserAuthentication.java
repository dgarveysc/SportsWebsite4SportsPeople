import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class UserAuthentication {
	public static void main(String[] args) {
		try {
			UserAuthentication();
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	private static void UserAuthentication() throws SQLException {
		//Entering a username and password for testing
				System.out.print("Enter your username: ");
				Scanner scan = new Scanner(System.in);
				String username = scan.nextLine();
				
				System.out.print("Enter your password: ");	
				scan = new Scanner(System.in);
				String password = scan.nextLine();
				scan.close(); 
				
				
				//Connecting to SQL database
				Connection connection = null;
				PreparedStatement st = null;
				ResultSet rs = null;
				
				try {
					//Using prepared statement to see if the username password combination returns a user
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsbetting?user=root&password=root");
					st = connection.prepareStatement("SELECT * FROM users WHERE username=? AND passphrase=?");
					st.setString(1, username);
					st.setString(2, password);
					rs = st.executeQuery();

					if(rs.next()) {
						System.out.println("Valid combination!");
					}
					else {
						System.out.println("Not a matching combination");
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
