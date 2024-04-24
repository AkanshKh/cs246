-- Active: 1707125319385@@127.0.0.1@3306@week07


-- TASK 01

-- Creates the required database.CREATE DATABASE week06;
CREATE DATABASE week08;

-- We start using the database made above.
USE week08;


-- TASK 02

-- Creating the table with required specifications.

CREATE TABLE student(
    roll_number INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    program VARCHAR(20),
    CHECK (program in ('Certificate','Diploma', 'Degree', 'Honors'))
);

SOURCE task02_student.sql;

CREATE TABLE course(
    cid CHAR(5) PRIMARY KEY,
    cname VARCHAR(100)
);

SOURCE task02_course.sql;

CREATE TABLE concept(
    cid CHAR(5),
    qn CHAR(5),
    description VARCHAR(100),
    PRIMARY KEY(cid,qn),
    FOREIGN KEY (cid) REFERENCES course(cid)
);

SOURCE task02_concept.sql;

CREATE TABLE marks(
    roll_number INT,
    cid CHAR(5),
    set1 CHAR(5),
    set1_marks INT,
    set2 CHAR(5),
    set2_marks INT,
    PRIMARY KEY(roll_number,cid,set1),
    FOREIGN KEY (roll_number) REFERENCES student(roll_number),
    FOREIGN KEY (cid) REFERENCES course(cid)
);


SOURCE task02_marks.sql;

-- TASK 03  

-- 1
SELECT name, cid, set1, set1_marks, set2, set2_marks 
FROM student,marks
WHERE student.roll_number=marks.roll_number;

-- 2
SELECT roll_number, cname, set1, set1_marks, set2, set2_marks
FROM course,marks
WHERE course.cid=marks.cid;

--3

SELECT name, cname, set1, set1_marks, set2, set2_marks
FROM student,course,marks
WHERE course.cid=marks.cid AND student.roll_number=marks.roll_number;

--4

SELECT name,course.cid,set1,c1.description, set1_marks,set2,c2.description,set2_marks
FROM student,marks,course,concept as c1,concept as c2
WHERE course.cid=marks.cid AND student.roll_number=marks.roll_number AND c1.qn=marks.set1 AND c2.qn=marks.set2 AND c1.cid=marks.cid AND c2.cid=marks.cid;

-- 5

SELECT student.roll_number,course.cname,set1,c1.description, set1_marks,set2,c2.description,set2_marks
FROM student,marks,course,concept as c1,concept as c2
WHERE course.cid=marks.cid AND student.roll_number=marks.roll_number AND c1.qn=marks.set1 AND c2.qn=marks.set2 AND c1.cid=marks.cid AND c2.cid=marks.cid;

-- 6

SELECT student.name
FROM student,marks,course
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Introduction to Data Science'
INTERSECT
(
    SELECT student.name
    FROM student,marks,course
    WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Computer System Tools'
);

-- 7

SELECT student.name
FROM student,marks,course
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Introduction to Data Science'
EXCEPT
(
    SELECT student.name
    FROM student,marks,course
    WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Python Programming'
);


-- 8

SELECT student.roll_number
FROM student,marks,course
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Linear Algebra'
INTERSECT
(
    SELECT student.roll_number
    FROM student,marks,course
    WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Python Programming'
    INTERSECT
    (
        SELECT student.roll_number
        FROM student,marks,course
        WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Computer System Tools'
    )
);

-- 9

SELECT student.roll_number
FROM student,marks,course
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Linear Algebra'
EXCEPT
(
    SELECT student.roll_number
    FROM student,marks,course
    WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Python Programming'
    UNION
    (
        SELECT student.roll_number
        FROM student,marks,course
        WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cname='Computer System Tools'
    )
);

-- 10


SELECT student.roll_number
FROM student,marks,course
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA105'
INTERSECT 
(
    SELECT student.roll_number
    FROM student,marks,course
    WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA106'
    INTERSECT
    (
        SELECT student.roll_number
        FROM student,marks,course
        WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA107'
        INTERSECT
        (
            SELECT student.roll_number
            FROM student,marks,course
            WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA108'
        )
    )
);

