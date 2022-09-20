# Q- 1=
drop procedure if exists order_status;
DELIMITER //
 CREATE PROCEDURE order_status(IN year INT, IN month INT)
 BEGIN 
		SELECT ordernumber, orderdate, status FROM orders WHERE DATE_FORMAT(orderDate, "%m-%y" ) IN (year, month) ; 
 END //
 DELIMITER ;
use assignment;
select * from orders;
 
call order_status(2005,11);

#Q- 2==
drop table if exists cancellations;
CREATE TABLE cancellations (
id INT AUTO_INCREMENT PRIMARY KEY, 
customernumber INT, FOREIGN KEY(customerNumber) REFERENCES customers(customerNumber), 
ordernumber int, FOREIGN KEY(orderNumber) REFERENCES orders(orderNumber),
comments TEXT(6000)
);

drop procedure if exists cancellation;
DELIMITER //
CREATE PROCEDURE cancellation()
BEGIN
DECLARE cus_no INT;
DECLARE ord_no INT;
DECLARE cmmnt TEXT(60000);
DECLARE cnt INT DEFAULT 0;
DECLARE my_cur CURSOR FOR SELECT customerNumber,orderNumber,comments FROM orders WHERE status='cancelled';
DECLARE CONTINUE HANDLER FOR NOT FOUND

BEGIN 
SET cnt = 1;
END ;

OPEN my_cur;
myloop:LOOP
FETCH my_cur INTO cus_no, ord_no, cmmnt;
IF cnt = 1 THEN
LEAVE myloop;
END IF;

INSERT INTO cancellations (customerNumber,orderNumber,comments) VALUES(cus_no, ord_no, cmmnt);
 SELECT * FROM cancellations;
END LOOP myloop;
END //



call cancellation();

 
 
 # Q- 3a==
use assignment;
select * from payments;
Delimiter //
create procedure GetCustomerLevel ( IN pCustomerNumber int, OUT pCustomerLevel varchar(20))
Begin 
Declare credit decimal default 0;
select sum(amount) into credit from payments where customerNumber = pCustomerNumber group by customerNumber;
if credit >50000 then set pCustomerLevel = 'PLATINUM';
ELSEIF credit between 25000 and 50000 then set pCustomerLevel = 'GOLD';
ELSE SET pCustomerLevel = 'SILVER';
END IF;
END //

CALL GetCustomerLevel( 103, @xyz);
select @xyz as Customer_Type;
SELECT customerNumber,customerName,purchase_status(customerNumber)  FROM customers;



 # Q- 3b=
 select * from customers;
select customerNumber, customername , purchase_status(customerNumber) from customers;  
 # Q-4==
 DELIMITER $$
CREATE TRIGGER trg_movies_update
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = id
    WHERE movieid = OLD.id ;
END;

DELIMITER $$
CREATE TRIGGER trg_movies_delete 
AFTER DELETE ON movies 
FOR EACH ROW 
BEGIN
    DELETE FROM  rentals
    WHERE movieid 
    NOT IN (SELECT DISTINCT id FROM movies);
END;

# Q- 5==
SELECT fname,salary 
FROM  assignment.employee
ORDER BY salary DESC 
LIMIT 2, 1;

# Q- 6==
use assignment;
select empid, fname, lname, salary,
dense_rank() over(
order by salary desc) from employee ;