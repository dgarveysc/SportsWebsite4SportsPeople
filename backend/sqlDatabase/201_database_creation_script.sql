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
    points int(11)
);

CREATE TABLE BracketProgress (
	 bracketProgressID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
     bracketS01 INT NOT NULL,
	 bracketS02 INT NOT NULL,
	 bracketS03 INT NOT NULL,
	 bracketS04 INT NOT NULL,
	 bracketS05 INT NOT NULL,
	 bracketS06 INT NOT NULL,
	 bracketS07 INT NOT NULL,
	 bracketS08 INT NOT NULL,
	 bracketS09 INT NOT NULL,
	 bracketS10 INT NOT NULL,
	 bracketS11 INT NOT NULL,
	 bracketS12 INT NOT NULL,
	 bracketS13 INT NOT NULL,
	 bracketS14 INT NOT NULL,
	 bracketS15 INT NOT NULL,
	 bracketS16 INT NOT NULL,
     bracketID INT NOT NULL,
     FOREIGN KEY fk1(bracketS01) REFERENCES Users(userID),
 FOREIGN KEY fk2(bracketS02) REFERENCES Users(userID),
 FOREIGN KEY fk3(bracketS03) REFERENCES Users(userID),
 FOREIGN KEY fk4(bracketS04) REFERENCES Users(userID),
 FOREIGN KEY fk5(bracketS05) REFERENCES Users(userID),
 FOREIGN KEY fk6(bracketS06) REFERENCES Users(userID),
 FOREIGN KEY fk7(bracketS07) REFERENCES Users(userID),
 FOREIGN KEY fk8(bracketS08) REFERENCES Users(userID),
 FOREIGN KEY fk9(bracketS09) REFERENCES Users(userID),
 FOREIGN KEY fk10(bracketS10) REFERENCES Users(userID),
 FOREIGN KEY fk11(bracketS11) REFERENCES Users(userID),
 FOREIGN KEY fk12(bracketS12) REFERENCES Users(userID),
 FOREIGN KEY fk13(bracketS13) REFERENCES Users(userID),
 FOREIGN KEY fk14(bracketS14) REFERENCES Users(userID),
 FOREIGN KEY fk15(bracketS15) REFERENCES Users(userID),
 FOREIGN KEY fk16(bracketS16) REFERENCES Users(userID)
 );

