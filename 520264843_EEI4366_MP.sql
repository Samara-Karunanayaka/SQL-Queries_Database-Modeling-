CREATE DATABASE miniproject;

show databases;

USE miniproject;

--creating Salary_Scale Table--

CREATE TABLE Salary_Scale (
    Salary_Scale_ID INT NOT NULL PRIMARY KEY,
    Salary_Scale varchar(50) NOT NULL,
    Monthly_Pay varchar(10) NOT NULL,
    Min_Experience varchar(20) NOT NULL,
)
GO



--creating Software_Developers table--

CREATE TABLE Software_Developers (
    Staff_id int NOT NULL PRIMARY KEY,
    First_Name varchar(25) NOT NULL,
    Last_Name varchar(25) NOT NULL,
    Email varchar(50) NOT NULL,
    Emp_Date Date NOT NULL,
    Addres varchar(50) NOT NULL,
    Branch varchar(50) NOT NULL,
    Phone_No varchar(10) NOT NULL,
    Pay_Level varchar(10) NOT NULL,
    Salary_Scale_ID INT,
    FOREIGN KEY(Salary_Scale_ID) REFERENCES Salary_Scale(Salary_Scale_ID)
)
GO



--creating Branch table--

CREATE TABLE Branch (
    Branch_ID INT NOT NULL PRIMARY KEY,
    Branch_Name varchar(50) NOT NULL,
    Branch_Addres varchar(50) NOT NULL,
    Phone_No varchar(10) NOT NULL,
    Project_Manager varchar(50) NOT NULL UNIQUE,
    Staff_id INT,
    FOREIGN KEY(Staff_id) REFERENCES Software_Developers(Staff_id)
)
GO

--creating Client table--

CREATE TABLE Client (
    Client_No INT NOT NULL PRIMARY KEY,
    Client_Name varchar(255) NOT NULL,
    Email varchar(50) NOT NULL,
    Phone_No varchar(10) NOT NULL
)
GO


--creating Projects table--

CREATE TABLE Projects (
    Project_Id INT NOT NULL PRIMARY KEY,
    Project_Duration varchar(50),
    Type_Of_Paid varchar(10),
    Extra_Details varchar(50),
    Staff_id INT,
    Client_No INT,
    FOREIGN KEY (Staff_id) REFERENCES Software_Developers(Staff_id),
    FOREIGN KEY (Client_No) REFERENCES Client(Client_No)
)
GO

--creating PROJECT_TYPE table--

CREATE TABLE Project_Type (
    Project_Type_Id INT NOT NULL PRIMARY KEY,
    Project_Type_Name varchar(30) NOT NULL,
    Project_Id INT,
    FOREIGN KEY (Project_Id) REFERENCES Projects(Project_Id)
)
GO


--Inserting data to Salary_Scale table--

INSERT INTO Salary_Scale(Salary_Scale_ID,Salary_Scale,Monthly_Pay,Min_Experience)
VALUES (1008,'Basic',40000,'01 years'),
(1015,'Intermediate',60000,'04 years'),
(1025,'Advanced',225000,'06 years'),
(1018,'Intermediate',120000,'03 years'),
(1011,'Basic',40000,'01 years')
GO

SELECT * FROM Salary_Scale;


--Inserting data to Software_Developers table--

INSERT INTO Software_Developers(Staff_ID,First_Name,Last_Name,Email,Emp_Date,Addres,Branch,Phone_No,Pay_Level,Salary_Scale_ID )
VALUES (10010,'Shevo','Perera','abcd@yahoo.com','2015-05-08','Main Street,Kandy','Kandy','0315588585','50000',
(SELECT Salary_Scale_ID FROM Salary_Scale WHERE Monthly_Pay= '50000')),
(10018,'Mohommad','Imshan','xxxx@yahoo.com','2018-04-20','Main Street,Kurunegala','Kurunegala','0378899989','75000',
(SELECT Salary_Scale_ID FROM Salary_Scale WHERE Monthly_Pay= '75000')),
(10021,'Nizam','Mohomad','tyty@yahoo.com','2020-08-11','No256,JK Building,Jafna','Jaffna','0588882525','225000',
(SELECT Salary_Scale_ID FROM Salary_Scale WHERE Monthly_Pay= '225000')),
(10048,'Lenard','Gunathilake','exce@yahoo.com','2019-01-18','Narahenpita Rd,Colombo 12','Colombo','0114848459','85000',
(SELECT Salary_Scale_ID FROM Salary_Scale WHERE Monthly_Pay= '85000')),
(10014,'Malki','Fernando','seds@yahoo.com','2017-06-06','No.100,Main Rd, Trincomalee','Trincomalee','0255545459','120000',
(SELECT Salary_Scale_ID FROM Salary_Scale WHERE Monthly_Pay= '120000'))
GO

SELECT * FROM Software_Developers;





--Inserting data to Branch table--