-- 11

SELECT roll_number
FROM student
WHERE roll_number NOT IN (
    SELECT student.roll_number
    FROM student,marks,course
    WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA105'
    INTERSECT 
    (
        SELECT student.roll_number
        FROM student,marks,course
        WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA106'
        INTERSECT
        (
            SELECT student.roll_number
            FROM student,marks,course
            WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA107'
            INTERSECT
            (
                SELECT student.roll_number
                FROM student,marks,course
                WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND course.cid='DA108'
            )
        )
    )
);

-- 12

SELECT AVG(set1_marks)
FROM marks
WHERE cid='DA105' AND set1='q01s1';

-- 13

SELECT AVG(set2_marks)
FROM marks
WHERE cid='DA106' AND set2='q01s2';

-- 14

SELECT AVG(set1_marks)
FROM marks
WHERE cid='DA107' AND set1='q01s1';

-- 15

SELECT AVG(set2_marks)
FROM marks
WHERE cid='DA108' AND set2='q01s2';

-- 16


SELECT COUNT(roll_number)
FROM marks
WHERE cid='DA107' AND set1='q01s1' AND set1_marks BETWEEN 0 AND 5;

-- 17
SELECT COUNT(roll_number)
FROM marks
WHERE cid='DA107' AND set1='q01s1' AND 
set1_marks = (
    SELECT MAX(set1_marks)
    FROM marks
);


-- 18
SELECT student.roll_number 
FROM student NATURAL JOIN marks 
WHERE program = 'Diploma' AND cid = 'DA107' AND set2 = 'q02s2' AND set2_marks = (
    SELECT max(set2_marks) FROM marks WHERE cid = 'DA107' AND set2 = 'q02s2'
);



-- 21
SELECT DISTINCT student.roll_number,student.name, course.cid,course.cname,tot.sum1,tot.sum2
FROM student,course,marks, (
    SELECT roll_number,SUM(set1_marks) as sum1 ,SUM(set2_marks) as sum2
    FROM marks
    GROUP BY roll_number 
) as tot
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND tot.roll_number=student.roll_number;

-- 22
SELECT DISTINCT student.roll_number,student.name, course.cid,course.cname,tot.sum1,tot.sum2
FROM student,course,marks, (
    SELECT roll_number,SUM(set1_marks) as sum1 ,SUM(set2_marks) as sum2
    FROM marks
    GROUP BY roll_number 
) as tot
WHERE student.roll_number=marks.roll_number AND marks.cid=course.cid AND tot.roll_number=student.roll_number AND student.program='Degree';


-- 23.
SELECT program,COUNT(DISTINCT roll_number)
FROM student
GROUP BY program;


-- 24
SELECT AVG(set1_marks) 
FROM student NATURAL JOIN marks 
WHERE program = 'Certificate' AND cid = 'DA105' AND set1 = 'q01s1';
 
-- 25
SELECT AVG(set1_marks) 
FROM student NATURAL JOIN marks 
WHERE program = 'Diploma' AND cid = 'DA108' AND set1 = 'q12s1';
 
-- 26
SELECT SUM(set1_marks) AS sum1, SUM(set2_marks) AS sum2 FROM marks 
WHERE roll_number=270101636 AND cid = 'DA105';

-- 27
SELECT SUM(set1_marks) AS sum1, SUM(set2_marks) AS sum2 FROM marks 
WHERE roll_number=270101636 AND cid = 'DA106';

-- 28
SELECT SUM(set1_marks) AS sum1, SUM(set2_marks) AS sum2 FROM marks 
WHERE roll_number=270101636 AND cid = 'DA107';

-- 29
SELECT SUM(set1_marks) AS sum1, SUM(set2_marks) AS sum2 FROM marks 
WHERE roll_number=270101636 AND cid = 'DA108';

