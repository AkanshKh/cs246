-- Task 01

CREATE DATABasE week13;

-- Task 02
USE week13;

-- 1
CREATE TABLE employees (
    eid INT PRIMARY KEY,
    ename CHAR(50),
    dept CHAR(50),
    salary DECIMAL(10,0),
    gender CHAR(1),
    CHECK (gender in ('M' , 'F'))
);

-- 2

SOURCE employees_populate.sql;

-- 3

CREATE TABLE languages (
    ename CHAR(50),
    speaks CHAR(50),
    PRIMARY KEY(ename,speaks)
);

-- 4

SOURCE employeesLang_populate.sql;

-- Task 03 

-- 1

WITH dept_cnt(
    dept,
    cntt
) AS (
    SELECT 
        dept,
        count(*) 
    FROM employees 
    GROUP BY dept
)
SELECT * 
FROM dept_cnt 
WHERE dept_cnt.cntt=(
    SELECT MIN(cntt) 
    FROM dept_cnt
);

-- 2

SELECT 
    dept,
    cnt 
FROM (
    SELECT 
        dept,
        count(*) AS cnt, 
        rank() OVER (ORDER BY count(*)) AS dept_rank 
    FROM employees 
    GROUP BY dept
) AS en 
WHERE en.dept_rank=1;

-- Task 04

-- 1

WITH name_lang (
    myname,
    cnt
) AS (
    SELECT 
        ename, 
        count(*) 
    FROM employees natural join languages 
    GROUP BY ename
)
SELECT * 
FROM name_lang 
WHERE name_lang.cnt = (
    SELECT MAX(cnt) 
    FROM name_lang
);

-- 2

SELECT 
    ename,
    cnt 
FROM (
    SELECT 
        ename,
        count(*) AS cnt,
        rank() OVER (ORDER BY count(*) DESC) AS lang_cnt_rank  
    FROM employees NATURAL JOIN languages 
    GROUP BY ename
) AS en 
WHERE en.lang_cnt_rank=1;

-- Task 05

-- 1
WITH avg_genSal(
    gender, 
    avg_sal
) AS (
    SELECT 
        gender, 
        sum(salary)/count(*) 
    FROM employees 
    GROUP BY gender
)
SELECT * 
FROM avg_genSal 
WHERE avg_sal = (
    SELECT MAX(avg_sal) 
    FROM avg_genSal
);

-- 2

SELECT 
    gender,
    avgsal 
FROM (
    SELECT 
        gender, 
        sum(salary)/count(*) AS avgSal, 
        rank () OVER (order BY sum(salary)/count(*) DESC) AS sal_rank 
    FROM employees 
    GROUP BY gender
)
AS en 
WHERE en.sal_rank=1;

-- Task 06

-- 1
SELECT 
    ename,
    salary 
FROM (
    SELECT 
        ename, 
        dept, 
        salary, 
        rank () OVER (PARTITION BY dept order BY salary DESC) AS sal_rank 
    FROM employees
)
AS en WHERE en.dept = 'Marketing' AND en.sal_rank<3;

-- 2

SELECT 
    ename,
    salary,
    gender 
FROM (
    SELECT 
        ename, 
        gender, 
        salary, 
        rank () over (PARTITION BY gender ORDER BY salary DESC) AS gen_rank 
    FROM employees
) AS en
WHERE en.gen_rank=1;

-- Task 07

-- 1
CREATE TABLE students(
    sid INT PRIMARY KEY,
    sname CHAR(50),
    marks INT,
    gender char(6),
    gender CHAR(11),
    CHECK (gender IN ('Male','Female')),
    CHECK (department IN ('CSE','Mathematics'))
);

-- 2

SOURCE students_populate.sql;

-- Task 08

-- 1

SELECT 
    sid, 
    marks, 
    class_rank 
    FROM(
        SELECT 
            sid, 
            marks, 
            rank () OVER (ORDER BY marks DESC) AS class_rank 
        FROM students
    ) 
AS en;

-- 2

SELECT 
    sid, 
    department, 
    marks, 
    class_rank FROM (
    SELECT 
        sid, 
        department, 
        marks, 
        rank () OVER (PARTITION BY department ORDER BY marks DESC) AS class_rank 
    FROM students
) AS en;

-- 3

SELECT 
    sid, 
    gender, 
    marks, 
    class_rank 
FROM (
    SELECT 
        sid, 
        gender, 
        marks, 
        rank () OVER (PARTITION BY gender ORDER BY marks DESC) AS class_rank 
    FROM students
) AS en;

-- 4

SELECT 
    sid, 
    department, 
    gender, 
    marks, 
    class_rank 
FROM(
    SELECT 
        sid, 
        department, 
        gender, 
        marks, 
        rank () OVER (PARTITION BY department, gender ORDER BY marks DESC) AS class_rank 
    FROM students
) AS en;

-- 5

SELECT 
    sid, 
    marks, 
    class_rank, 
    class_dense_rank 
FROM (
    SELECT 
        sid, 
        marks, 
        rank () OVER (ORDER BY marks DESC) AS class_rank, 
        dense_rank () OVER (ORDER BY marks DESC) AS class_dense_rank 
    FROM students
) AS en;

-- 6

WITH max_marks(
    maxi, 
    maxi_100, 
    maxi_200, 
    lowi 
) AS (
    SELECT 
        FIRST_VALUE(marks) OVER (ORDER BY marks DESC) AS maxi,
        NTH_VALUE(marks,100) OVER (ORDER BY marks DESC) AS maxi_100,
        NTH_VALUE(marks,200) OVER (ORDER BY marks DESC) AS maxi_200,
        FIRST_VALUE(marks) OVER (ORDER BY marks) AS lowi
    FROM students
)
SELECT 
    sname,
    marks,
    case 
        when marks = (SELECT MAX(maxi) FROM max_marks) 
            THEN 'First Highest Marks'
        when marks = (SELECT MAX(maxi_100) FROM max_marks) 
            THEN '100th Highest Marks'
        WHEN marks = (SELECT MAX(maxi_200) FROM max_marks) 
            THEN '200th Highest Marks'
        WHEN marks = (SELECT MAX(lowi) FROM max_marks) 
            THEN 'Lowest marks'
    END description 
FROM students 
WHERE marks = (SELECT MAX(maxi) FROM max_marks) OR 
    marks = (SELECT MAX(maxi_100) FROM max_marks) OR 
    marks = (SELECT MAX(maxi_200) FROM max_marks) OR 
    marks = (SELECT MAX(lowi) FROM max_marks) 
ORDER BY marks DESC;

-- 7

SELECT 
    sname, 
    marks, 
    lag(marks) OVER(PARTITION BY department ORDER BY marks DESC) AS previous_marks, 
    lead(marks) OVER (PARTITION BY department ORDER BY marks DESC) AS next_marks 
FROM students;