CREATE TABLE Bracket (
-- don't need INT(11), just say INT
 bracketID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
 bracketName VARCHAR(50) NOT NULL,
 bracketS01 INT NOT NULL,
 bracketS02 INT NOT NULL,
 bracketS03 INT NOT NULL,
 bracketS04 INT NOT NULL,
 bracketS05 INT NOT NULL,
 bracketS06 INT NOT NULL,
 bracketS07 INT NOT NULL,
 bracketS08 INT NOT NULL,
 bracketS09 INT NOT NULL,
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
 bracketS32 INT NOT NULL,
 bracketType INT NOT NULL,
 bracketProgressID INT NOT NULL,
 FOREIGN KEY fk1(bracketS01) REFERENCES Users(userID),
 FOREIGN KEY fk2(bracketS02) REFERENCES Users(userID),
 FOREIGN KEY fk3(bracketS03) REFERENCES Users(userID),
 FOREIGN KEY fk4(bracketS04) REFERENCES Users(userID),
 FOREIGN KEY fk5(bracketS05) REFERENCES Users(userID),
 FOREIGN KEY fk6(bracketS06) REFERENCES Users(userID),
 FOREIGN KEY fk7(bracketS07) REFERENCES Users(userID),
 FOREIGN KEY fk8(bracketS08) REFERENCES Users(userID),
 FOREIGN KEY fk9(bracketS09) REFERENCES Users(userID),
 FOREIGN KEY fk10(bracketS10) REFERENCES Users(userID),
 FOREIGN KEY fk11(bracketS11) REFERENCES Users(userID),
 FOREIGN KEY fk12(bracketS12) REFERENCES Users(userID),
 FOREIGN KEY fk13(bracketS13) REFERENCES Users(userID),
 FOREIGN KEY fk14(bracketS14) REFERENCES Users(userID),
 FOREIGN KEY fk15(bracketS15) REFERENCES Users(userID),
 FOREIGN KEY fk16(bracketS16) REFERENCES Users(userID),
 FOREIGN KEY fk17(bracketS17) REFERENCES Users(userID),
 FOREIGN KEY fk18(bracketS18) REFERENCES Users(userID),
 FOREIGN KEY fk19(bracketS19) REFERENCES Users(userID),
 FOREIGN KEY fk20(bracketS20) REFERENCES Users(userID),
 FOREIGN KEY fk21(bracketS21) REFERENCES Users(userID),
 FOREIGN KEY fk22(bracketS22) REFERENCES Users(userID),
 FOREIGN KEY fk23(bracketS23) REFERENCES Users(userID),
 FOREIGN KEY fk24(bracketS24) REFERENCES Users(userID),
 FOREIGN KEY fk25(bracketS25) REFERENCES Users(userID),
 FOREIGN KEY fk26(bracketS26) REFERENCES Users(userID),
 FOREIGN KEY fk27(bracketS27) REFERENCES Users(userID),
 FOREIGN KEY fk28(bracketS28) REFERENCES Users(userID),
 FOREIGN KEY fk29(bracketS29) REFERENCES Users(userID),
 FOREIGN KEY fk30(bracketS30) REFERENCES Users(userID),
 FOREIGN KEY fk31(bracketS32) REFERENCES Users(userID),
 FOREIGN KEY fk32(bracketS32) REFERENCES Users(userID),
 FOREIGN KEY fk33(bracketProgressID) REFERENCES BracketProgress(bracketProgressID)
 );
 
 CREATE TABLE Stats (
	statsID INT(11) PRIMARY KEY AUTO_INCREMENT,
	avgPPG INT(11) NULL,
    gamesBetSoFar INT(8) NULL
    
);
 
 CREATE TABLE BracketToUserToStats (
	bracketToUserToStatsID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    groupID INT NOT NULL,
    statsID INT NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID),
    FOREIGN KEY fk2(groupID) REFERENCES Bracket(bracketID),
    FOREIGN KEY fk3(statsID) REFERENCES Stats(statsID)
 );
 
CREATE TABLE Games (
	gameID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID1 INT NOT NULL,
    userID2 INT NOT NULL,
    gameName varchar(50) NOT NULL,
    FOREIGN KEY fk1(userID1) REFERENCES Users(userID),
    FOREIGN KEY fk2(userID2) REFERENCES Users(userID)
);



Create TABLE Friends(
	friendID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	userID1 INT(11) ,
    userID2 INT(11) NOT NULL,
    FOREIGN KEY fk1(UserID1) REFERENCES Users(userID),
    FOREIGN KEY fk2(UserID2) REFERENCES Users(userID)
);
Create TABLE Teams(
	teamID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    gameType int(5),
    powerRating int(10),
    image_url varchar(100),
    teamName varchar(50)
);

CREATE TABLE GameInStat (
	gameInStatID INT(11) PRIMARY KEY AUTO_INCREMENT,
    statsID INT(11) NOT NULL,
    gameID INT(11) NOT NULL,
    resultingPoints INT(11) NULL,
	FOREIGN KEY fk1(statsID) REFERENCES Stats(statsID),
	FOREIGN KEY fk2(gameID) REFERENCES Games(gameID)
);



CREATE TABLE UsersToBracket (
	usersToBracketID INT(11) PRIMARY KEY AUTO_INCREMENT,
	usersID INT(11) NOT NULL,
    bracketID INT(11) NOT NULL,
    FOREIGN KEY fk1(usersID) REFERENCES Users(userID),
    FOREIGN KEY fk2(bracketID) REFERENCES Bracket(bracketID)
);
