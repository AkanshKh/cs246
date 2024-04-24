-- Active: 1707125319385@@127.0.0.1@3306@week081
CREATE DATABASE week11;

USE week11;

-- Q1

SET @sailors_table = 'CREATE TABLE sailors(
    sid INT,
    name CHAR(100),
    age INT,
    rating INT
);';

PREPARE stmt FROM @sailors_table;

EXECUTE stmt;

DEALLOCATE PREPARE stmt;

-- Q2
SET @reserves_table = 'CREATE TABLE reserves(
    sid INT,
    bid INT,
    date char(100)
);';

PREPARE stmt FROM @reserves_table;

EXECUTE stmt;

DEALLOCATE PREPARE stmt;

-- Q3
SET @boats_table = 'CREATE TABLE boats(
    bname CHAR(100),
    bcolor CHAR(100), 
    bid INT
);';

PREPARE stmt FROM @boats_table;

EXECUTE stmt;

DEALLOCATE PREPARE stmt;

-- Q4 A
CREATE TABLE sailor_name(
    sid INT,
    sname CHAR(100)
);

-- Q4 B
CREATE TABLE boat_name(
    sno INT,
    bname CHAR(100)
);

-- Q4 C
CREATE TABLE boat_color(
    sno INT,
    bcolor CHAR(100)
);

-- Q5 A
SOURCE sailor_name_populate.sql;

-- Q5 B
SOURCE boat_name_populate.sql;

-- Q5 C
SOURCE boat_color_populate.sql;


-- Q6

DELIMITER //
CREATE PROCEDURE pop_sailor()
BEGIN
    DECLARE temp_name char(100);
    DECLARE i INTEGER DEFAULT 1;
    DECLARE temp_age INT;
    DECLARE temp_rating INT;
    DECLARE ind INT;

    pop : WHILE i<=500
    DO
        SET ind = FLOOR(1+(700)*RAND());
        SET temp_age = FLOOR(18+(65-18+1)*RAND());
        SET temp_rating = FLOOR(1+(10)*RAND());
        SELECT sname INTO temp_name FROM sailor_name WHERE sid=ind;
        INSERT INTO sailors (sid,name,age,rating) VALUES (i,temp_name,temp_age,temp_rating);
        SET i = i + 1;
    END WHILE pop;
END //

DELIMITER ;

call pop_sailor();

-- Q7
DELIMITER //
CREATE PROCEDURE pop_boats()
BEGIN
    DECLARE temp_name char(100);
    DECLARE temp_color CHAR(100);
    DECLARE i INTEGER DEFAULT 1;
    DECLARE ind1 INT;
    DECLARE ind2 INT;
    DECLARE temp_bid INT;

    pop : WHILE i<=50
    DO
        SET ind1 = FLOOR(1+(100)*RAND());
        SET ind2 = FLOOR(1+(20)*RAND());
        SELECT bname INTO temp_name FROM boat_name WHERE sno=ind1;
        SELECT bcolor INTO temp_color FROM boat_color WHERE sno=ind2;
        INSERT INTO boats (bname,bcolor,bid) VALUES (temp_name,temp_color,i);
        SET i = i + 1;
    END WHILE pop;
END //

DELIMITER ;

CALL pop_boats();

-- Q8
DELIMITER //

CREATE PROCEDURE get_date(inout got_date CHAR(100))
BEGIN
    DECLARE temp_date CHAR(100);
    DECLARE temp_month INT;
    DECLARE temp_day INT;
    SET temp_month = FLOOR(1+(12)*RAND());
    CASE 
        WHEN (temp_month = 2)
        THEN SET temp_day = FLOOR(1+(29)*RAND());
        WHEN (temp_month = 1 OR temp_month = 3 OR temp_month = 5 or temp_month = 7 or temp_month = 8 or temp_month = 10 or temp_month = 12)
        THEN SET temp_day = FLOOR(1+31*RAND());
        ELSE SET temp_day = FLOOR(1+30*RAND());
    END CASE;
    CASE 
        WHEN (temp_day < 10 AND temp_month < 10)
        THEN SET temp_date = CONCAT("2024-0",temp_month,"-0",temp_day);
        WHEN (temp_day < 10 AND temp_month >= 10)
        THEN SET temp_date = CONCAT("2024-",temp_month,"-0",temp_day);
        WHEN (temp_day >= 10 AND temp_month <10)
        THEN SET temp_date = CONCAT("2024-0",temp_month,"-",temp_day);
        ELSE SET temp_date = CONCAT("2024-",temp_month,"-",temp_day);
    END CASE;

    set got_date = temp_date;

END //

DELIMITER ;

-- Q8
DELIMITER //
CREATE PROCEDURE pop_reserves()
BEGIN
    DECLARE i INTEGER DEFAULT 1;
    DECLARE ind1 INT;
    DECLARE ind2 INT;
    DECLARE temp_bid INT;
    DECLARE temp_sid INT;
    DECLARE temp_date CHAR(100);

    pop : WHILE i<=5000
    DO
        SET ind1 = FLOOR(1+(50)*RAND());
        SET ind2 = FLOOR(1+(500)*RAND());
        call get_date(temp_date);
        SELECT bid INTO temp_bid FROM boats WHERE bid=ind1;
        SELECT sid INTO temp_sid FROM sailors WHERE sid=ind2;
        -- SELECT temp_bid,temp_sid,temp_date;
        INSERT INTO reserves (sid,bid,date) VALUES (temp_sid,temp_bid,temp_date);
        SET i = i + 1;
    END WHILE pop;
END //

DELIMITER ;

CALL pop_reserves();


-- Q10

DELIMITER //
CREATE PROCEDURE get_boat_color(in toppp INT)
BEGIN
    SELECT boats.bcolor FROM  boats,sailors,reserves WHERE sailors.sid = reserves.sid AND sailors.sid = toppp AND reserves.bid=boats.bid;
END //

DELIMITER ;

-- Q 11

DELIMITER //
CREATE PROCEDURE get_sundays(out toppp INT)
BEGIN
    SELECT SUM(sailors.rating) INTO toppp FROM sailors,reserves WHERE sailors.sid=reserves.sid AND DAYNAME(reserves.date)="Sunday";
END //
DELIMITER ;

-- Here set a variable example @v1=10 and then call get_sundays(@v1). The answer is now stored in @v1 which can be retrieved using select @v1;



-- Q 12
DELIMITER //
CREATE FUNCTION get_letter(rating INT)
RETURNS CHAR(100)
READS sql data
BEGIN
    DECLARE letter_rating CHAR(100);
    CASE 
        WHEN (rating <= 3)
        THEN SET letter_rating = "F";
        WHEN (rating = 4)
        THEN SET letter_rating = "DD";
        WHEN (rating = 5)
        THEN SET letter_rating = "CD";
        WHEN (rating = 6)
        THEN SET letter_rating = "CC";
        WHEN (rating = 7)
        THEN SET letter_rating = "BC";
        WHEN (rating = 8)
        THEN SET letter_rating = "BB";
        WHEN (rating = 9)
        THEN SET letter_rating = "AB";
        WHEN (rating = 10)
        THEN SET letter_rating = "AA";
    END case;
    RETURN letter_rating;
END //

DELIMITER ;

-- Q 13
SELECT sid,rating, get_letter(rating) as letter_grade from sailors;