# Q- 1==

use assignment;
select * from assignment.employee where `salary` > 3000;
select * from assignment.employee where `salary`> 3000 and deptno = 10;

# Q-2==
use assignment;
select * from students;
select id, `name`, marks, 
case 
when marks between 80 and 100 then " Distinctions"
when marks between 50 and 80 then "First Class"
when marks between 40 and 50 then "Second Class"
end as "Grade Status"
from students;
select count(`Grade Status`) from students where `Grade Status` = "First Class";
select * from students;
ALTER TABLE `assignment`.`students` add column Grades int not null;
alter table students modify Grades varchar(50);
UPDATE students Set Grades = 'first class' where marks between 50 and 80 ;
UPDATE students Set Grades = 'second_class' where marks between 40 and 50;
UPDATE students Set Grades= 'Distinctions' where marks between 80 and 100 ;
select count(`name`) where Grades = 'first class';

# Q- 3 ==
select * from station;
select distinct city from station where id %2 = 0;


# Q- 4==. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table
select count(city) -  count(distinct city)  from station;



# Q- 5==
select * from station;
select distinct city from station where city LIKE 'A%'
or city LIKE 'E%'
OR city LIKE 'I%'
OR city LIKE 'O%'
OR city LIKE 'U%'
OR city LIKE 'a%'
OR city LIKE 'e%'
OR city LIKE 'i%'
OR city LIKE 'o%'
OR city LIKE 'u%';


# Q- 5 (b)==
use assignment;
   select distinct city
    from station where SUBSTRING(city,1,1) in ('A','E','I','O','U') and 
    SUBSTRING(city,-1,1) in ('A','E','I','O','U'); 

# Q- 5(c)==
select distinct city from station where city not LIKE 'A%'
or city NOT LIKE 'E%'
OR city NOT LIKE 'I%'
OR city NOT LIKE 'O%'
OR city NOT LIKE 'U%'
OR city NOT LIKE 'a%'
OR city NOT LIKE 'e%'
OR city NOT LIKE 'i%'
OR city NOT LIKE 'o%'
OR city NOT LIKE 'u%';

# Q- 5(d)==
 SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY NOT IN (SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u'))
OR 
(CITY NOT IN (SELECT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%'));
 
# Q- 6==
select * from emp;
select first_name, last_name from emp where salary > 2000 and hire_date > '2017-04-15' order by salary desc;

# Q- 7==
use assignment;
select * from employee;
SELECT SUM(salary) from employee where deptno = 10 and 20 and 30 group by deptno;
select sum(salary) from employee where deptno = 10;
	# for deptno = 10 company spends 20700
select sum(salary) from employee where deptno = 20 ;
# for deptno = 20 company spends 12300
select sum(salary) from employee where deptno = 30 ;
# for deptno = 30 company spends 1675


# Q-8 ==

select * from city;
select count(`name`) from city where population > 100000;
# ANS == 11

# Q- 9==
select * from city;
select sum(population) from city where district = 'California';
# answer= 339002

# Q-10 ==
select * from city;
select avg(population)
from city
where countrycode='JPN' and 'USA' and 'NLD'
group by district; 

# Q- 11==Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]
use assignment;
select * from orders;
select * from customers;
select `orders`.`orderNumber`, `orders`.`status`, `orders`.`customerNumber`, `customers`.`customername`, `orders`.`comments` from orders
inner join customers on `orders`.`customerNumber`= `customers`.`customerNumber` where `orders`.`status`= 'Disputed';