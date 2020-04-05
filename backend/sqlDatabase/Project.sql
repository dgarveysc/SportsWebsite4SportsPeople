DROP DATABASE IF EXISTS SportsWebsite;
CREATE DATABASE SportsWebsite;

USE SportsWebsite;
CREATE TABLE Users(
	UserID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    passphrase VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    points int(11)
);
Create TABLE Friends(
	FriendID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	UserID1 INT(11) ,
    UserID2 INT(11) NOT NULL,
    FOREIGN KEY (UserID1) REFERENCES Users(UserID),
    FOREIGN KEY (UserID2) REFERENCES Users(UserID)
);
Create TABLE Teams(
	teamID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    gameType int(5),
    powerRating int(10),
    image_url varchar(100),
    teamName varchar(50)
);