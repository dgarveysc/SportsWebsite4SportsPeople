package bracket;

import java.util.List;

public class Bracket {
	
	private List<UserToStats> bracket;
	
	public Bracket(List<UserToStats> b) {
		this.bracket = b;
	}

	public List<UserToStats> getBracket() {
		return bracket;
	}

	public void setBracket(List<UserToStats> bracket) {
		this.bracket = bracket;
	}	
}
