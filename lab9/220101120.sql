-- Active: 1707125319385@@127.0.0.1@3306@week08
-- TASK 01

-- Creates the required database.CREATE DATABASE week06;
CREATE DATABASE week09;

-- We start using the database made above.
USE week09;

-- TASK 02

-- Creating the tables with required specifications.

CREATE TABLE sailors(
    sid INT PRIMARY KEY,
    sname CHAR(50),
    rating INT,
    age DECIMAL(3,1)
);

CREATE TABLE boats(
    bid INT PRIMARY KEY,
    bname CHAR(50),
    bcolor CHAR(50)
);

CREATE TABLE reserves(
    sid INT,
    bid INT,
    day char(50),
    PRIMARY KEY(sid,bid,day),
    FOREIGN KEY (sid) REFERENCES sailors(sid),
    FOREIGN KEY (bid) REFERENCES boats(bid)
);
-- TASK 03

-- Inserting the values from another file created using the C program task9.c
-- Update the file path as per convinience
SOURCE sailors_populate.sql;
SOURCE boats_populate.sql;
SOURCE reserves_populate.sql;

-- TASK 04 

-- Creating updatable views
-- A
CREATE VIEW sailors_s AS
SELECT sid,rating
FROM sailors;

INSERT INTO sailors_s(sid,rating) 
VALUES(91,7);
INSERT INTO sailors_s(sid,rating) 
VALUES(92,8);
INSERT INTO sailors_s(sid,rating) 
VALUES(93,9);
INSERT INTO sailors_s(sid,rating) 
VALUES(94,10);
INSERT INTO sailors_s(sid,rating) 
VALUES(22,8);

UPDATE sailors_s SET rating = 8 WHERE sid = 91;

DELETE FROM sailors_s WHERE sid = 91;

-- B
CREATE VIEW green_boats AS
SELECT * FROM boats
WHERE bcolor = 'green';

INSERT INTO green_boats(bid,bname,bcolor)
VALUES (205, 'River Mania', 'green')

INSERT INTO green_boats(bid,bname,bcolor)
VALUES (206, 'green-bird', 'green')

INSERT INTO green_boats(bid,bname,bcolor)
VALUES (207, 'blue-warriors','blue')

CREATE VIEW only_green_boats AS
SELECT * FROM boats
WHERE bcolor = 'green'
WITH CHECK OPTION;

INSERT INTO only_green_boats(bid,bname,bcolor)
VALUES (207, 'blue-warriors', 'blue');

-- C
CREATE VIEW neww AS
SELECT sid,rating,bid,bname
FROM sailors,boats;


INSERT INTO neww(sid,rating)
VALUES (80,8);

INSERT INTO neww(bid,bname) 
VALUES(105,'Lucky Lake');

UPDATE neww SET bname='Jumper' WHERE bid = 101;
UPDATE neww SET bname='Interlake' WHERE bid = 101;

-- Creating views that are not updatable

-- A
CREATE VIEW max_rated_sailor AS
SELECT sid,sname,allCols.rating,allCols.bid,bname
FROM (
        SELECT *
        FROM sailors NATURAL JOIN boats NATURAL JOIN reserves
) as allCols,
    (
        SELECT bid,max(rating) as rating
        FROM sailors NATURAL JOIN boats NATURAL JOIN reserves
        GROUP BY bid
) as max_ratings
WHERE allCols.bid = max_ratings.bid AND allCols.rating = max_ratings.rating;


INSERT INTO max_rated_sailor(sid,sname,rating)
VALUES (80,'best_sailor',10);

UPDATE max_rated_sailor SET rating=-9 WHERE sid = 74;

DELETE FROM max_rated_sailor WHERE sid=74;

UPDATE max_rated_sailor SET bname = 'Can I get updated?' WHERE bid = 102;


-- B
CREATE VIEW distinct_ratings AS
SELECT DISTINCT(rating) 
FROM sailors;

INSERT INTO distinct_ratings (rating) 
VALUES(2);

UPDATE distinct_ratings SET rating = -7 WHERE rating = 7;

DELETE FROM distinct_ratings WHERE rating = 7;

-- C
CREATE VIEW sameBoats AS
SELECT * 
FROM sailors NATURAL JOIN reserves
GROUP BY rating;
-- The above made view won't work as we cannot select all coloums in the join operation as they are not aggregated columns and are functionally independent of the group by clause.

INSERT INTO sameBoats(sid,sname,rating,age)
VALUES (80,'budding sailor',10,25);

