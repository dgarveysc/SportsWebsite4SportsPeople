package sql;

import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bracket.Bracket;
import bracket.UserToStats;

public class JDBCBracketStuff {
	
	public static Connection conn;
	private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
    private static final String NUMBER = "0123456789";

    private static final String DATA_FOR_RANDOM_STRING = CHAR_LOWER + CHAR_UPPER + NUMBER;
    private static SecureRandom random = new SecureRandom();
	
	private static int createStats(int bracketRound) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int statsID = -1;
		try {
			ps = conn.prepareStatement("INSERT INTO Stats (bracketRound) VALUES (?)", Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, Integer.toString(bracketRound));
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			
			if (rs.next()) {
				statsID = rs.getInt(1);
				System.out.printf("pk of stats is %d\n", statsID);
			} else {
				System.out.println("AAAHHHHH");
			}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
			return -1;
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return statsID;
	}
	
	public static String generateRandomString(int length) {
        if (length < 1) throw new IllegalArgumentException();

        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {

			// 0-62 (exclusive), random returns 0-61
            int rndCharAt = random.nextInt(DATA_FOR_RANDOM_STRING.length());
            char rndChar = DATA_FOR_RANDOM_STRING.charAt(rndCharAt);

            // debug
            //System.out.format("%d\t:\t%c%n", rndCharAt, rndChar);

            sb.append(rndChar);

        }

        return sb.toString();

    }
	
