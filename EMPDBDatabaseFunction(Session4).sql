CREATE TABLE Employee(
    EmployeeId bigint PRIMARY KEY IDENTITY(2,2),
    FirstName varchar(MAX),
    LastName varchar(MAX),
	City varchar(50),
	[State] varchar(50),
	DateOfBirth date
)

INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('A','A','Patiala','Punjab','1999-04-23');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('B','B','Fazilka','Punjab','1998-05-24');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('C','C','Gurdaspur','Punjab','1997-06-25');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('D','D','Ludhiana','Punjab','1996-07-26');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('E','E','Jalandhar','Punjab','1995-08-27');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('F','F','Pathankot','Punjab','1994-09-28');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('G','G','Moga','Punjab','1993-10-29');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('H','H','Faridkot','Punjab','1992-11-30');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('I','I','Amritsar','Punjab','1991-12-31');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('J','J','Rajpura','Punjab','1990-01-1');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('K','K','Pathankot','Punjab','1994-09-28');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('L','L','Moga','Punjab','1993-10-29');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('M','M','Faridkot','Punjab','1992-11-30');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('N','N','Amritsar','Punjab','1991-12-31');
INSERT INTO Employee (FirstName, LastName, City, [State], DateOfBirth) VALUES ('O','O','Rajpura','Punjab','1990-01-1');


SELECT * FROM Employee

CREATE TABLE EmployeeDetail (
	EmployeeDetailId bigint PRIMARY KEY IDENTITY(1,1),
    Salary int,
    JoiningDate date,
	EmployeeId bigint,
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)
)

INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (10000,'1999-04-23',2);
INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (11000,'1998-05-24',6);
INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (12000,'1997-06-25',10);
INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (13000,'1996-07-26',14);
INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (14000,'1995-08-27',18);
INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (15000,'1994-09-28',4);
INSERT INTO EmployeeDetail (Salary, JoiningDate, EmployeeId) VALUES (16000,'1993-10-29',8);

SELECT * FROM EmployeeDetail

ALTER TABLE EmployeeDetail ADD Position VARCHAR(10)

UPDATE EmployeeDetail SET Position='1' WHERE EmployeeDetailId=1
UPDATE EmployeeDetail SET Position='2' WHERE EmployeeDetailId=2
UPDATE EmployeeDetail SET Position='3' WHERE EmployeeDetailId=3
UPDATE EmployeeDetail SET Position='4' WHERE EmployeeDetailId=4
UPDATE EmployeeDetail SET Position='5' WHERE EmployeeDetailId=5
UPDATE EmployeeDetail SET Position='6' WHERE EmployeeDetailId=6
UPDATE EmployeeDetail SET Position='7' WHERE EmployeeDetailId=7


--String Split Excecution
SELECT 
    VALUE Positions
FROM 
    EmployeeDetail
    INNER JOIN STRING_SPLIT(Position, ' ')


--String Split Execution using Function
CREATE FUNCTION Fun_EmployeeInformation1()      
RETURNS table       
as      
RETURN(SELECT 
		VALUE Positions
	FROM 
		EmployeeDetail
		INNER JOIN STRING_SPLIT(Position, ' '))    


--View Function result
SELECT *
FROM Fun_EmployeeInformation()


--Creating Table Type for table type
CREATE TYPE UT_Employees1 AS TABLE  
(  
    FirstName varchar(MAX),
    LastName varchar(MAX),
	City varchar(50),
	[State] varchar(50),
	DateOfBirth date
)  


--Inserting values in table type
DECLARE @Employeedetail AS [UT_Employees1];
INSERT INTO @Employeedetail
SELECT 'AA','AA','AA','AA','1999-04-23'UNION ALL
SELECT 'AB','AB','AB','AB','1989-04-23'
EXEC UspInsertEmployee 
SELECT * FROM Employee


--Subquery
SELECT e.EmployeeId, e.FirstName, e.LastName, e.City, ed.Salary, ed.JoiningDate FROM  Employee e 
INNER JOIN EmployeeDetail ed ON e.EmployeeId=ed.EmployeeId 
WHERE ed.Salary IN (SELECT MAX(Salary) FROM EmployeeDetail)


--CTE (COMMON TABLE EXPRESSION)
WITH EmployeeDetails 
AS
(
SELECT [EmployeeId]
      ,[FirstName]
      ,[LastName] 
      ,[City]
  FROM [Employee]
)
SELECT * FROM EmployeeDetails


--CTE With Join
WITH EmployeesDetails 
AS
(
SELECT e.EmployeeId, e.FirstName, e.LastName, e.City, ed.Salary, ed.JoiningDate FROM  Employee e 
INNER JOIN EmployeeDetail ed ON e.EmployeeId=ed.EmployeeId 
WHERE ed.Salary IN (SELECT MAX(Salary) FROM EmployeeDetail)
)
SELECT * FROM EmployeesDetails


--Merge Example
CREATE TABLE Products(  
    ID INT,  
    Product_Name VARCHAR(65),  
    Price INT  
)  

INSERT INTO Products(ID, Product_Name, Price) VALUES   
(1, 'Table', 150), 
(2, 'Desk', 100),  
(3, 'Chair', 75), 
(4, 'Computer', 225);  


CREATE TABLE TargetProducts(  
    ID INT,  
    Product_Name VARCHAR(65),  
    Price INT 
)  

      
INSERT INTO TargetProducts(ID, Product_Name, Price) VALUES  
(1, 'Table', 150),  
(2, 'Desk', 150),  
(5, 'Bed', 100),  
(6, 'Cupboard', 350);  

SELECT * FROM Products  
SELECT * FROM TargetProducts  


--Simple Merge
MERGE TargetProducts AS Target  
USING Products  AS Source  
ON Source.ID = Target.ID  
WHEN NOT MATCHED BY Target THEN  
    INSERT (ID, Product_Name, Price)   
    VALUES (Source.ID, Source.Product_Name, Source.Price); 


--Merge with Update
MERGE TargetProducts AS Target  
USING Products AS Source  
ON Source.ID = Target.ID  
WHEN NOT MATCHED BY Target THEN  
    INSERT (ID, Product_Name, Price)   
    VALUES (Source.ID, Source.Product_Name, Source.Price)  
WHEN MATCHED THEN UPDATE SET  
    Target.Product_Name = Source.Product_Name,  
    Target.Price = Source.Price;  


--Merge with Delete
MERGE TargetProducts AS Target  
USING Products  AS Source  
ON Source.ID = Target.ID  
WHEN NOT MATCHED BY Target THEN  
    INSERT (ID, Product_Name, Price)   
    VALUES (Source.ID, Source.Product_Name, Source.Price)  
WHEN MATCHED THEN UPDATE SET  
    Target.Product_Name = Source.Product_Name,  
    Target.Price = Source.Price  
WHEN NOT MATCHED BY Source THEN  
    DELETE;  


--table variable
DECLARE @ListOWeekDays TABLE(DyNumber INT,DayAbb VARCHAR(40) , WeekName VARCHAR(40))

INSERT INTO @ListOWeekDays
VALUES 
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')	

DELETE @ListOWeekDays WHERE DyNumber=1

UPDATE @ListOWeekDays SET WeekName='Saturday is holiday'  WHERE DyNumber=6

SELECT * FROM @ListOWeekDays