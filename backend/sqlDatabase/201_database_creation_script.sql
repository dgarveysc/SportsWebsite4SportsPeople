-- most dangerous sql statment
DROP DATABASE IF EXISTS SportsWebsite;
-- create database statement
CREATE DATABASE SportsWebsite;
USE Betting;

CREATE TABLE Users(
	UserID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    passphrase VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    points INT(11),
		elo INT(11),
    --statsID INT(11) NOT NULL, (not needed b/c stats represent )
    FOREIGN KEY fk3(statsID) REFERENCES Stats(statsID)
);

CREATE TABLE Bracket (
-- don't need INT(11), just say INT
 bracketID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
 gameID INT NULL, --in case we delineate by game for statistics and rank
 bracketName VARCHAR(50) NOT NULL,
 bracketS1 INT NOT NULL,
 bracketS2 INT NOT NULL,
 bracketS3 INT NOT NULL,
 bracketS4 INT NOT NULL,
 bracketS5 INT NOT NULL,
 bracketS6 INT NOT NULL,
 bracketS7 INT NOT NULL,
 bracketS8 INT NOT NULL,
 bracketS9 INT NOT NULL,
 bracketS10 INT NOT NULL,
 bracketS11 INT NOT NULL,
 bracketS12 INT NOT NULL,
 bracketS13 INT NOT NULL,
 bracketS14 INT NOT NULL,
 bracketS15 INT NOT NULL,
 bracketS16 INT NOT NULL,
 bracketS17 INT NOT NULL,
 bracketS18 INT NOT NULL,
 bracketS19 INT NOT NULL,
 bracketS20 INT NOT NULL,
 bracketS21 INT NOT NULL,
 bracketS22 INT NOT NULL,
 bracketS23 INT NOT NULL,
 bracketS24 INT NOT NULL,
 bracketS25 INT NOT NULL,
 bracketS26 INT NOT NULL,
 bracketS27 INT NOT NULL,
 bracketS28 INT NOT NULL,
 bracketS29 INT NOT NULL,
 bracketS30 INT NOT NULL,
 bracketS31 INT NOT NULL,
 bracketType INT NOT NULL,
 FOREIGN KEY fk1(bracketS1) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk2(bracketS2) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk3(bracketS3) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk4(bracketS4) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk5(bracketS5) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk6(bracketS6) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk7(bracketS7) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk8(bracketS8) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk9(bracketS9) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk10(bracketS10) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk11(bracketS11) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk12(bracketS12) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk13(bracketS13) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk14(bracketS14) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk15(bracketS15) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk16(bracketS16) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk17(bracketS17) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk18(bracketS18) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk19(bracketS19) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk20(bracketS20) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk21(bracketS21) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk22(bracketS22) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk23(bracketS23) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk24(bracketS24) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk25(bracketS25) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk26(bracketS26) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk27(bracketS27) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk28(bracketS28) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk29(bracketS29) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk30(bracketS30) REFERENCES UserToGameStats(userToGameStatsID),
 FOREIGN KEY fk31(bracketS31) REFERENCES UserToGameStats(userToGameStatsID)
 );

 CREATE TABLE Stats (
	 --assume this table is in chronological order, created when user updates a score
	 --immediately update
	statsID INT(11) PRIMARY KEY AUTO_INCREMENT,
	won BOOLEAN NOT NULL,
	prize INT(11) NULL,
	bracketRound INT(11) NOT NULL,
	gameID INT(11) NULL, --in case we add support for different games
	xp INT(11) NOT NULL,
	oppRank INT(11) NULL --to get information about opponent's rank
);

 CREATE TABLE UserToBracket (
	userToBracketID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    bracketID INT NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID),
    FOREIGN KEY fk2(bracketID) REFERENCES Bracket(bracketID)
 );

 CREATE TABLE UserToGameStats(
	userToGameStatsID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    statsID INT NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID),
    FOREIGN KEY fk2(statsID) REFERENCES Stats(statsID)
 );


Create TABLE Friends(
	friendID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	userID1 INT(11) ,
    userID2 INT(11) NOT NULL,
    FOREIGN KEY fk1(UserID1) REFERENCES Users(userID),
    FOREIGN KEY fk2(UserID2) REFERENCES Users(userID)
);