UPDATE sameBoats SET rating = 6 WHERE rating = 8;
DELETE FROM sameBoats WHERE rating = 7;
-- D

CREATE VIEW sameBoatsNew AS
SELECT * 
FROM sailors NATURAL JOIN reserves
GROUP BY rating
HAVING age > 36;
-- The above made view won't work as we cannot select all coloums in the join operation as they are not aggregated columns and are functionally independent of the group by clause.

INSERT INTO sameBoatsNew(sid,sname,rating,age)
VALUES (80,'budding sailor',10,25);

UPDATE sameBoatsNew SET rating = 6 WHERE rating = 8;
DELETE FROM sameBoatsNew WHERE rating = 7;



-- E 
CREATE VIEW blueORgreen AS
(SELECT sid,sname,bid,bcolor
FROM sailors NATURAL JOIN boats NATURAL JOIN reserves
WHERE bcolor = 'blue')
UNION
(SELECT sid,sname,bid,bcolor
FROM sailors NATURAL JOIN boats NATURAL JOIN reserves
WHERE bcolor = 'green');


INSERT INTO blueORgreen(sid,rating)
VALUES(81,9);

UPDATE blueORgreen SET sid = 9 WHERE sid = 22;

DELETE FROM blueORgreen WHERE sid = 22;

-- Creating views using views

-- Using the first A 
CREATE VIEW Only_ratings AS
SELECT rating 
FROM sailors_s;

INSERT INTO Only_ratings(rating)
VALUES(7);
INSERT INTO Only_ratings(rating)
VALUES(8);
INSERT INTO Only_ratings(rating)
VALUES(9);
INSERT INTO Only_ratings(rating)
VALUES(10);
INSERT INTO Only_ratings(rating)
VALUES(8);

UPDATE Only_ratings SET rating = 9 WHERE rating = 8;

DELETE FROM Only_ratings WHERE rating = 10;

CREATE VIEW uses AS
SELECT sid,bname,day
FROM green_boats,reserves
WHERE green_boats.bid = reserves.bid;

-- Effect of altering original tables on views
ALTER TABLE sailors RENAME COLUMN rating to rting;

SELECT * FROM sailors_s;
SELECT * FROM neww;

SELECT * FROM max_rated_sailor;

SELECT * FROM distinct_ratings;

SELECT * FROM Only_ratings; 

ALTER TABLE sailors RENAME COLUMN rting to rating;

SELECT * FROM sailors_s;
SELECT * FROM neww;

SELECT * FROM max_rated_sailor;

SELECT * FROM distinct_ratings;

SELECT * FROM Only_ratings; 

ALTER TABLE sailors DROP COLUMN rating;

SELECT * FROM sailors_s;
SELECT * FROM neww;

SELECT * FROM max_rated_sailor;

SELECT * FROM distinct_ratings;

SELECT * FROM Only_ratings; 


-- Type conversion

CREATE TABLE sailors_1(
    sid INT PRIMARY KEY,
    sname CHAR(50),
    rating INT,
    age DECIMAL(3,1)
);

CREATE TABLE boats_1(
    bid INT PRIMARY KEY,
    bname CHAR(50),
    bcolor CHAR(50)
);

CREATE TABLE reserves_1(
    sid INT,
    bid INT,
    day char(50),
    PRIMARY KEY(sid,bid,day),
    constraint fk1 FOREIGN KEY (sid) REFERENCES sailors_1(sid),
    constraint fk2 FOREIGN KEY (bid) REFERENCES boats_1(bid)
);

SOURCE sailors_1_populate.sql;
SOURCE boats_1_populate.sql;
SOURCE reserves_1_populate.sql;

ALTER TABLE reserves_1 DROP CONSTRAINT fk1;
ALTER TABLE reserves_1 DROP CONSTRAINT fk2;

ALTER TABLE sailors_1 MODIFY COLUMN sid SMALLINT;
ALTER TABLE reserves_1 MODIFY COLUMN sid SMALLINT;

ALTER TABLE boats_1 MODIFY COLUMN bid CHAR(3);
ALTER TABLE reserves_1 MODIFY COLUMN bid CHAR(3);

ALTER TABLE boats_1 MODIFY COLUMN bcolor CHAR(5);

ALTER TABLE reserves_1 ADD constraint fk1 FOREIGN KEY (sid) REFERENCES sailors_1(sid);
ALTER TABLE reserves_1 ADD constraint fk2 FOREIGN KEY (bid) REFERENCES boats_1(bid);