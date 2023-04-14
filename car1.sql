CREATE DATABASE CARSHOWROOMdtbs

USE CARSHOWROOMdtbs

//*===DDL CREATE SCHEMA===*//
CREATE SCHEMA CARS_DATA
CREATE SCHEMA STAFF_DATA
CREATE SCHEMA CUST_DATA
CREATE SCHEMA PAY_DATA

//*=====DDL TABLE CAR_DATA====*//

CREATE TABLE CAR_DATA
(
id_car VARCHAR (8) not null PRIMARY KEY,
car_name CHAR (15) not null UNIQUE,
car_stok VARCHAR(10) DEFAULT 'EMPTY',
car_price INT not null
);


//*===DDL TABLE STAFF DATA===*//
CREATE TABLE STAFF_DATA
(
id_staff VARCHAR (8) not null PRIMARY KEY,
staff_name CHAR (35) not null UNIQUE,
staff_add VARCHAR (35) not null,
position_code VARCHAR (10) not null FOREIGN KEY REFERENCES POSITION(position_code),
position CHAR (15) DEFAULT 'apprenticeship',
salary VARCHAR (15) DEFAULT'500000'
);

//*===DDL POSITION===*//
CREATE TABLE POSITION
(
position_code VARCHAR (10) not null PRIMARY KEY,
position CHAR (15) UNIQUE DEFAULT 'apprenticeship' ,
allowance INT DEFAULT '0'
);

//*=====DDL CUSTOMER DATA====*//
CREATE TABLE CUST_DATA
(
id_cust VARCHAR (10) not null PRIMARY KEY,
cust_name CHAR (35) not null UNIQUE,
cust_add VARCHAR (35) not null,
gender CHAR (8) not null,
phone_number VARCHAR (12)not null
);
CREATE RULE gender
AS 
@gender = 'M' OR @gender = 'F'


//*=====DDL ORDER CAR===*//
CREATE TABLE ORDER_CAR
(
id_cust VARCHAR (10) not null FOREIGN KEY REFERENCES CUST_DATA(id_cust),
id_order VARCHAR (10) not null PRIMARY KEY,
id_car VARCHAR (8) not null FOREIGN KEY REFERENCES CAR_DATA(id_car),
car_name CHAR (15) not null,
quantity INT CHECK (quantity>0)
);

//*===== DDL PAYMENT===*//
CREATE TABLE PAY_DATA
(
id_payment VARCHAR (10) not null PRIMARY KEY,
id_order VARCHAR (10) not null ,
payment_methode CHAR (10) not null,
instalment_code VARCHAR(10) not null FOREIGN KEY REFERENCES instalment ( instalment_code),
id_cust VARCHAR (10) not null FOREIGN KEY REFERENCES CUST_DATA (id_cust),
id_staff VARCHAR (8) not null FOREIGN KEY REFERENCES STAFF_DATA (id_staff)
);
CREATE RULE payment_methode
AS 
@payment_methode = 'CASH' OR @payment_methode = 'KREDIT'

//*=====DDL STAFF TOTAL SALARY===*//
CREATE TABLE TOTAL_StaffSalary
( 
position_code VARCHAR (10) not null FOREIGN KEY REFERENCES POSITION(position_code),
position CHAR (15)  ,
allowance INT,
salary VARCHAR (15) not null,
total_salary VARCHAR (15) 
);

//*==== DDL instalment===*//
CREATE TABLE instalment
(
instalment_code VARCHAR(10) not null PRIMARY KEY,
cust_name CHAR (35) not null FOREIGN KEY REFERENCES CUST_DATA(cust_name),
purchase_date VARCHAR (10) ,
installment_amount VARCHAR (2) DEFAULT '0',
installment_fee VARCHAR (15)  DEFAULT ' CASH' , 
due_date VARCHAR (2) DEFAULT '0'
);

//*DML*//
//*-----INSERT INTO CAR DATA--------*//
INSERT INTO CAR_DATA VALUES ('11110','xenia','5','125000000')
INSERT INTO CAR_DATA VALUES ('11111','avanza','10','135000000')
INSERT INTO CAR_DATA VALUES ('11112','karimun','8','120000000')
INSERT INTO CAR_DATA VALUES ('11113','jazz','9','135000000')
INSERT INTO CAR_DATA VALUES ('11114','honda freed','2','200000000')
INSERT INTO CAR_DATA VALUES ('11115','fortune','7','250000000')
INSERT INTO CAR_DATA VALUES ('11116','pajero sport','5','300000000')
INSERT INTO CAR_DATA (id_car,car_name,car_price) VALUES ('11117','apv','240000000')

