-- Active: 1707125319385@@127.0.0.1@3306@week06

-- TASK 01

-- Creates the required database.CREATE DATABASE week06;
CREATE DATABASE week07;

-- We start using the database made above.
USE week07;

-- TASK 02

-- Creating the table with required specifications.
CREATE TABLE T01(
    a int,
    b int UNIQUE NOT NULL,
    c int UNIQUE NOT NULL,
    d int UNIQUE NOT NULL,
    e CHAR(20) UNIQUE NOT NULL,
    PRIMARY KEY(a)
);

-- Run gcc 220101120_task02.c to generate the sql file. 
-- Inserting the values from another file created using the C program task2.c
-- Update the file path as per convinience
SOURCE task02.sql;
-- All the errors are being displayed on the mysql terminal.


-- TASK 03

-- Creating the table with required specifications.
CREATE TABLE T02(
    c1 int PRIMARY KEY,
    c2 CHAR(20) NOT NULL,
    c3 int NOT NULL
);

-- Run gcc 220101120_task03.c to generate the sql file. 
-- Inserting the values from another file created using the C program task3.c
-- Update the file path as per convinience
SOURCE task03.sql;
-- All the errors are being displayed on the mysql terminal.


-- TASK 04

-- 1)
SELECT a,b,c,d,e 
FROM T01;

-- 2)
SELECT a,b,c,d 
FROM T01;

-- 3)
SELECT c,d,e 
FROM T01;

-- 4)
SELECT a,c,e 
FROM T01;

-- 5)
SELECT e,d,c,b,a 
FROM T01;

-- 6)
SELECT a,a+10,b,b-20,c,c*30,d,d/40 
FROM T01;

-- 7)
SELECT * 
FROM T01;

-- 8)
SELECT a,b,c,d,e 
FROM T01 
ORDER BY e ASC;

-- 9)
SELECT a,b,c,d,e 
FROM T01 
ORDER BY e DESC;


-- TASK 05


-- 1)
SELECT * 
FROM T01 
WHERE a=82941;

-- 2)
SELECT a,b,c,d 
FROM T01 
WHERE a<>82941;


-- 3)
SELECT c,d,e 
FROM T01 
WHERE a>84921;

-- 4)
SELECT a,c,e 
FROM T01 
WHERE a>=84921;   

-- 5)
SELECT e,d,c,b,a 
FROM T01 
WHERE a<84921;

-- 6)
SELECT e,d,c,b,a 
FROM T01 
WHERE a<=84921;

-- 7)
SELECT e,d,c,b,a 
FROM T01 
WHERE a BETWEEN 80000 AND 84921;

-- 8)
SELECT a,a+10,b,b-20,c,c*30,d,d/40 
FROM T01
WHERE a+10 BETWEEN 80000 AND 84921
AND b-20 <> 84921
AND c*30>40000
AND d/40 < 65000;

-- 9)
SELECT * 
FROM T01 
WHERE a BETWEEN 0 AND 50000 
AND b>50000;

-- 10)
SELECT * 
FROM T01 
WHERE a BETWEEN 0 AND 50000 
AND b>50000
ORDER BY e ASC;

-- 11)
SELECT * 
FROM T01 
WHERE a BETWEEN 0 AND 50000 
AND b>50000
ORDER BY e ASC , b DESC;

-- TASK 06

-- 1)
SELECT e 
FROM T01
WHERE e LIKE "lo%";

-- 2)
SELECT e 
FROM T01
WHERE e LIKE "%ing";

-- 3)
SELECT e 
FROM T01
WHERE e LIKE "____";

-- 4)
SELECT e 
FROM T01
WHERE e LIKE "__i_";

-- 5)
SELECT e 
FROM T01
WHERE e LIKE "_i_h" OR  e LIKE "_i_l";

-- 6)
SELECT e 
FROM T01 
WHERE e LIKE "____"
EXCEPT 
(SELECT e 
FROM T01 
WHERE e LIKE "__i_");

-- 7)
SELECT e 
FROM T01 
WHERE e LIKE "_______%";



-- TASK 07

-- 1)
SELECT a,b 
FROM T01 
WHERE a>50000  
UNION
SELECT c1,c3 
FROM T02 
WHERE c2 LIKE "e%";

-- 2)
SELECT * 
FROM T02 
WHERE (c1,c2,c3) 
IN (
    SELECT a,e,c 
    FROM T01 
);

-- 3)
SELECT * 
FROM T02 
WHERE (c1,c2,c3) 
NOT IN (
    SELECT a,e,c 
    FROM T01
);

