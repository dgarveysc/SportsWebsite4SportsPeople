package bracket;

public class UserToStats {

	private User user;
	private boolean won;
	
	public UserToStats(User user, boolean won) {
		this.user = user;
		this.won = won;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public boolean isWon() {
		return won;
	}

	public void setWon(boolean won) {
		this.won = won;
	}
	
	
}