//*=====INSERT INTO STAFF DATA===*//
INSERT INTO STAFF_DATA VALUES ('ST01','ika','Jakarta','M01','MANAGER','8000000')
INSERT INTO STAFF_DATA VALUES ('ST02','salsa','Jakarta','D01','DIRECTUR','10000000')
INSERT INTO STAFF_DATA VALUES ('ST03','solthan','Jakarta','A01','ADMIN','5000000')
INSERT INTO STAFF_DATA VALUES ('ST04','lulu','Jakarta','S01','SALES','4000000')
INSERT INTO STAFF_DATA VALUES ('ST05','ana','Bogor','S02','SALES','4000000')
INSERT INTO STAFF_DATA VALUES ('ST06','widia','Lampung','A02','ADMIN','5000000')
INSERT INTO STAFF_DATA (id_staff, staff_name, staff_add,position_code) VALUES ('ST07','dela','Cakung','ST07')


//*====INSERT POSITION===*//
INSERT INTO POSITION VALUES ('M01','MANAGER','2000000')
INSERT INTO POSITION VALUES ('D01','DIRECTUR','2000000')
INSERT INTO POSITION VALUES ('A01','ADMIN','2000000')
INSERT INTO POSITION VALUES ('S01','SALES','2000000')
INSERT INTO POSITION VALUES ('S02','SALES','2000000')
INSERT INTO POSITION VALUES ('A02','ADMIN','2000000')

//*=== INSERT CUSTOMER DATA ====*//
INSERT INTO CUST_DATA VALUES ('C01','yani','Tangerang','F','081212558157')
INSERT INTO CUST_DATA VALUES ('C02','jhoni','Tangerang','M','081212558987')
INSERT INTO CUST_DATA VALUES ('C03','jaman','Tangerang','M','081212558654')
INSERT INTO CUST_DATA VALUES ('C04','rahmat','Tangerang','M','081212558777')
INSERT INTO CUST_DATA VALUES ('C05','erlin','Tangerang','F','081212558007')
INSERT INTO CUST_DATA VALUES ('C06','erlan','Tangerang','M','081212558887')

Select * From CUST_DATA

//*===INSERT ORDER CAR===*//
INSERT INTO ORDER_CAR VALUES ('C01','OR01','11110','xenia','1')
INSERT INTO ORDER_CAR VALUES ('C02','OR02','11111','avanza','1')
INSERT INTO ORDER_CAR VALUES ('C03','OR03','11110','xenia','1')
INSERT INTO ORDER_CAR VALUES ('C04','OR04','11112','karimun','1')
INSERT INTO ORDER_CAR VALUES ('C05','OR05','11113','jazz','1')
INSERT INTO ORDER_CAR VALUES ('C06','OR06','11115','fortune','1')

//*====INSERT PAY DATA===*//
INSERT INTO PAY_DATA VALUES ('PAY1','OR03','KREDIT','ins1','C03','ST03')
INSERT INTO PAY_DATA VALUES ('PAY2','OR04','KREDIT','ins2','C04','ST03')
INSERT INTO PAY_DATA VALUES ('PAY3','OR01','CASH','ins3','C01','ST03')
INSERT INTO PAY_DATA VALUES ('PAY4','OR02','CASH','ins4','C02','ST03')
INSERT INTO PAY_DATA VALUES ('PAY5','OR05','CASH','ins5','C05','ST03')
INSERT INTO PAY_DATA VALUES ('PAY6','OR06','CASH','ins6','C06','ST03')

//*====INSERT TOTAL SALARY===*//
INSERT INTO TOTAL_StaffSalary VALUES('M01','MANAGER','2000000','8000000','10000000')
INSERT INTO TOTAL_StaffSalary VALUES('D01','DIRECTUR','2000000','10000000','12000000')
INSERT INTO TOTAL_StaffSalary VALUES('A01','ADMIN','2000000','5000000','7000000')
INSERT INTO TOTAL_StaffSalary VALUES('S01','SALES','2000000','4000000','6000000')
INSERT INTO TOTAL_StaffSalary VALUES('S02','SALES','2000000','4000000','6000000')
INSERT INTO TOTAL_StaffSalary VALUES('A02','ADMIN','2000000','5000000','7000000')

