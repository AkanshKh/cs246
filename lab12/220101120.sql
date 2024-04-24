-- Active: 1707125319385@@127.0.0.1@3306@week1

--- TASK 01
CREATE DATABASE week12;

-- TASK 02
USE week12;


-- 1


CREATE TABLE sailors (
    sid INT PRIMARY KEY,
    sname CHAR(50),
    rating INT,
    age DECIMAL(3,1)
);

-- 2

CREATE TABLE boats(
    bid INT PRIMARY KEY,
    bname CHAR(50),
    bcolor CHAR(50)
);

-- 3

CREATE TABLE reserves(
    sid INT,
    bid INT,
    day CHAR(50),
    FOREIGN KEY(sid) REFERENCES sailors(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(bid) REFERENCES boats(bid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(sid,bid,day)
);

-- TASK 03


-- 1

CREATE TABLE sailors_log(
    sid INT,
    event_ba CHAR(50),
    ops CHAR(50),
    date_time DATETIME default now(),
    check (event_ba in ('before', 'after')),
    check (ops in ('insert','update','delete'))
);

-- 2

CREATE TABLE boats_log(
    bid INT,
    event_ba CHAR(50),
    ops CHAR(50),
    date_time DATETIME default now(),
    check (event_ba in ('before', 'after')),
    check (ops in ('insert','update','delete'))
);

-- 3

CREATE TABLE reserves_log(
    sid INT,
    bid INT,
    day CHAR(10),
    event_ba CHAR(50),
    ops CHAR(50),
    date_time DATETIME default now(),
    check (event_ba in ('before', 'after')),
    check (ops in ('insert','update','delete'))
);


-- 4

CREATE TABLE sailors_log_log(
    sid INT,
    event_ba CHAR(50),
    ops CHAR(50),
    date_time DATETIME default now(),
    check (event_ba in ('before', 'after')),
    check (ops in ('insert','update','delete'))
);

-- 5

CREATE TABLE sailors_log_log_log(
    sid INT,
    event_ba CHAR(50),
    ops CHAR(50),
    date_time DATETIME default now(),
    check (event_ba in ('before', 'after')),
    check (ops in ('insert','update','delete'))
);

-- TASK 04

-- 1

source sailors01_populate.sql;

-- 2

source boats01_populate.sql;

-- 3

source reserves01_populate.sql;

-- TASK 05 (first)

-- 1

DELIMITER //

CREATE TRIGGER sailors_t1 
BEFORE INSERT 
ON sailors
FOR EACH ROW
BEGIN
    INSERT into sailors_log(sid,event_ba,ops) VALUES(NEW.sid,'before','insert');
END; //

-- 2

CREATE TRIGGER boats_t1 
BEFORE INSERT 
ON boats
FOR EACH ROW
BEGIN
    INSERT into boats_log(bid,event_ba,ops) VALUES(NEW.bid,'before','insert');
END; //

-- 3

CREATE TRIGGER reserves_t1 
BEFORE INSERT 
ON reserves
FOR EACH ROW
BEGIN
    INSERT into reserves_log(sid,bid,day,event_ba,ops) VALUES(NEW.sid,NEW.bid,NEW.day,'before','insert');
END; //

-- 4

CREATE TRIGGER sailors_t1_del 
AFTER UPDATE 
ON sailors
FOR EACH ROW
BEGIN
    INSERT into sailors_log(sid,event_ba,ops) VALUES(NEW.sid,'after','update');
END; //

-- 5

CREATE TRIGGER boats_t1_del 
AFTER UPDATE 
ON boats
FOR EACH ROW
BEGIN
    INSERT into boats_log(bid,event_ba,ops) VALUES(NEW.bid,'after','update');
END; //

-- 6

CREATE TRIGGER reserves_t1_del
AFTER UPDATE 
ON reserves
FOR EACH ROW
BEGIN
    INSERT into reserves_log(sid,bid,day,event_ba,ops) VALUES(NEW.sid,NEW.bid,NEW.day,'after','update');
END; //

-- 7

CREATE TRIGGER sailors_t3 
AFTER DELETE 
ON sailors
FOR EACH ROW
BEGIN
    INSERT into sailors_log(sid,event_ba,ops) VALUES(OLD.sid,'after','delete');
END; //

-- 8

CREATE TRIGGER boats_t3 
AFTER DELETE 
ON boats
FOR EACH ROW
BEGIN
    INSERT into boats_log(bid,event_ba,ops) VALUES(OLD.bid,'after','delete');
END; //

-- 9

CREATE TRIGGER reserves_t3
AFTER DELETE 
ON reserves
FOR EACH ROW
BEGIN
    INSERT into reserves_log(sid,bid,day,event_ba,ops) VALUES(OLD.sid,OLD.bid,OLD.day,'after','delete');
END; //

DELIMITER ;


-- TASK 05 (second)

-- 1

source sailors02_populate.sql;

-- 2

source boats02_populate.sql;

-- 3

DELIMITER //

CREATE PROCEDURE get_date(inout got_date CHAR(20))
BEGIN
    DECLARE temp_date CHAR(20);
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

CREATE PROCEDURE populate_reserves()
BEGIN
    DECLARE temp_sid int DEFAULT 1;
    DECLARE temp_bid int DEFAULT 1;
    DECLARE i int DEFAULT 1;
    DECLARE temp_date CHAR(20);
    populate : WHILE i <= 50000
    DO 
        SET temp_bid = FLOOR(5+49*(RAND()));
        SET temp_sid = FLOOR(1+500*(RAND()));
        call get_date(temp_date);
        INSERT into reserves(sid,bid,day) VALUES(temp_sid,temp_bid,temp_date);
        SET temp_bid = FLOOR(5+49*(RAND()));
        SET temp_sid = FLOOR(1+500*(RAND()));
        call get_date(temp_date);
        INSERT into reserves(sid,bid,day) VALUES(temp_sid,temp_bid,temp_date);
        SET i = i+1;
    END WHILE populate;
END //

DELIMITER ;
-- 4

SELECT * FROM sailors_log;

-- 5

SELECT * FROM boats_log;

-- 6

SELECT * FROM reserves_log;

-- 7

source sailors_update.sql;

-- 8 

source booats_update.sql;


-- 9 
DELIMITER //
CREATE PROCEDURE incr()
BEGIN
    
END
-- 10

SELECT * FROM sailors_log;

-- 11

SELECT * FROM boats_log;

-- 12

SELECT * FROM reserves_log;

-- 13

SOURCE sailors_delete.sql;

-- 14

SOURCE boats_delete.sql;

-- write here more

-- 16
SELECT * FROM sailors_log;

-- 17
SELECT * FROM boats_log;

-- 18
SELECT * FROM reserves_log;


-- TASK 06

-- 1

DELIMITER //
-- writing precedes would make sailors_t2 execute before sailors_t1
CREATE TRIGGER sailors_t2 
BEFORE INSERT 
ON sailors
FOR EACH ROW
PRECEDES sailors_t1
BEGIN
    INSERT into sailors_log(sid,event_ba,ops) VALUES(NEW.sid,'before','t2 insert');
END; //
-- the ops attribute only takes insert, delete, update as its values hence 't2 insert' would never be inserted into the sailors_log file


-- 2
-- writing precedes would make sailors_t3 execute before sailors_t1 and it would eventually execute before sailors_t2 as in the order of instantiation

CREATE TRIGGER sailors_t3 
BEFORE INSERT 
ON sailors
FOR EACH ROW
PRECEDES sailors_t1
BEGIN
    INSERT into sailors_log(sid,event_ba,ops) VALUES(NEW.sid,'before','t3 insert');
END; //
-- the ops attribute only takes insert, delete, update as its values hence 't3 insert' would never be inserted into the sailors_log file
DELIMITER ;


-- TASK 07

-- 1

SOURCE sailors03_populate.sql;

-- 2

SELECT * FROM sailors_log;

-- TASK 08

-- 1
DELIMITER //

CREATE TRIGGER sailors_log_t1
AFTER INSERT
ON sailors_log
FOR EACH ROW
BEGIN
    INSERT into sailors_log_log (sid,event_ba,ops) VALUES (NEW.sid,'after','insert');
END; //

-- 2
CREATE TRIGGER sailors_log_log_t1
AFTER INSERT
ON sailors_log_log
FOR EACH ROW
BEGIN
    INSERT into sailors_log_log_log (sid,event_ba,ops) VALUES (NEW.sid,'after','insert');
END; //

delimiter ;


-- TASK 09 is not given in assignment 


-- TASK 10

-- 1
SOURCE sailors04_populate.sql;

-- 2
SELECT * from sailors_log;

-- 3
SELECT * FROM sailors_log_log;

-- 4
SELECT * FROM sailors_log_log_log;



-- TASK 11

-- 1
DELIMITER //

CREATE TRIGGER sailor_log_log_log_t1
AFTER INSERT
ON sailors_log_log_log
FOR EACH ROW
BEGIN
    DECLARE temp_ind int;
    DECLARE temp_name char(50);
    DECLARE temp_sid int;
    DECLARE temp_rating int;
    DECLARE temp_age DECIMAL(3,1);
    SET temp_ind = FLOOR(1+400*(RAND()));
    SELECT sname into temp_name from sailors where sid=temp_ind;
    SET temp_sid = FLOOR(500+800*RAND());
    SET temp_rating = FLOOR(1+10*(RAND()));
    SET temp_age = ROUND(20+40*(RAND()),1);
    INSERT into sailors (sid,sname,rating,age) VALUES (temp_sid,temp_name,temp_rating,temp_age);
END; //

-- This is a recursive call and will led to an infinite loop. 

DELIMITER ;

-- TASK 12;

-- 1
SOURCE sailors05_populate.sql;

-- 2
SELECT * from sailors_log;

-- 3
SELECT * FROM sailors_log_log;

-- 4
SELECT * FROM sailors_log_log_log;


-- TASK 13

-- 1
INSERT INTO sailors(sid,sname,rating,age) VALUES(22,'Dustin',7,45);
INSERT INTO sailors(sid,sname,rating,age) VALUES(29,'Brutus',1,33);
INSERT INTO sailors(sid,sname,rating,age) VALUES(31,'Lubber',8,55.5);
INSERT INTO sailors(sid,sname,rating,age) VALUES(32,'Andy',8,25.5);
INSERT INTO sailors(sid,sname,rating,age) VALUES(58,'Rusty',10,35);
INSERT INTO sailors(sid,sname,rating,age) VALUES(64,'Horatio',7,35);
INSERT INTO sailors(sid,sname,rating,age) VALUES(71,'Zorba',10,16);
INSERT INTO sailors(sid,sname,rating,age) VALUES(74,'Horatio',9,35);
INSERT INTO sailors(sid,sname,rating,age) VALUES(85,'Art',3,25.5);
INSERT INTO sailors(sid,sname,rating,age) VALUES(95,'Bob',3,63.5);


-- 2

INSERT INTO boats(bid,bname,bcolor) VALUES(45,'ganga_travel','red');
INSERT INTO boats(bid,bname,bcolor) VALUES(46,'blue_boy','light_red');
INSERT INTO boats(bid,bname,bcolor) VALUES(47,'water_tight','yellow');
INSERT INTO boats(bid,bname,bcolor) VALUES(48,'summer_shines','light_yellow');
INSERT INTO boats(bid,bname,bcolor) VALUES(49,'green_swan','purple');
INSERT INTO boats(bid,bname,bcolor) VALUES(50,'green_berry','orange');
INSERT INTO boats(bid,bname,bcolor) VALUES(51,'deep_sea_drivers','pinkish_yellow');
INSERT INTO boats(bid,bname,bcolor) VALUES(52,'travel_treat','red');
INSERT INTO boats(bid,bname,bcolor) VALUES(53,'atul_lake','pinkish_yellow');
INSERT INTO boats(bid,bname,bcolor) VALUES(54,'winter_blues','orange');


-- 3

INSERT INTO reserves(sid,bid,day) VALUES(22,101,'1998-10-10');
INSERT INTO reserves(sid,bid,day) VALUES(22,102,'1998-10-10');
INSERT INTO reserves(sid,bid,day) VALUES(22,103,'1998-10-08');
INSERT INTO reserves(sid,bid,day) VALUES(22,104,'1998-10-07');
INSERT INTO reserves(sid,bid,day) VALUES(31,102,'1998-11-10');
INSERT INTO reserves(sid,bid,day) VALUES(31,103,'1998-11-06');
INSERT INTO reserves(sid,bid,day) VALUES(31,104,'1998-11-12');
INSERT INTO reserves(sid,bid,day) VALUES(64,101,'1998-09-05');
INSERT INTO reserves(sid,bid,day) VALUES(64,102,'1998-09-08');
INSERT INTO reserves(sid,bid,day) VALUES(74,102,'1998-09-08');

-- 4

SELECT * FROM sailors_log;

-- 5

SELECT * FROM boats_log;

-- 6

SELECT * FROM reserves_log;