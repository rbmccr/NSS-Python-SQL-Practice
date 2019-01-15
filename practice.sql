-- Sometimes needed when you want to delete rows from a table while preserving the table
-- DELETE FROM User;
-- DELETE FROM Task;
-- DELETE FROM PowerType;
-- DELETE FROM SuperheroWeakness;
-- DELETE FROM Weakness;
-- DELETE FROM Sidekick;
-- DELETE FROM Superhero;

-- Makes sure the CASCADE works
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS News_Article;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Relationship;

-- What's up with CONSTRAINTS?
-- https://www.techonthenet.com/sqlite/foreign_keys/foreign_delete.php

CREATE TABLE `User` (
    `userId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `displayName`    TEXT NOT NULL,
    `email`    TEXT NOT NULL,
    `password`    TEXT NOT NULL
);

INSERT INTO User VALUES (null, 'Brendan', 'brendan@email.com', 'password');
INSERT INTO User VALUES (null, 'Zac', 'zac@email.com', 'password2');

CREATE TABLE `Task` (
    `taskId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `dueBy`    TEXT NOT NULL,
    `name`    TEXT NOT NULL,
    `status`    TEXT NOT NULL,
    `userId`    INTEGER NOT NULL,
    FOREIGN KEY(`userId`)
 REFERENCES `User`(`userId`)
 ON DELETE cascade
);

INSERT INTO Task VALUES (null, '01/15/2019', 'First task', 'in progess', 1);
INSERT INTO Task VALUES (null, '01/16/2019', 'Second task', 'complete', 1);

CREATE TABLE `News_Article` (
    `newsId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `title`    TEXT NOT NULL,
    `summary`    TEXT NOT NULL,
    `timestamp`    TEXT NOT NULL,
    `url`    TEXT NOT NULL,
    `userId`    INTEGER NOT NULL,
    FOREIGN KEY(`userId`)
 REFERENCES `User`(`userId`)
 ON DELETE cascade
);

INSERT INTO News_Article VALUES (null, 'Article 1', 'Some description here', '01/15/2019 11:17 AM', 'www.link.com', 1);
INSERT INTO News_Article VALUES (null, 'Article 2', 'Some description here 2', '01/15/2019 11:18 AM', 'www.link2.com', 2);

CREATE TABLE `Event` (
    `eventId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `name`    TEXT NOT NULL,
    `location`    TEXT NOT NULL,
    `date`    TEXT NOT NULL,
    `userId`    INTEGER NOT NULL,
    FOREIGN KEY(`userId`)
 REFERENCES `User`(`userId`)
 ON DELETE cascade
);

INSERT INTO Event VALUES (null, 'Event 1', 'Location 1', '01/15/2019', 2);
INSERT INTO Event VALUES (null, 'Event 2', 'Location 2', '01/16/2019', 1);

CREATE TABLE `Messages` (
    `messageId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `text`    TEXT NOT NULL,
    `isEdited`    BIT NOT NULL,
    `userId`    INTEGER NOT NULL,
    FOREIGN KEY(`userId`)
 REFERENCES `User`(`userId`)
 ON DELETE cascade
);

INSERT INTO Messages VALUES (null, 'Message text here', 1, 2);
INSERT INTO Messages VALUES (null, 'Message text here 2', 0, 1);

CREATE TABLE `Relationship` (
  `relationshipId`  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `userId` INTEGER NOT NULL,
  `friendId` INTEGER NOT NULL,
  FOREIGN KEY(`userId`) REFERENCES `User`(`userId`)
  FOREIGN KEY(`friendId`) REFERENCES `User`(`userId`)
  ON DELETE cascade
);

INSERT INTO Relationship VALUES (null, 1, 2);
INSERT INTO Relationship VALUES (null, 2, 1);

-- SELECT User.displayName, User.displayName as 'Friend'
-- FROM User
-- JOIN Relationship
-- ON Relationship.userId = User.userId
-- JOIN User
-- ON Relationship.friendId = User.userId