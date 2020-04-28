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
	
	public String toString() {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < bracket.size(); i++) {
			sb.append(String.format("Bracket Slot %d ", i+1));
			if (bracket.get(i) == null)
				sb.append("null");
			else
				sb.append(bracket.get(i).toString());
			sb.append("\n");
		}
		return sb.toString();
	}
}
