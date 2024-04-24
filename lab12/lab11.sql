create database trig;
use trig;

-- basic syntex
-- delimiter // 
-- create trigger trigger_name trigger_time trigger_event
-- on table_name 
-- for each row
-- begin 
-- --
-- end;
-- delimiter ;
-- here trigger_time : before/after
--      trigger_event : insert/update/delete

create table cus(id int,age int,name varchar(30));

-- before insert 
delimiter //
create trigger age_verify
before insert on cus
for each row
if new.age < 0 then set new.age = 0;
end if; // 

delimiter ;
insert into cus values(101,27,"James"),(102,-40,"Aman"),(103,23,"Ankit"),(104,-16,"Anurag");


select * from cus;

-- after insert trigger
create table cus1(id int auto_increment primary key,name varchar(40) not null,email varchar(30),birthdate date);
create table message(
id int auto_increment,
messageId int,
message varchar(300) not null,
primary key (id,messageId)
);

delimiter // 
create trigger check_null_dod
after insert on cus1
for each row
begin
if new.birthdate is null  then 
insert into message (messageId,message)
values (new.id,concat('Hi' , new.name,'-- please update your birthdate'));
end if; 
end // 
delimiter ;


insert into cus1 (name,email,birthdate)
values("Nancy","nancy@abc.com",null),
("Ronald","ronald@abc.com","1998-11-16"),
("Chris","chris@abc.com","1997-08-20"),
("Abs","abs@abc.com",null);

select * from message;

-- before update
create table emp(
emp_id int primary key,
emp_name varchar(25),
age int,salary float);

insert into emp values
(101,"Jimy",35,70000),
(102,"Shane",30,57000),
(103,"Jack",40,98000);

delimiter //
create trigger upd_trigger
before update 
on emp
for each row
begin
if new.salary = 10000 then 
set new.salary = 850000;
elseif new.salary <10000 then
set new.salary = 72000;
end if;
end; //
delimiter ;

update emp
set salary = 8000;


select * from emp;


-- before delete 
create table salary(
eid int primary key,
validfrom date not null,
amount float not null);
 
insert into salary (eid,validfrom,amount)
values (101,"2003-05-01",23000),
(102,"2004-06-12",24000),
(103,"2009-07-16",45000);


create table salary_del (id int primary key auto_increment,
eid int,validfrom date not null,
amount float not null,
deletedat timestamp default now());


delimiter //
create trigger salary_delete
before delete
on salary 
for each row
begin
insert into salary_del (eid,validfrom,amount) 
values (old.eid,old.validfrom,old.amount);
end // 
delimiter ;

delete from salary
where eid = 103;

select * from salary_del;

