package bracket;

public class User {
	
	private int userID;
	private String name;
	
	public User (int userID, String name) {
		this.userID = userID;
		this.name = name;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String toString() {
		return String.format("userID: %d, name: %s", userID, name);
	}
}
