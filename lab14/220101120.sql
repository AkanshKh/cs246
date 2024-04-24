-- Active: 1707125319385@@127.0.0.1@3306@aggre

--- Task 01

CREATE DATABASE week14;

USE week14;

-- Task 02


-- A
CREATE TABLE location(
    location_id INT PRIMARY KEY,
    city CHAR(10),
    state CHAR(2),
    country CHAR(20)
);

-- B

CREATE TABLE product(
    product_id INT PRIMARY KEY,
    product_name CHAR(10),
    category char(20),
    price INT
);

-- C

CREATE TABLE sale(
    product_id INT,
    time_id INT,
    location_id INT,
    sales INT,
    PRIMARY KEY(product_id, time_id, location_id)
);


-- Task 03

-- A

SOURCE populate_location.sql;

-- B

SOURCE product_location.sql;

-- C

SOURCE sale_location.sql;



-- Task 04

-- A
CREATE TABLE year_state_01(
    Year CHAR(10),
    WI INT,
    CA INT,
    Total INT
);

INSERT INTO year_state_01(YEAR) VALUES('1995');

INSERT INTO year_state_01(YEAR) VALUES('1996');

INSERT INTO year_state_01(YEAR) VALUES('1997');

INSERT INTO year_state_01(YEAR) VALUES('Total');


-- (i)
UPDATE year_state_01
SET WI = (
            SELECT SUM(sales)
            FROM sale ,location
            WHERE location.location_id = sale.location_id
            AND sale.time_id = '1995'
            AND location.state = 'WI'
        )
WHERE Year = '1995';

-- (ii)

UPDATE year_state_01
SET CA = (
            SELECT SUM(sales)
            FROM sale ,location
            WHERE location.location_id = sale.location_id
            AND sale.time_id = '1995'
            AND location.state = 'CA'
        )
WHERE Year = '1995';

-- (iii)

UPDATE year_state_01
SET Total = WI + CA
WHERE Year = '1995';


-- (iv)
UPDATE year_state_01
SET WI = (
            SELECT SUM(sales)
            FROM sale ,location
            WHERE location.location_id = sale.location_id
            AND sale.time_id = '1996'
            AND location.state = 'WI'
        )
WHERE Year = '1996';

-- (v)

UPDATE year_state_01
SET CA = (
            SELECT SUM(sales)
            FROM sale ,location
            WHERE location.location_id = sale.location_id
            AND sale.time_id = '1996'
            AND location.state = 'CA'
        )
WHERE Year = '1996';

-- (vi)

UPDATE year_state_01
SET Total = WI + CA
WHERE Year = '1996';

-- (vii)
UPDATE year_state_01
SET WI = (
            SELECT SUM(sales)
            FROM sale ,location
            WHERE location.location_id = sale.location_id
            AND sale.time_id = '1997'
            AND location.state = 'WI'
        )
WHERE Year = '1997';

-- (viii)

UPDATE year_state_01
SET CA = (
            SELECT SUM(sales)
            FROM sale ,location
            WHERE location.location_id = sale.location_id
            AND sale.time_id = '1997'
            AND location.state = 'CA'
        )
WHERE Year = '1997';

-- (ix)

UPDATE year_state_01
SET Total = WI + CA
WHERE Year = '1997';


-- (x)

UPDATE year_state_01
SET WI = (
            SELECT SUM(sales)
            FROM sale , location
            WHERE sale.location_id = location.location_id
            AND location.state = 'WI'
        )
WHERE Year = 'Total';

-- (xi)

UPDATE year_state_01
SET CA = (
            SELECT SUM(sales)
            FROM sale , location
            WHERE sale.location_id = location.location_id
            AND location.state = 'CA'
        )
WHERE Year = 'Total';

-- (xii)

UPDATE year_state_01
SET Total = WI + CA
WHERE Year = 'Total';

-- (xiii)

SELECT * FROM year_state_01;

-- B


-- (i)
CREATE TABLE year_state_02_01 
AS SELECT 
        sale.time_id as Year,
        SUM (
            CASE 
                WHEN location.state = "WI" THEN sales
                ELSE 0
            END
        ) AS WI,
        SUM (
            CASE 
                WHEN location.state = "CA" THEN sales
                ELSE 0
            END
        ) AS CA
FROM sale , location
WHERE location.location_id = sale.location_id
GROUP BY sale.time_id;

SELECT * FROM year_state_02_01;


-- (ii)

CREATE TABLE year_state_02_02
AS SELECT WI + CA as Total
FROM year_state_02_01;

SELECT * FROM year_state_02_02;


-- (iii)

CREATE TABLE year_state_02_03
AS SELECT 'Total' , SUM(WI), SUM(CA)
FROM year_state_02_01;

SELECT * FROM year_state_02_03;


-- (iv)


CREATE TABLE year_state_02_04
AS SELECT SUM(total) as'Total'
FROM year_state_02_02;

SELECT * FROM year_state_02_04;

-- C


CREATE TABLE year_state_03 
AS SELECT 
        sale.time_id as Year,
        SUM (
            CASE 
                WHEN location.state = "WI" THEN sales
                ELSE 0
            END
        ) AS WI,
        SUM (
            CASE 
                WHEN location.state = "CA" THEN sales
                ELSE 0
            END
        ) AS CA,
        SUM (sales) AS 'Total'
FROM sale , location
WHERE location.location_id = sale.location_id
GROUP BY sale.time_id
UNION
SELECT 
    'Total' ,
    SUM (
        CASE 
            WHEN location.state = "WI" THEN sales
            ELSE 0
        END
    ) AS WI,
    SUM (
        CASE 
            WHEN location.state = "CA" THEN sales
            ELSE 0
        END
    ) AS CA,
    SUM (sales) AS 'Total'
FROM sale , location
WHERE location.location_id = sale.location_id;


SELECT * FROM year_state_03;



-- D

CREATE TABLE year_state_04
AS SELECT 
        IF(GROUPING(sale.time_id),'Total', time_id) AS YEAR,
        SUM (
            CASE 
                WHEN location.state = "WI" THEN sales
                ELSE 0
            END
        ) AS WI,
        SUM (
            CASE 
                WHEN location.state = "CA" THEN sales
                ELSE 0
            END
        ) AS CA,
        SUM (sales) AS 'Total'
FROM sale , location
WHERE location.location_id = sale.location_id
GROUP BY sale.time_id 
WITH ROLLUP;

SELECT * FROM year_state_04;


