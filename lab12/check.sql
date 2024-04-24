-- Active: 1707125319385@@127.0.0.1@3306@week10
use week081;


show tables;

select * from student18;

SELECT * FROM grade18;

select roll_number ,letter_grade, rank() over (partition by roll_number ORDER BY  (letter_grade) ) as s_rank from grade18;