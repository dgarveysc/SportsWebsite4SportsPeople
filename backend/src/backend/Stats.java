import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.List;
import java.util.Vector;


public class Stats {
	
	
	public void userHistory(int testID)
	{
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		Vector<Integer> statIDs = null;
		
		//should count wins, losses, and upcoming!
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/lab9?user=root&password=root");
			st = conn.createStatement();
			
			//get all statIDs corresponding to a user
			rs = st.executeQuery("SELECT * FROM UserToBracket"
					+ " WHERE userID = " + testID);
			
			statIDs = new Vector<Integer>();
			while (rs.next()) { //now put all statIDs into vector
				
				//ASSUME statID always exists
				statIDs.add(rs.getInt("statsID"));
			}
			
			//create the string that represents all statIDs of a user
			//alternative: grab whole table and do log(n) lookups in set of statIDs -- do later to optimize
			String idString = "(";
			for(int i = 0; i < statIDs.size(); i++)
			{
				idString += statIDs.get(i);
				idString += ", ";
			}
			idString = idString.substring(0, idString.length()-2);
			idString += ")";
			
			//get table of all statsID for user
			rs2 = st.executeQuery("SELECT * FROM Stats"
					+ " WHERE statsID in " + idString);
			
			Integer numWins = 0;
			Integer numLosses = 0;
			Integer numPlayed = 0;
			Integer numBWins = 0; //bracket wins
			Integer sumRounds = 0; //sum of all rounds played. divide by numPlayed to get avgRound
			Double avgRound = 0.0;
			Integer numEarned = 0;
			Integer sumOppRank = 0;
			Double avgOppRank = 0.0;
			
			//List of EloChanges
			Vector<Integer> eloChanges = new Vector<Integer>();
			
			//List of oppRank for wins
			List<Integer> oppRkWins = new Vector<Integer>();

			//List of oppRank for losses
			List<Integer> oppRkLosses = new Vector<Integer>();
			
			//no divide by zero error to break website psl
			
			while(rs2.next()) //go thru statsID table for user
			{
				boolean won = rs2.getBoolean("won");
				Integer oppRank = rs2.getInt("oppRank");

				
				if(won) //update wins and rank of opponents you beat
				{
					numWins++;
					oppRkWins.add(oppRank);
				}
				else {
					numLosses++;
					oppRkLosses.add(oppRank);
				}
				sumOppRank += oppRank;
				numPlayed++;
				
				//rounds span from 1-3, add total rounds
				Integer round = rs2.getInt("round");
				sumRounds += round;
				
				if(round == 3 && won) //condition to check if won bracket
				{
					numBWins++;
				}
				
				Integer prize = rs2.getInt("prize");
				if(prize != null)
				{
					numEarned += prize;
				}
				
				Integer eloChange = rs2.getInt("xp");
				eloChanges.add(eloChange);
				
				Integer curElo = rs2.getInt("curElo");
				
			}
			
			
			//VERIFY THAT THE USERS TESTID IS VALID, CATCH EXCEPTION
			String userIDString = String.valueOf(testID); 
			
			
			FileWriter fw = new FileWriter(userIDString + ".txt");
			PrintWriter pw = new PrintWriter(fw);
			
			int curElo = 1000;
			
			//now output list to file, of scores not changes:
			pw.print("1000\n");
			for(int i = 0; i < eloChanges.size(); i++)
			{
				curElo += eloChanges.get(i);
				if(i == eloChanges.size()-1)
				{
					pw.print(curElo);
				}
				else {
					pw.print(curElo + "\n");
				}
			}
			
			
			// now run Python script thru matPlotLib
			ProcessBuilder pb = new ProcessBuilder("python", "C:\\Users\\arico\\Desktop\\test.py");
			Process p = pb.start();
				// matPlotLib will output fiveID.png, twentyID.png, and allID.png, for rank change graphs
			// wait until done then continue with other stuff
			InputStream in = p.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			
			String pyInput = br.readLine(); //should buffer
			System.out.println(pyInput); // prints success

			if(!pyInput.contentEquals("Sucess"))  // figure out how to handle
			{
				System.out.println("PYTHON SCRIPT DID NOT WORK");
			}
			
			
			//process data and output avg opp rank over winning games
			Double wRank5 = 0.0;
			Double wRank20 = 0.0;
			Double wRankAll = 0.0;
			Double lRank5= 0.0;
			Double lRank20 = 0.0;
			Double lRankAll = 0.0;
			
			//compute median, 25%, 75% for winning rank
			for(int i = oppRkWins.size()-1; i>= 0; i--)
			{
				Integer curRk = oppRkWins.get(i);
				if(i >= oppRkWins.size()-5) //rank5
				{
					wRank5 += curRk; wRank20 += curRk; wRankAll += curRk;
				}
				else if(i >= oppRkWins.size()-20) //rank5
				{
					wRank20 += curRk;
					wRankAll += curRk;
				}
				else {
					wRankAll += curRk;
				}
			}
			//compute averages
			wRank5 = wRank5 / 5.0;
			wRank20 = wRank20/20.0;
			if(numWins != 0)
			{
				wRankAll = wRankAll/numWins;
			}

			//do same for losing rank
			for(int i = oppRkLosses.size()-1; i>= 0; i--)
			{
				Integer curRk = oppRkLosses.get(i);
				if(i >= oppRkLosses.size()-5) //rank5
				{
					lRank5 += curRk; lRank20 += curRk; lRankAll += curRk;
				}
				else if(i >= oppRkLosses.size()-20) //rank5
				{
					lRank20 += curRk;
					lRankAll += curRk;
				}
				else {
					lRankAll += curRk;
				}
			}
			lRank5 = lRank5 / 5.0;
			lRank20 = lRank20/20.0;
			if(numLosses != 0)
			{
				lRankAll = lRankAll/numLosses;
			}
			

			Collections.sort(oppRkWins);
			Collections.sort(oppRkLosses);

			Integer win25 = 0; 
			Integer win50 = 0;
			Integer win75 = 0;
			Integer lose25 = 0;
			Integer lose50 = 0;
			Integer lose75 = 0;
			
			if(oppRkWins.size() > 0)
			{
				win25 = (oppRkWins.size()-1)/4;
				win50 = oppRkWins.size()/2;
				win75 = oppRkWins.size()*3/4;
			}
			if(oppRkLosses.size() > 0)
			{
				lose25 = (oppRkLosses.size()-1)/4;
				lose50 = oppRkLosses.size()/2;
				lose75 = oppRkLosses.size()*3/4;
			}
			
			//compute average opponent rank
			if(numPlayed != 0)
			{
				avgOppRank = ((double) sumOppRank) / ((double) numPlayed);
				avgRound = ((double) sumRounds) / ((double) numPlayed);
			}
			
			
			
		} catch (SQLException sqle) {
			//however we error handle
			
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}		
}
