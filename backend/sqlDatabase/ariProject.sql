/*
Changed User to Users
Changed bracket to Bracket
*/

CREATE TABLE GameInStat (
	gameInStatID INT(11) PRIMARY KEY AUTO_INCREMENT,
    statsID INT(11) NOT NULL,
    gameID INT(11) NOT NULL,
    resultingPoints INT(11) NULL,
	FOREIGN KEY fk1(statsID) REFERENCES Stats(statsID),
	FOREIGN KEY fk2(gameID) REFERENCES Games(gameID)
);

CREATE TABLE Stats (
	statsID INT(11) PRIMARY KEY AUTO_INCREMENT,
	avgPPG INT(11) NULL,
    gamesBetSoFar INT(8) NULL,
    bracketToUsersToStatsID INT(11) NOT NULL,
    FOREIGN KEY fk1(bracketToUsersToStatsID) REFERENCES BracketToUsersToStats(bracketToUserToStatsID)
);

CREATE TABLE UsersToBracket (
	usersToBracketID INT(11) PRIMARY KEY AUTO_INCREMENT,
	usersID INT(11) NOT NULL,
    bracketID INT(11) NOT NULL,
    FOREIGN KEY fk1(usersID) REFERENCES Users(usersID),
    FOREIGN KEY fk2(bracketID) REFERENCES Bracket(bracketID)
);