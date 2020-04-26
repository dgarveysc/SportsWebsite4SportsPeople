-- most dangerous sql statment
DROP DATABASE IF EXISTS SportsWebsite;
-- create database statement
CREATE DATABASE SportsWebsite;
USE SportsWebsite;
 
  CREATE TABLE GameTypes(
	gameTypeID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    gameTypeName VARCHAR(50) NOT NULL
 );
 
 CREATE TABLE Stats (
	statsID INT(11) PRIMARY KEY AUTO_INCREMENT,
	won BOOLEAN NULL,
	prize INT(11) NULL,
	bracketRound INT(11) NULL,
	gameID INT(11) NULL, -- in case we add support for different games
	xp INT(11) NULL,
	gameDate DATE NULL, -- date score is updated on
	oppRank INT(11) NULL, -- to get information about opponents rank
	FOREIGN KEY fk1(gameID) REFERENCES GameTypes(gameTypeID)
);

CREATE TABLE Users(
	UserID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    passphrase VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    points int(11) NULL
);

 CREATE TABLE UserToGameStats(
	userToGameStatsID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    statsID INT NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID),
    FOREIGN KEY fk2(statsID) REFERENCES Stats(statsID)
 );
 

 
 INSERT INTO GameTypes (gameTypeName) VALUES('NBA'), ('FIFA'), ('Madden');


CREATE TABLE Bracket (
-- don't need INT(11), just say INT
 bracketID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
 bracketName VARCHAR(50) NOT NULL,
 bracketCode VARCHAR(50) NOT NULL,
 gameType INT NOT NULL,
 bracketS1 INT NULL,
 bracketS2 INT NULL,
 bracketS3 INT NULL,
 bracketS4 INT NULL,
 bracketS5 INT NULL,
 bracketS6 INT NULL,
 bracketS7 INT NULL,
 bracketS8 INT NOT NULL, -- represents the host/creator of the tourney. always in slot 8
 bracketS9 INT NULL,
 bracketS10 INT NULL,
 bracketS11 INT NULL,
 bracketS12 INT NULL,
 bracketS13 INT NULL,
 bracketS14 INT NULL,
 bracketS15 INT NULL,
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
 FOREIGN KEY fk16(gameType) REFERENCES GameTypes(gameTypeID)
 );
 

 
 CREATE TABLE UserToBracket (
	userToBracketID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    bracketID INT NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID),
    FOREIGN KEY fk2(bracketID) REFERENCES Bracket(bracketID)
 );
 



Create TABLE Friends(
	friendID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	userID1 INT,
    userID2 INT NOT NULL,
    acceptedStatus INT NOT NULL,
    FOREIGN KEY fk1(UserID1) REFERENCES Users(userID),
    FOREIGN KEY fk2(UserID2) REFERENCES Users(userID)
);
INSERT INTO Users (username, passphrase, email, points) VALUES ('god gamer', 'mwhaha','god_gamer@godgames.god',69);
INSERT INTO Users (username, passphrase, email, points) VALUES ('bob the potato', 'bloop','5iq@dumbdumb.com',0);
INSERT INTO Stats (won, prize, bracketRound, gameID, xp, gameDate, oppRank) VALUES (TRUE, 50, 1, 3, 1, '2020-04-25', 1200);
