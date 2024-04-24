-- Active: 1707125319385@@127.0.0.1@3306@week10
USE week10;
drop DATABASE week10;
CREATE TABLE student18(name CHAR(100),roll_number CHAR(10) PRIMARY KEY);

drop table student18;

CREATE DATABASE IF NOT EXISTS week10;
SHOW TABLEs;

CREATE TABLE course18(semester INT,cid CHAR(7) PRIMARY KEY,name CHAR(100),l INT,t INT,p INT,c INT);

DROP TABLE course18;

CREATE TABLE grade18(roll_number CHAR(10),cid CHAR(7),letter_grade CHAR(2),PRIMARY KEY(roll_number,cid));

DROP TABLE grade18;

CREATE TABLE curriculum(dept CHAR(3),number INT,cid CHAR(7));

DROP table curriculum;

show DATABASES;

SELECT * FROM student18;




SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN 'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds,sum(cou.c) as total FROM grade18 g JOIN course18 cou on g.cid = cou.cid WHERE cou.semester = '1' AND roll_number = '180123065';

with dataTable AS(
    SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN 'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds,sum(cou.c) as total FROM grade18 g JOIN course18 cou on g.cid = cou.cid WHERE cou.semester <= 4 AND roll_number = '180123063'
)SELECT sum(creds)/sum(total) FROM dataTable;

with dataTable AS(SELECT sum(cou.c * CASE letter_grade WHEN 'AA' then 10 WHEN 'AB' then 9 WHEN 'BB' then 8 WHEN 'BC' then 7 WHEN 'CC' THEN 6 WHEN 'CD' THEN 5 WHEN 'DD' THEN 4 ELSE 0 END) as creds,sum(cou.c) as total FROM grade18 g JOIN course18 cou on g.cid = cou.cid WHERE cou.semester = '%s' AND roll_number = '%s')SELECT sum(creds)/sum(total) FROM dataTable;



SELECT roll_number from student18
WHERE EXISTS((SELECT cid FROM curriculum WHERE cid LIKE "OE%" AND number = %d) EXCEPT (SELECT cid from grade18 WHERE grade18.roll_number = student18.roll_number));

SELECT roll_number from student18
WHERE ((SELECT count(curriculum.cid) FROM curriculum WHERE curriculum.cid LIKE "OE%" AND number = %d) = (SELECT COUNT(grade18.cid) from grade18 INNER JOIN curriculum ON grade18.cid=curriculum.cid WHERE grade18.roll_number = student18.roll_number AND grade18.cid="OE%" and number=%d));