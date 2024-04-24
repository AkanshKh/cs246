-- Active: 1707125319385@@127.0.0.1@3306@week05


-- TASK 01

-- Creates the required database.CREATE DATABASE week06;
CREATE DATABASE week06;


-- We start using the database made above.
USE week06;

-- TASK 02

-- Creating the table with required specifications.
CREATE TABLE T01(
    a int,
    b int,
    c int UNIQUE NOT NULL,
    d int UNIQUE NOT NULL,
    e int,
    PRIMARY KEY(a,b)
);

-- Inserting the values from another file created using the C program task2.c
-- Update the file path as per convinience
SOURCE task02.sql;
-- All the errors are being displayed on the mysql termianal.


-- TASK 03

-- Creating the table with required specifications.
CREATE TABLE T02(
    f int,
    a int,
    b int,
    PRIMARY KEY(f),
    FOREIGN KEY(a,b) REFERENCES T01(a,b)
);

-- Inserting the values from another file created using the C program task3.c
-- Update the file path as per convinience
SOURCE task03.sql;
-- All the errors are being displayed on the mysql termianal.



-- TASK 04

-- Creating the table with required specifications.
CREATE TABLE T03(
    h int,
    i int,
    f int,
    PRIMARY KEY (h),
    FOREIGN KEY(f) REFERENCES T02(f)
);

-- Inserting the values from another file created using the C program task4.c
-- Update the file path as per convinience
SOURCE task04.sql;
-- All the errors are being displayed on the mysql termianal.


-- TASK 05

-- Creating the table with required specifications.
CREATE TABLE T04(
    k int,
    h int,
    PRIMARY KEY(h),
    FOREIGN KEY (h) REFERENCES T03(h)
);

-- Inserting the values from another file created using the C program task5.c
-- Update the file path as per convinience

SOURCE task05.sql;-- All the errors are being displayed on the mysql termianal.




-- TASK 06

-- Deleting all records from the tables made above.
-- Since we were asked for successful demonstration, the order of deletion is changed because table T01 cannot be deleted before table T02 as it's primary key is referenced in table T02. Similarly for other tables, their primary key is referenced in other tables except T04.
-- By deleting in the order given below we can successfully delete all tables.

DELETE FROM T04;
DELETE FROM T03;
DELETE FROM T02;
DELETE FROM T01;

-- Dropping all the tables.
-- This again get successfully demonstrated by changing the order, the reason being explained before.

DROP TABLE T04;
DROP TABLE T03;
DROP TABLE T02;
DROP TABLE T01;

-- TASK 07

-- Creating the tables with required specifications.

CREATE TABLE T01a(
    a int,
    b int,
    c int UNIQUE NOT NULL,
    d int UNIQUE NOT NULL,
    e int,
    PRIMARY KEY(a,b)
);

CREATE TABLE T02a(
    f int,
    a int,
    b int,
    PRIMARY KEY(a),
    FOREIGN KEY(a,b) REFERENCES T01a(a,b) on DELETE CASCADE
);

-- Inserting the values from another file created using the C program task7.c
-- Update the file path as per convinience
source task07.sql;
-- All the errors are being displayed on the mysql termianal.



-- Deleting the data as mentioned in the problem statement.
DELETE FROM T01a WHERE a=297 AND b=77408;
DELETE FROM T01a WHERE a=606 AND b=48191;
DELETE FROM T01a WHERE a=1071 AND b=47061;
DELETE FROM T01a WHERE a=1080 AND b=48533;
DELETE FROM T01a WHERE a=2268 AND b=21577;
DELETE FROM T01a WHERE a=3130 AND b=79583;
DELETE FROM T01a WHERE a=3613 AND b=84692;
DELETE FROM T01a WHERE a=3713 AND b=19837;
DELETE FROM T01a WHERE a=3720 AND b=49661;
DELETE FROM T01a WHERE a=4036 AND b=38648;

-- Searching the data we deleted initially in the other table.

SELECT * FROM T02a WHERE a=297 AND b=77408;
SELECT * FROM T02a WHERE a=606 AND b=48191;
SELECT * FROM T02a WHERE a=1071 AND b=47061;
SELECT * FROM T02a WHERE a=1080 AND b=48533;
SELECT * FROM T02a WHERE a=2268 AND b=21577;
SELECT * FROM T02a WHERE a=3130 AND b=79583;
SELECT * FROM T02a WHERE a=3613 AND b=84692;
SELECT * FROM T02a WHERE a=3713 AND b=19837;
SELECT * FROM T02a WHERE a=3720 AND b=49661;
SELECT * FROM T02a WHERE a=4036 AND b=38648;

-- TASK 08

-- Creating the tables with required specifications.

CREATE TABLE T01b(
    a int,
    b int,
    c int UNIQUE NOT NULL,
    d int UNIQUE NOT NULL,
    e int,
    PRIMARY KEY(a,b)
);


CREATE TABLE T02b(
    f int,
    a int,
    b int,
    PRIMARY KEY(a),
    FOREIGN KEY(a,b) REFERENCES T01b(a,b) on UPDATE CASCADE
);

-- Inserting the values from another file created using the C program task8.c
-- Update the file path as per convinience
SOURCE task08.sql;
-- All the errors are being displayed on the mysql termianal.



-- Updating the data as mentioned in the problem statement.
UPDATE T01b SET a=298 WHERE a=297;
UPDATE T01b SET a=607 WHERE a=607;
UPDATE T01b SET a=21577 WHERE a=2269;
UPDATE T01b SET a=79583 WHERE a=3131;
UPDATE T01b SET a=49661 WHERE a=3721;
UPDATE T01b SET a=38648 WHERE a=4037;

