import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class computeElo {



	public void updateElo(Integer userID1, Boolean won, Integer userID2)
	{

		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		//should count wins, losses, and upcoming!


		Integer elo1 = null;
		Integer elo2 = null;

		Integer elo1Change = null;
		Integer elo2Change = null;

		Double prob1 = null;
		Double prob2 = null;

		final Integer k = 50;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/lab9?user=root&password=root");
			st = conn.createStatement();

			//get all statIDs corresponding to a user
			rs = st.executeQuery("SELECT UserID, elo FROM Users"
					+ " WHERE UserID = " + userID1 + " OR UserID = " + userID2);

			while(rs.next())
			{
				//map elo to proper user
				if(rs.getInt("UserID") == userID1)
				{
					elo1 = rs.getInt("elo");
				}
				else {
					elo2 = rs.getInt("elo");
				}
			}

			//compute eloChange for each user, K = 50
			prob1 = (1.0/(1.0 + Math.pow(10.0, (elo1 - elo2)/400.0)));
			prob2 = (1.0/(1.0 + Math.pow(10.0, (elo2 - elo1)/400.0)));


			if(won)  // if player 1 wins
			{
				elo1Change = (int) Math.round(k*(1-prob1));
				elo2Change = (int) Math.round(k*(0-prob2));
			}
			else {  // if player 2 wins
				elo1Change = (int) Math.round(k*(0-prob1));
				elo2Change = (int) Math.round(k*(0-prob2));
			}

			//update rank
			st.executeQuery("UPDATE Users "
					+ "SET elo = " + elo1Change+elo1
					+ " WHERE UserID = " + userID1);

			st.executeQuery("UPDATE Users "
					+ "SET elo = " + elo2Change+elo2
					+ " WHERE UserID = " + userID2);
		}
		catch (SQLException sqle) {
		//however we error handle
		System.out.println ("SQLException: " + sqle.getMessage());
		}
	}
}
