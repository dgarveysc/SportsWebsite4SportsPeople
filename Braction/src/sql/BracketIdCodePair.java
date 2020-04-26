package sql;

import java.io.Serializable;

public class BracketIdCodePair implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7669173181368623527L;
	private int bracketID;
	private String bracketCode;
	
	public BracketIdCodePair(int bracketID, String bracketCode) {
		this.bracketID = bracketID;
		this.bracketCode = bracketCode;
	}
	
	public int getBracketID() {
		return bracketID;
	}

	public void setBracketID(int bracketID) {
		this.bracketID = bracketID;
	}

	public String getBracketCode() {
		return bracketCode;
	}

	public void setBracketCode(String bracketCode) {
		this.bracketCode = bracketCode;
	}
}