	private static String generateBracketCode() {
		boolean success = false;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String randomS = null;
		while (!success) {
			randomS = generateRandomString(20);
			try {
			ps = conn.prepareStatement("SELECT bracketID FROM Bracket WHERE bracketCode=?");
			ps.setString(1, randomS);
			rs = ps.executeQuery();
			if (rs.next()) {
				System.out.printf("repeated code %s found in bracket id %s\n", randomS, rs.getString("bracketID"));
			} else {
				System.out.printf("Unique code %s found!\n", randomS);
				success = true;
			}
			System.out.println("------");
			} catch (SQLException sqle) {
				System.out.println ("SQLException: " + sqle.getMessage());
			} finally {
				try {
					if (rs != null) {
						rs.close();
					}
					if (ps != null) {
						ps.close();
					}
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
		return randomS;
	}
	
	private static int addToUserToStats(int userID, int round) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int userToStatsID = -1;
		int statsID = createStats(round);
		if( statsID == -1) {
			return -1;
		}
		try {
			ps = conn.prepareStatement("INSERT INTO UserToGameStats (userID, statsID) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, Integer.toString(userID));
			ps.setString(2, Integer.toString(statsID));
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			
			if (rs.next()) {
				userToStatsID = rs.getInt(1);
				System.out.printf("pk of userToStatsID is %d\n", userToStatsID);
			} else {
				System.out.println("AAAHHHHH");
			} 
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
			userToStatsID = -1;
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return userToStatsID;
	}
	
	public static BracketIdCodePair createBracket(int userID, String bracketName, int gameType) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			
			// rs = st.executeQuery("SELECT * from Student where fname='" + name + "'");
			ps = conn.prepareStatement("SELECT userID, username FROM Users WHERE userID=?");
			ps.setString(1, Integer.toString(userID));
			rs = ps.executeQuery();
			if (rs.next()) {
				System.out.printf("Valid user found of name %s and userID %s\n", rs.getString("username"), rs.getString("userID"));
			} else {
				System.out.printf("User with id %s not found!\n", userID);
				return null;
			}
			System.out.println("------");
			rs.close();
			ps.close();

			int userToStatsID = addToUserToStats(userID, 1);

			String randomS = generateBracketCode();

			ps = conn.prepareStatement("INSERT INTO Bracket (bracketName, bracketCode, gameType, bracketS8) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, bracketName);
			ps.setString(2, randomS);
			ps.setString(3, Integer.toString(gameType));
			ps.setString(4, Integer.toString(userToStatsID));
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			int bracketID = -1;
			if (rs.next()) {
				bracketID = rs.getInt(1);
				System.out.printf("pk of bracket is %d\n", bracketID);
			}
			
			
			
			
			BracketIdCodePair b = new BracketIdCodePair(bracketID, randomS);
			return b;
			
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
			return null;
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}
	
	private static int addUserToBracket(int userID, int bracketID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int success = -1;
		if (!userInBracket(userID, bracketID)) {
			try {
				// rs = st.executeQuery("SELECT * from Student where fname='" + name + "'");
				ps = conn.prepareStatement("SELECT bracketS8, bracketS9, bracketS10, bracketS11, bracketS12, bracketS13, bracketS14, bracketS15 FROM Bracket WHERE bracketID=?");
				ps.setString(1, Integer.toString(bracketID));
				rs = ps.executeQuery();
				if (rs.next()) {
					for (int i = 1; i <= 8; i++) {
						String temp = rs.getString(i);
						if (temp == null) {
							System.out.printf("empty spot found at slot %d\n", i+7);
							int userToStatsID = addToUserToStats(userID, 1);
							if (userToStatsID != -1) {
								String statement = String.format("UPDATE Bracket SET bracketS%d=%d WHERE bracketID=?", i+7, userToStatsID);
								rs.close();
								ps.close();
								System.out.printf("executing statement %s inside addUserToBracket method\n", statement);
								ps = conn.prepareStatement(statement);
								ps.setString(1, Integer.toString(bracketID));
								ps.executeUpdate();
								connectUserToBracket(userID, bracketID);
								success = 1;
								break;
							}
						}
					}
					
				} else {
					System.out.printf("problem");
				}
				System.out.println("------");
	
				
				
			} catch (SQLException sqle) {
				System.out.println ("SQLException: " + sqle.getMessage());
			} finally {
				try {
					if (rs != null) {
						rs.close();
					}
					if (ps != null) {
						ps.close();
					}
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
			return success;
		} else {
			return -2;
		}
	}
	
	private static void connectUserToBracket(int userID, int bracketID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
		ps = conn.prepareStatement("INSERT INTO UserToBracket (userID, bracketID) VALUES (?, ?)");
		ps.setString(1, Integer.toString(userID));
		ps.setString(2, Integer.toString(bracketID));
		ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}
	
	public static int addUserToBracket(int userID, String bracketCode) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int bracketID = -1;
		try {
			// rs = st.executeQuery("SELECT * from Student where fname='" + name + "'");
			ps = conn.prepareStatement("SELECT bracketID FROM Bracket WHERE bracketCode=?");
			ps.setString(1, bracketCode);
			rs = ps.executeQuery();
			if (rs.next()) {
				bracketID = Integer.parseInt(rs.getString("bracketID"));
				System.out.printf("Valid bracket with ID %d found from code %s\n", bracketID, bracketCode);
				int connect = addUserToBracket(userID, bracketID);
				if (connect < 0) {
					bracketID = connect;
				}
			} else {
				System.out.printf("no bracket with code %s was found\n", bracketCode);
			}
			System.out.println("------");
			rs.close();
			ps.close();

			
			
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return bracketID;
	}
	
	public static Bracket getBracket(int bracketID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Bracket b = null;
		List<UserToStats> lst = new ArrayList<>(15);
		try {
			StringBuilder sb = new StringBuilder("bracketS1");
			for (int i = 2; i <= 15; i++) {
				sb.append(String.format(", bracketS%d", i));
			}
			String query = String.format("SELECT %s FROM Bracket WHERE bracketID=?", sb.toString());
			System.out.printf("Executing Query: %s\n", query);
			ps = conn.prepareStatement("SELECT userID FROM UserToGameStats WHERE userToGameStatsID=?");
			ps.setString(1, Integer.toString(userToStatsID));
			rs = ps.executeQuery();
			if (rs.next()) {
				userID = Integer.parseInt(rs.getString(1));
			} 
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return userID;
	}
	
	public static boolean userInBracket(int userID, int bracketID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean isIn = false;
		try {
		ps = conn.prepareStatement("SELECT userToBracketID FROM UserToBracket WHERE userID=? AND bracketID=?");
		ps.setString(1, Integer.toString(userID));
		ps.setString(2, Integer.toString(bracketID));
		rs = ps.executeQuery();
		if (rs.next()) {
			isIn = true;
		}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return isIn;
	}
	
	private static int userIDofUserToStats(int userToStatsID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int userID = -1;
		try {
			ps = conn.prepareStatement("SELECT userID FROM UserToGameStats WHERE userToGameStatsID=?");
			ps.setString(1, Integer.toString(userToStatsID));
			rs = ps.executeQuery();
			if (rs.next()) {
				userID = Integer.parseInt(rs.getString(1));
			} 
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return userID;
	}
	
	private static int getRound(int statsID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int bracketRound = -1;
		try {
			ps = conn.prepareStatement("SELECT bracketRound FROM Stats WHERE statsID=?");
			ps.setString(1, Integer.toString(statsID));
			rs = ps.executeQuery();
			if (rs.next()) {
				bracketRound = Integer.parseInt(rs.getString("bracketRound"));
			} 
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return bracketRound;
	}
	
	
	public static boolean update(int slot1, int slot2, boolean slot1Won, int bracketID) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean success = false;
		try {
			if (Math.abs(slot1-slot2) > 1) {
				success = false;
			} else {
				// rs = st.executeQuery("SELECT * from Student where fname='" + name + "'");
				ps = conn.prepareStatement("SELECT bracketS?, bracketS? FROM Bracket WHERE bracketID=?");
				ps.setString(1, Integer.toString(slot1));
				ps.setString(2, Integer.toString(slot2));
				ps.setString(3, Integer.toString(bracketID));
				rs = ps.executeQuery();
				int winnerID = -1; 
				if (rs.next()) {
					int uID1 = Integer.parseInt(rs.getString(1));
					int uID2 = Integer.parseInt(rs.getString(2));
					System.out.printf("Valid usersToStats found with ID %s and %s\n", uID1, uID2);
					winnerID = (slot1Won) ? uID1 : uID2;
				} else {
					System.out.printf("problem");
				}
				System.out.println("------");
				rs.close();
				ps.close();
	
				int newSlot = Math.min(slot1, slot2)/2;
				
				int round = (newSlot == 1) ? 3 : 2;
				int userID = userIDofUserToStats(winnerID);
				if (userID != -1) {
					int userToStatsID = addToUserToStats(userID, round);
					ps = conn.prepareStatement("UPDATE Bracket Set bracketS? = ? WHERE bracketID=?");
					ps.setString(1, Integer.toString(newSlot));
					ps.setString(2, Integer.toString(userToStatsID));
					ps.setString(3, Integer.toString(bracketID));
					ps.executeUpdate();
					success = true;
				}				
			}
			
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return success;
	}
	
	public static void main(String[] args) {
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/SportsWebsite?user=root&password=root");
			BracketIdCodePair b = JDBCBracketStuff.createBracket(1, "godgamers", 1);
			System.out.println("bracketCreated");
			int godGamerID = 1;
			int bobTheIdiotID = 2;
			JDBCBracketStuff.addUserToBracket(godGamerID, b.getBracketCode());
			System.out.println("bob added");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
