import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

public class statsMethods {

	
	
	public static int blankStatsRow()
	{
		
		int statsID = 0;
		
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		//should count wins, losses, and upcoming!
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/SportsWebsite?user=root&password=root");
			st = conn.createStatement();

			//get all statIDs corresponding to a user

		    ps = conn.prepareStatement("INSERT INTO Stats(won, prize) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);

			ps.setNull(1, Types.NULL);
			ps.setNull(2, Types.NULL);

			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				statsID = rs.getInt(1);
			}
			return statsID;
		}
		catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
		finally {
			
		}
		return 0;
	}
	
	public static void main(String[] args)
	{
		int id = blankStatsRow();
		System.out.println(id);
	}
	
}