INSERT INTO Branch(Branch_ID,Branch_Name,Branch_Addres,Phone_No,Project_Manager,Staff_id)
VALUES (001,'Kandy','Main Street,Kandy','0812525252','Perera',
(SELECT Staff_id FROM Software_Developers WHERE First_Name = 'Perera')),
(002,'Colombo','Nawala Rd,Nugegoda','0118585855','Dilruk',
(SELECT Staff_id FROM Software_Developers WHERE First_Name = 'Dilruk')),
(003,'Kurunegala','Main Rd,Kurunegala','0225845457','De Silva',
(SELECT Staff_id FROM Software_Developers WHERE First_Name = 'De Silva'))
GO


SELECT * FROM Branch;


--Inserting data to Client table--

INSERT INTO Client(Client_No,Client_Name,Email,Phone_No)
VALUES (2121,'Mr.Akeel','sdwe@yahoo.com','0812525252'),
(2128,'Mr.Teran','erew@ou.ac.lk','0812525252'),
(2135,'Mr.Fernando','swsw@gmail.com','0812525252'),
(2156,'Mr.De Silva','ytyt@ou.ac.lk','0812525252'),
(2133,'Mr.Kiran','jkjke@ou.ac.lk','0812525252')
GO

SELECT * FROM Client;

--Inserting data to Projects table--

INSERT INTO Projects(Project_Id,Project_Duration,Type_Of_Paid,Extra_Details,Staff_id,Client_No)
VALUES (1511,'02 Years','Fully Paid','Not Completed',10018,2135),
(1512,'01 Year','Not Paid','Completed',10048,2128),
(1513,'02 Years','Fully Paid','Completed',10014,2156),
(1514,'05 Months','Not Paid','Completed', 10010,2135),
(1515,'06 Months','Not Paid','Completed',10048,2133)
GO

SELECT * FROM Projects;

--Inserting data to Project_Type table--

INSERT INTO Project_Type(Project_Type_Id,Project_Type_Name,Project_Id)
VALUES (0015,'Web Application',1511),
(0010,'AI',1512),
(0019,'Web & Mobile',1513),
(0035,'Android App',1514),
(0044,'Web & AI',1515);

SELECT * FROM Project_Type;


-- ANSWERS --

--Q1--
--creating a view to show Details Of the Software_Developers--
CREATE VIEW Details_Of_Software_Developers AS
SELECT CONCAT(D.First_Name,' ', D.Last_Name) 
AS Full_Name, Phone_No, Branch,Pay_Level,S.Salary_Scale
FROM Software_Developers D, Salary_Scale S
WHERE D.Salary_Scale_ID = S.Salary_Scale_ID;

--DROP VIEW DETAILS_OF_SW_DEVELOPERS;
SELECT * FROM Details_Of_Software_Developers;



--Q2--
-----Q2 creating a view to show project details
CREATE VIEW Project_Details AS
SELECT p.Project_Id, CONCAT(s.First_Name,' ',s.LAST_NAME) AS Project_Manager, c.Client_Name, t.Project_Type_Name,
p.Project_Duration
FROM Projects p, Software_Developers s, Project_Type t, Client c
WHERE p.Staff_id = s.Staff_id
AND p.Project_Id = t.Project_Id
AND p.Client_No = c.Client_No

SELECT * FROM Project_Details;


--Q3--
-----Q3 creating a view to show details of projects which are paid
CREATE VIEW Pt_Details AS
SELECT p.Project_Id, p.Type_Of_Paid, p.Extra_Details,
p.Project_Duration, s.First_Name AS Mentor, c.Client_Name, c.Phone_No,
c.Email, t.Project_Type_Name
FROM Projects p, Software_Developers s, Project_Type t, Client c
WHERE p.Staff_id = s.Staff_id
AND p.Project_Id = t.Project_Id
AND p.Client_No = c.Client_No
AND Type_Of_Paid = 'Fully Paid'

SELECT * FROM Pt_Details;


--Q4--
------Q4 query for all the projects for any clients who have an email with @ou.ac.lk email address.
SELECT p.Project_Id, p.Client_No,c.Client_Name, c.Client_No, c.Email
FROM Projects p
INNER JOIN Client c ON p.Client_No = c.Client_No
WHERE Email LIKE '%ou.ac.lk';



--Q5--
-----Q5 software developer's specializations
SELECT t.Project_Type_Name, CONCAT(d.First_Name,' ', d.Last_Name) AS Dev_Full_Name, p.Project_Id
FROM Project_Type t, Projects p, Software_Developers d
WHERE t.Project_Id = p.Project_Id AND p.Staff_id = d.Staff_id
ORDER BY Project_Type_Name



--Q6--
--employee who has been working at the company for less than the minumum number of years expected for their pay level--
SELECT d.First_Name, d.Last_Name, d.Emp_Date, s.Salary_Scale, s.Min_Experience, d.Pay_Level
FROM Software_Developers d, Salary_Scale s
WHERE d.Salary_Scale_ID = s.Salary_Scale_ID;



--Q7--
SELECT c.Client_Name AS Full_Name, c.Phone_No, c.Email,p.Project_Id
FROM Client c, Projects p
WHERE c.Client_No = p.Client_No AND Type_Of_Paid = 'Not Paid'