//*====INSERT instalment===*//
INSERT INTO instalment VALUES ('ins1','jaman','12/12/2021','25','5000000','12')
INSERT INTO instalment VALUES ('ins2','rahmat','08/13/2021','30','4000000','13')
INSERT INTO instalment (instalment_code,cust_name,purchase_date) VALUES ('ins3','yani','01/01/2021')
INSERT INTO instalment (instalment_code,cust_name,purchase_date) VALUES ('ins4','jhoni','02/02/2021')
INSERT INTO instalment (instalment_code,cust_name,purchase_date) VALUES ('ins5','erlin','03/03/2021')
INSERT INTO instalment (instalment_code,cust_name,purchase_date) VALUES ('ins6','erlan','04/04/2021')

//DQL//
SELECT * FROM CAR_DATA
SELECT * FROM STAFF_DATA
SELECT * FROM POSITION
SELECT * FROM TOTAL_StaffSalary
SELECT * FROM CUST_DATA
SELECT * FROM ORDER_CAR 
SELECT * FROM PAY_DATA
SELECT * FROM instalment

//*=====DROP TABLE====*//
DROP TABLE CAR_DATA
DROP TABLE STAFF_DATA
DROP TABLE POSITION
DROP TABLE CUST_DATA
DROP TABLE PAY_DATA
DROP TABLE ORDER_CAR
DROP TABLE TOTAL_StaffSalary
DROP TABLE instalment

//*=======ALTER DI DATABASE CARSHOWROOM===*//
ALTER TABLE ORDER_CAR ADD FOREIGN KEY (id_car) REFERENCES CAR_DATA (id_car)
//*=====================*//
ALTER TABLE [dbo].[PAY_DATA]
DROP CONSTRAINT FKP 
//*=========================================*//
ALTER TABLE [dbo].[PAY_DATA]
DROP CONSTRAINT [FK__PAY_DATA__id_ord__76619304],[FKP1]
//*==========================================*//
ALTER TABLE [dbo].[TOTAL_StaffSalary]
DROP CONSTRAINT [FK__TOTAL_Sta__staff__2645B050]
//*========================================================*//
ALTER TABLE [dbo].[TOTAL_StaffSalary]
DROP CONSTRAINT [FK__TOTAL_Sta__id_st__2F9A1060]
//*=============================*//
ALTER TABLE [dbo].[ORDER_CAR]
DROP CONSTRAINT [FKOC]




//*====PROCEDURE DATABASE==*//
CREATE PROCEDURE prcCAR_DATA
AS
BEGIN
SELECT id_car, car_name FROM CAR_DATA
PRINT ' QUERY ON VIEW'
END
EXEC prcCAR_DATA

//*=============================*//
CREATE PROCEDURE prcposition
@position_code VARCHAR (10), 
@position CHAR (15), 
@allowance INT 
AS
BEGIN
INSERT INTO POSITION VALUES (@position_code , @position , @allowance )
END
EXEC prcposition 'ST07','SALES','2000000'
SELECT * FROM POSITION
DROP PROCEDURE prcposition

//*=====VIEW=====*//
CREATE VIEW viewStaff_data AS
SELECT id_staff, staff_name, position
FROM STAFF_DATA
WHERE position = 'SALES';
SELECT * FROM viewStaff_data


CREATE VIEW viewPAY_DATA AS
SELECT id_order, id_payment,staff_name
FROM PAY_DATA
WHERE payment_methode = 'CASH';
SELECT * FROM viewPAY_DATA
DROP VIEW viewPAY_DATA

//*======JOIN TABLE=====*//
SELECT a.id_cust, b.id_order, a.cust_name
FROM ORDER_CAR a
JOIN  PAY_DATA b ON a.id_order=b.id_order;


//*======UPDATE DATABASE=====*//
UPDATE POSITION
SET position = 'apprenticeship'
WHERE position_code = 'ST07' ;

//*=======TRIGGER DATABASE====*//
CREATE TRIGGER trgcardata
ON CAR_DATA AFTER INSERT AS
BEGIN
PRINT 'Data berhasil dimasukkan'
END
RETURN
select * from CAR_DATA

CREATE TRIGGER trgstaffdata
ON STAFF_DATA AFTER INSERT AS
BEGIN
PRINT 'Data berhasil dimasukkan'
END
RETURN
select * from STAFF_DATA


CREATE TRIGGER trgcarorder
ON ORDER_CAR AFTER INSERT AS
BEGIN
PRINT 'Data berhasil dimasukkan'
END
RETURN
select * from ORDER_CAR

//*===TRIGGER KURANG STOK======*//
CREATE TRIGGER trgupdatestok
ON ORDER_CAR
FOR INSERT
AS
BEGIN
	UPDATE a set a.car_stok = a.car_stok-b.quantity
	FROM CAR_DATA a JOIN inserted b ON a.id_car=b.id_car
END
