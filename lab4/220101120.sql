
-- TASK 01

-- Creates the required database.
CREATE DATABASE week05;


-- We start using the database made above.
USE week05;

-- TASK 02

-- Creating the table with required specifications.
CREATE TABLE T1(
    id CHAR(20),
    roll_no INT,
    cpi FLOAT
);

-- Inserting the values.
INSERT INTO T1( id , roll_no , cpi) VALUES ('student 01', 270101001, 9.8);
INSERT INTO T1( id , roll_no , cpi) VALUES ('student 02', 270101002, 8.9);
INSERT INTO T1( id , roll_no , cpi) VALUES ('student 03', 270101003, 7.6);

-- Updating the cpi of student 03 to 8.1
UPDATE T1 
SET cpi = 8.1 
WHERE id = 'student 03';

-- Deleting the student with id 'student 01'.
DELETE FROM T1 
WHERE id ='student 02';

-- TASK 03

-- Creating the table with required specifications.
CREATE TABLE T2(
    id CHAR(20),
    roll_no INT PRIMARY KEY,
    cpi FLOAT
);

-- Inserting the values.
INSERT INTO T2( id , roll_no , cpi) VALUES ('student 01', 270101001, 9.8);
INSERT INTO T2( id , roll_no , cpi) VALUES ('student 01', 270101002, 8.9);
INSERT INTO T2( id , roll_no , cpi) VALUES ('student 02', 270101001, 7.6);
-- Error thrown at above command 
-- Duplicate entry '270101001' for key 'T2.PRIMARY' 
-- This is because we defined the column 'roll_no' as PRIMARY KEY and hence it cannot have duplicate values. This value hence won't be added to the table.

-- Updating the roll_no of student 01
UPDATE T2
SET roll_no = 270101002
WHERE id = 'student 01';
-- Error thrown at above command 
-- Duplicate entry '270101002' for key 'T2.PRIMARY'
-- This is because we defined the column 'roll_no' as PRIMARY KEY and since the table already have the roll_no 270101002 we cannot update any other roll_no to the same.


-- Deleting the row with id 'student 02'
DELETE FROM T2 
WHERE id ='student 02';

-- TASK 04

-- Creating the table with required specifications
CREATE TABLE T3(
    id CHAR(20) NOT NULL,
    roll_no INT UNIQUE,
    cpi FLOAT
);

-- Inserting the values

INSERT INTO T3( id , roll_no , cpi) VALUES (NULL, 270101001, 9.8);
-- Error thrown at above command 
-- Column 'id' cannot be null
-- Since the column 'id' has the constraint 'NOT NULL' we cannot insert a value with id = NULL.
INSERT INTO T3( id , roll_no , cpi) VALUES ('student 02', 270101002, 8.9);
INSERT INTO T3( id , roll_no , cpi) VALUES ('student 03', 270101002, 7.6);
-- Error thrown at above command 
-- Duplicate entry '270101002' for key 'T3.roll_no'
-- This is because we defined the column 'roll_no' as UNIQUE KEY and hence it cannot have duplicate values. This value hence won't be added to the table.

UPDATE T3
SET id = NULL;
-- Error thrown at above command 
-- Column 'id' cannot be null
-- Since the column 'id' has the constraint 'NOT NULL' we cannot set the ids of the rows to NULL.

-- Deleting the row with id 'student 02'
DELETE FROM T3 
WHERE id ='student 02';

-- TASK 05

-- Creating the table with required specifications
CREATE TABLE T4(
    id CHAR(20),
    roll_no INT PRIMARY KEY,
    cpi FLOAT DEFAULT 0.0
);

-- Inserting the values

INSERT INTO T4( id , roll_no ) VALUES (NULL, 270101001);
INSERT INTO T4( id , roll_no , cpi) VALUES (NULL, 270101002, 8.9);
INSERT INTO T4( id , roll_no , cpi) VALUES ('student 03', 270101002, -7.6);

-- Error thrown at above command 
-- Duplicate entry '270101002' for key 'T4.roll_no'
-- This is because we defined the column 'roll_no' as PRIMARY KEY and hence it cannot have duplicate values. This value hence won't be added to the table.


INSERT INTO T4( id , roll_no , cpi) VALUES ('student 03', 270101003, 8.2);
INSERT INTO T4( id , roll_no ) VALUES ('student 03', 270101004);


-- TASK 06

-- Creating the table with required specifications
CREATE TABLE T5(
    id CHAR(20) NOT NULL,
    roll_no INT PRIMARY KEY,
    cpi FLOAT DEFAULT 0.0
);

-- Inserting the values

INSERT INTO T5( id , roll_no ) VALUES (NULL, 270101001);
-- Error thrown at above command 
-- Column 'id' cannot be null
-- Since the column 'id' has the constraint 'NOT NULL' we cannot set the ids of the rows to NULL.


INSERT INTO T5( id , roll_no , cpi) VALUES ('student 01', 270101001, 9.6);
INSERT INTO T5( id , roll_no , cpi) VALUES ('student 02', 270101002, 8.2);
INSERT INTO T5( id , roll_no , cpi) VALUES ('student 02', 270101003, 7.6);
INSERT INTO T5( id , roll_no , cpi) VALUES ('student 03', 270101003, 7.2);
-- Error thrown at above command 
-- Duplicate entry '270101003' for key 'T5.PRIMARY'
-- This is because we defined the column 'roll_no' as PRIMARY KEY and hence it cannot have duplicate values. This value hence won't be added to the table.

INSERT INTO T5( id , roll_no ) VALUES ('student 04', 270101004);


-- TASK 07

-- Creating the table with required specifications

CREATE TABLE T6(
    id CHAR(20),
    roll_no INT,
    cpi FLOAT
);

-- Inserting the values

INSERT INTO T6( id , roll_no , cpi) VALUES ('student 01', 270101001, 9.6);
INSERT INTO T6( id , roll_no , cpi) VALUES ('student 02', 270101001, 9.4);
INSERT INTO T6( id , roll_no , cpi) VALUES ('student 03', 270101001, 9.2);

-- Adding PRIMARY KEY constraint to column 'roll_no'
ALTER TABLE T6
ADD PRIMARY KEY(roll_no);
-- Error thrown at above command 
-- Duplicate entry '270101001' for key 'T6.PRIMARY'
-- Since column 'roll_no' initially have duplicate values we cannot set it to PRIMARY KEY 

-- Adding another column named 'sem' having a default value 1
ALTER TABLE T6 
ADD sem int default 1;

-- Inserting the values

INSERT INTO T6( id , roll_no , cpi , sem) VALUES ('student 03', 270101002, 9.2 , 3);
INSERT INTO T6( id , roll_no , cpi ) VALUES ('student 03', 270101001, 9.2);

-- Dropping the column 'roll_no'
ALTER TABLE T6
DROP roll_no;