UPDATE T01b SET b=47062 WHERE b=1071;
UPDATE T01b SET b=48534 WHERE b=1080;
UPDATE T01b SET b=84693 WHERE b=3613;
UPDATE T01b SET b=19838 WHERE b=3713;



-- Searching the data we updated initially in the other table.
SELECT * FROM T02b WHERE a=298;
SELECT * FROM T02b WHERE a=607;
SELECT * FROM T02b WHERE a=21577;
SELECT * FROM T02b WHERE a=79583;
SELECT * FROM T02b WHERE a=49661;
SELECT * FROM T02b WHERE a=38648;

SELECT * FROM T02b WHERE b=47062;
SELECT * FROM T02b WHERE b=48534;
SELECT * FROM T02b WHERE b=84693;
SELECT * FROM T02b WHERE b=19838;


-- TASK 09

-- Creating the tables with required specifications.

CREATE TABLE T01c(
    a int,
    b int,
    c int UNIQUE NOT NULL,
    d int UNIQUE NOT NULL,
    e int,
    PRIMARY KEY(a,b)
);

CREATE TABLE T02c(
    f int,
    a int,
    b int,
    PRIMARY KEY(a),
    FOREIGN KEY(a,b) REFERENCES T01c(a,b) on UPDATE CASCADE on DELETE CASCADE
);


-- Inserting the values from another file created using the C program task9.c
-- Update the file path as per convinience
SOURCE task09.sql;
-- All the errors are being displayed on the mysql termianal.



-- Deleting the data as mentioned in the problem statement.

DELETE FROM T01c WHERE a=297 AND b=77408;
DELETE FROM T01c WHERE a=606 AND b=48191;
DELETE FROM T01c WHERE a=1071 AND b=47061;
DELETE FROM T01c WHERE a=1080 AND b=48533;
DELETE FROM T01c WHERE a=2268 AND b=21577;
DELETE FROM T01c WHERE a=3130 AND b=79583;
DELETE FROM T01c WHERE a=3613 AND b=84692;
DELETE FROM T01c WHERE a=3713 AND b=19837;
DELETE FROM T01c WHERE a=3720 AND b=49661;
DELETE FROM T01c WHERE a=4036 AND b=38648;


-- Searching the data we deleted initially in the other table.

SELECT * FROM T02c WHERE a=297 AND b=77408;
SELECT * FROM T02c WHERE a=606 AND b=48191;
SELECT * FROM T02c WHERE a=1071 AND b=47061;
SELECT * FROM T02c WHERE a=1080 AND b=48533;
SELECT * FROM T02c WHERE a=2268 AND b=21577;
SELECT * FROM T02c WHERE a=3130 AND b=79583;
SELECT * FROM T02c WHERE a=3613 AND b=84692;
SELECT * FROM T02c WHERE a=3713 AND b=19837;
SELECT * FROM T02c WHERE a=3720 AND b=49661;
SELECT * FROM T02c WHERE a=4036 AND b=38648;

-- Updating the data as mentioned in the problem statement.

UPDATE T01c SET a=4129 WHERE a=4128;
UPDATE T01c SET a=4189 WHERE a=4182;
UPDATE T01c SET a=4676 WHERE a=4675;
UPDATE T01c SET a=4850 WHERE a=4849;
UPDATE T01c SET a=6196 WHERE a=6195;

UPDATE T01c SET b=32143 WHERE b=32142;
UPDATE T01c SET b=98681 WHERE b=98680;
UPDATE T01c SET b=27251 WHERE b=27250;
UPDATE T01c SET b=33912 WHERE b=33911;
UPDATE T01c SET b=53095 WHERE b=53094;

-- Searching the data we updated initially in the other table.

SELECT * FROM T02c WHERE a=4129;
SELECT * FROM T02c WHERE a=4189;
SELECT * FROM T02c WHERE a=4676;
SELECT * FROM T02c WHERE a=4850;
SELECT * FROM T02c WHERE a=6196;

SELECT * FROM T02c WHERE b=32143;
SELECT * FROM T02c WHERE b=98681;
SELECT * FROM T02c WHERE b=27251;
SELECT * FROM T02c WHERE b=33912;
SELECT * FROM T02c WHERE b=53095;




-- TASK 10

-- Deleting all records from the tables made above.
-- Since we were asked for successful demonstration, the order of deletion is changed because table T01a cannot be deleted before table T02a as it's primary key is referenced in table T02a. Similarly for other .
-- By deleting in the order given below we can successfully delete all tables.

DELETE FROM T02a;
DELETE FROM T01a;
DELETE FROM T02b;
DELETE FROM T01b;
DELETE FROM T02c;
DELETE FROM T01c;


-- Dropping all the tables.
-- This again get successfully demonstrated by changing the order, the reason being explained before.

DROP TABLE T02a;
DROP TABLE T01a;
DROP TABLE T02b;
DROP TABLE T01b;
DROP TABLE T02c;
DROP TABLE T01c;


-- TASK 11

-- Creating the tables with required specifications.

CREATE TABLE T01d(
    a int,
    b int,
    c int,
    PRIMARY KEY(a)  
);
CREATE TABLE T02d(
    d int,
    e int,
    PRIMARY KEY(e)
);

-- Adding the foriegn key constraints to the above made tables.
-- These were not aded during the creation of table because we needed reference to the tables made afterwards.


ALTER TABLE T01d
ADD CONSTRAINT for1 FOREIGN KEY(b) REFERENCES T02d(e);

ALTER TABLE T02d
ADD CONSTRAINT for2 FOREIGN KEY(d) REFERENCES T01d(a);

ALTER TABLE T01d DROP FOREIGN KEY for1;
ALTER TABLE T02d DROP FOREIGN KEY for2;

DROP TABLE T01d;
DROP TABLE T02d;
