-- How to create database 
CREATE DATABASE HealthcareAnalyticsDB;

--use Database
USE HealthcareAnalyticsDB;
GO

--Create table------------------------------------------------------------------------------------------------------------------------------------------ 
-- 1. Hospitals
CREATE TABLE Hospitals (
    Hospital_ID     VARCHAR(10) PRIMARY KEY,
    Hospital_Name   VARCHAR(100),
    City            VARCHAR(50),
    State           VARCHAR(50),
    Region          VARCHAR(20),
    Hospital_Type   VARCHAR(20),
    Bed_Capacity    INT
);


-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Hospitals --import a large amount of data quickly into destination table.
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\hospitals.csv'
WITH (
    FIRSTROW = 2,  --Row 1 is assumed to contain column names/header.
    FIELDTERMINATOR = ',',--Tells SQL Server that comma , separates columns.
    ROWTERMINATOR = '0x0a',--it shows a new line after completting the row
    TABLOCK  -----Places a table-level lock while importing.-- It can make bulk loading faster, especially for large datasets.
);
GO

SELECT * FROM Hospitals;


--Create table ------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Departments
CREATE TABLE Departments (
    Department_ID     VARCHAR(10) PRIMARY KEY,
    Department_Name   VARCHAR(50),
    Department_Type   VARCHAR(20)
);
GO


-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Departments
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\departments.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);
GO

select * from Departments

--Create table ------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Doctors
CREATE TABLE Doctors (
    Doctor_ID           VARCHAR(10) PRIMARY KEY,
    Doctor_Name         VARCHAR(100),
    Gender              VARCHAR(10),
    Hospital_ID         VARCHAR(10),
    Department_ID       VARCHAR(10),
    Experience_Years    INT,
    Consultation_Fee    INT,
    CONSTRAINT FK_Doctor_Hospital   FOREIGN KEY (Hospital_ID)   REFERENCES Hospitals(Hospital_ID),
    CONSTRAINT FK_Doctor_Department FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);
GO


-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Doctors
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\doctors.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);
GO

select * from doctors





--Create table ------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Patients
CREATE TABLE Patients (
    Patient_ID          VARCHAR(10) PRIMARY KEY,
    Patient_Name        VARCHAR(100),
    Gender              VARCHAR(10),
    Date_of_Birth       DATE,
    Age                 INT,
    City                VARCHAR(50),
    State               VARCHAR(50),
    Region              VARCHAR(20),
    Registration_Date   DATE,
    Insurance_Type      VARCHAR(30)
);
GO

-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Patients
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\patients.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);
GO

select * from Patients


--Create table ------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Appointments
CREATE TABLE Appointments (
    Appointment_ID       VARCHAR(10) PRIMARY KEY,
    Patient_ID           VARCHAR(10),
    Doctor_ID            VARCHAR(10),
    Hospital_ID          VARCHAR(10),
    Department_ID        VARCHAR(10),
    Appointment_Date     DATE,
    Appointment_Type     VARCHAR(20),
    Appointment_Status   VARCHAR(20),
    CONSTRAINT FK_Appt_Patient    FOREIGN KEY (Patient_ID)    REFERENCES Patients(Patient_ID),
    CONSTRAINT FK_Appt_Doctor     FOREIGN KEY (Doctor_ID)     REFERENCES Doctors(Doctor_ID),
    CONSTRAINT FK_Appt_Hospital   FOREIGN KEY (Hospital_ID)   REFERENCES Hospitals(Hospital_ID),
    CONSTRAINT FK_Appt_Department FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);
GO


-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Appointments
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\appointments.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

select * from Appointments



--Create table ------------------------------------------------------------------------------------------------------------------------------------------
-- 6. Admissions
CREATE TABLE Admissions (
    Admission_ID       VARCHAR(10) PRIMARY KEY,
    Patient_ID         VARCHAR(10),
    Hospital_ID        VARCHAR(10),
    Department_ID      VARCHAR(10),
    Doctor_ID          VARCHAR(10),
    Admission_Date     DATE,
    Discharge_Date     DATE,
    Admission_Type     VARCHAR(20),
    Admission_Status   VARCHAR(20),
    Length_of_Stay     INT,
    CONSTRAINT FK_Adm_Patient    FOREIGN KEY (Patient_ID)    REFERENCES Patients(Patient_ID),
    CONSTRAINT FK_Adm_Hospital   FOREIGN KEY (Hospital_ID)   REFERENCES Hospitals(Hospital_ID),
    CONSTRAINT FK_Adm_Department FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID),
    CONSTRAINT FK_Adm_Doctor     FOREIGN KEY (Doctor_ID)     REFERENCES Doctors(Doctor_ID)
);
GO


-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Admissions
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\admissions.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);


select * from Admissions




--Create table ------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Treatments
CREATE TABLE Treatments (
    Treatment_ID        VARCHAR(10) PRIMARY KEY,
    Admission_ID        VARCHAR(10),
    Patient_ID          VARCHAR(10),
    Diagnosis           VARCHAR(100),
    Treatment           VARCHAR(100),
    Treatment_Cost       INT,
    Treatment_Date       DATE,
    Treatment_Outcome    VARCHAR(30),
    CONSTRAINT FK_Treat_Admission FOREIGN KEY (Admission_ID) REFERENCES Admissions(Admission_ID),
    CONSTRAINT FK_Treat_Patient   FOREIGN KEY (Patient_ID)   REFERENCES Patients(Patient_ID)
);
GO


-- Insert into table------------------------------------------------------------------------------------------------------------------------------------
BULK INSERT Treatments
FROM 'C:\Users\HP\OneDrive\Desktop\complete Interview preparation\07_Mix All Projects\Healthcare Data Analytics Project by Ducat DK Sir\Trial -2 chat gpt\Healthcare_Analytics_India_CSV_Files\treatments.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

select * from Treatments





-- ===== Verification: row counts for every table =====
SELECT 'Hospitals' AS TableName, COUNT(*) AS Row_Count FROM Hospitals
UNION ALL
SELECT 'Departments', COUNT(*) FROM Departments
UNION ALL
SELECT 'Doctors', COUNT(*) FROM Doctors
UNION ALL
SELECT 'Patients', COUNT(*) FROM Patients
UNION ALL
SELECT 'Appointments', COUNT(*) FROM Appointments
UNION ALL
SELECT 'Admissions', COUNT(*) FROM Admissions
UNION ALL
SELECT 'Treatments', COUNT(*) FROM Treatments;



/*

SQL Practice Question Bank
--------------------------------------------------------------------------------------------------------------------------------------------------------
🟢 PHASE A — Basic Queries (SELECT, WHERE, ORDER BY, basic aggregates)
---------------------------------------------------------------------------------------------------------------------------------------------------------
1.List all hospitals along with their city and state.
2.Find all patients who are older than 60 years.
3.Get the total number of patients, appointments, admissions, doctors, and hospitals (separately).
4.Find all doctors working in the "Cardiology" department.
5.List all appointments with status "Cancelled".
6.Find the total revenue generated from all treatments.
7.List all female patients from "Delhi".
8.Find the top 5 patients based on age (oldest patients).
9.List all distinct cities where patients live.
10.Find all admissions where Length_of_Stay is greater than 7 days.





---------------------------------------------------------------------------------------------------------------------------------------------------------
🟡 PHASE B — Medium Queries (JOINs, GROUP BY, HAVING, subqueries)
---------------------------------------------------------------------------------------------------------------------------------------------------------
Find the number of doctors in each department.
Find total revenue generated by each hospital.
Find the average consultation fee by department.
Find the number of appointments per month (monthly trend).
Find the top 5 doctors who have the highest number of appointments.
Find the department that generated the highest total treatment revenue.
Find the average length of stay for admissions, grouped by department.
Find the number of patients from each city, sorted highest to lowest.
Find all doctors who have more than 10 years of experience, along with their hospital name.
Find the count of appointments grouped by appointment status (Completed/Cancelled/Scheduled etc.)
Find hospitals that have more than 500 total appointments.
Find the most common diagnosis among all treatments.
List patients who have never had an appointment (patients with zero appointments).
-----------------------------------------------------------------------------------------------------------------------------------------------------
🔴 PHASE C — Advanced Queries (multi-table joins, window functions, CTEs, subqueries, business logic)
--------------------------------------------------------------------------------------------------------------------------------------------------------
Find the top 3 hospitals by total revenue generated (joining Hospitals → Doctors/Appointments → Treatments).
For each department, find the doctor with the highest number of appointments (using window functions).
Calculate month-over-month growth in appointment counts.
Find the percentage contribution of each department to total hospital revenue.
Find patients who have had more than 1 admission (repeat/readmitted patients).
Using a CTE, rank hospitals by average length of stay (lowest = most efficient).
Find the average revenue per doctor, and identify doctors performing above the overall average.
Find the busiest day of the week for appointments (which weekday has the most appointments).
Create a query that shows, for every hospital, the number of patients, number of doctors, and total revenue — all in a single result (using multiple JOINs).
Find the treatment outcome success rate (% of treatments with a "Successful"/positive outcome) by department.


*/

--PHASE A — Basic Queries (SELECT, WHERE, ORDER BY, basic aggregates) solution:------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
use HealthcareAnalyticsDB
--1.List all hospitals along with their city and state.
SELECT Hospital_Name, City, State
FROM Hospitals;


--2.Find all patients who are older than 60 years.
SELECT Patient_Name, Age, Gender, City
FROM Patients
WHERE Age > 60;


--3.Get the total number of patients, appointments, admissions, doctors, and hospitals (separately).
SELECT COUNT(*) AS Total_Patients FROM Patients;
SELECT COUNT(*) AS Total_Appointments FROM Appointments;
SELECT COUNT(*) AS Total_Admissions FROM Admissions;
SELECT COUNT(*) AS Total_Doctors FROM Doctors;
SELECT COUNT(*) AS Total_Hospitals FROM Hospitals;


--4.Find all doctors working in the "Cardiology" department.
SELECT d.Doctor_Name, d.Experience_Years, d.Consultation_Fee,dept.Department_Name
FROM Doctors d
JOIN Departments dept ON d.Department_ID = dept.Department_ID
WHERE dept.Department_Name = 'Cardiology';



-- Q5.List all appointments with status "Cancelled".
select * from Appointments
SELECT Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Status
FROM Appointments
WHERE Appointment_Status = 'Cancelled';


--Q6: Find the total revenue generated from all treatments.
SELECT SUM(Treatment_Cost) AS Total_Revenue
FROM Treatments;

--07.List all female patients from "Delhi".
SELECT Patient_Name, Age, Gender, City
FROM Patients
WHERE Gender = 'Female' AND City = 'Delhi';

-- Q8: Find the top 5 patients based on age (oldest patients).
SELECT TOP 5 Patient_Name, Age, City
FROM Patients
ORDER BY Age DESC;

-- 09.List all distinct cities where patients live.
SELECT DISTINCT City
FROM Patients;

--Q10: Find all admissions where Length_of_Stay is greater than 7 days.
SELECT Admission_ID, Patient_ID, Admission_Date, Discharge_Date, Length_of_Stay
FROM Admissions
WHERE Length_of_Stay > 7;




-- 🟡 PHASE B — Medium Queries (JOINs, GROUP BY, HAVING, subqueries)------------------------------------------------------------------------------------

--Q11: Find the number of doctors in each department.
SELECT dept.Department_Name, COUNT(*) AS Doctor_Count
FROM Doctors d
JOIN Departments dept ON d.Department_ID = dept.Department_ID
GROUP BY dept.Department_Name
ORDER BY Doctor_Count DESC;


-- Q12: Find total revenue generated by each hospital.
SELECT h.Hospital_Name, SUM(t.Treatment_Cost) AS Total_Revenue
FROM Treatments t
JOIN Admissions a ON t.Admission_ID = a.Admission_ID
JOIN Hospitals h ON a.Hospital_ID = h.Hospital_ID
GROUP BY h.Hospital_Name
ORDER BY Total_Revenue DESC;


--Q13: Find the average consultation fee by department.
SELECT dept.Department_Name, AVG(d.Consultation_Fee) AS Avg_Consultation_Fee
FROM Doctors d
JOIN Departments dept ON d.Department_ID = dept.Department_ID
GROUP BY dept.Department_Name
ORDER BY Avg_Consultation_Fee DESC;



--Q14: Find the number of appointments per month (monthly trend).
SELECT
    FORMAT(Appointment_Date, 'yyyy-MM') AS Appointment_Month,
    COUNT(*) AS Appointment_Count
FROM Appointments
GROUP BY FORMAT(Appointment_Date, 'yyyy-MM')
ORDER BY Appointment_Month;




-- Q15: Find the top 5 doctors who have the highest number of appointments.
SELECT TOP 5 d.Doctor_Name, COUNT(*) AS Appointment_Count
FROM Appointments a
JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
GROUP BY d.Doctor_Name
ORDER BY Appointment_Count DESC;


-- Q16: Find the department that generated the highest total treatment revenue.
SELECT TOP 1 dept.Department_Name, SUM(t.Treatment_Cost) AS Total_Revenue
FROM Treatments t
JOIN Admissions a ON t.Admission_ID = a.Admission_ID
JOIN Departments dept ON a.Department_ID = dept.Department_ID
GROUP BY dept.Department_Name
ORDER BY Total_Revenue DESC;


--Q17:Find the average length of stay for admissions, grouped by department.
SELECT dept.Department_Name, AVG(a.Length_of_Stay * 1.0) AS Avg_Length_of_Stay
FROM Admissions a
JOIN Departments dept ON a.Department_ID = dept.Department_ID
GROUP BY dept.Department_Name
ORDER BY Avg_Length_of_Stay DESC;


-- Q18: Find the number of patients from each city, sorted highest to lowest.
SELECT City, COUNT(*) AS Patient_Count
FROM Patients
GROUP BY City
ORDER BY Patient_Count DESC;


-- Q19: Find all doctors with more than 10 years of experience, with their hospital name.
SELECT d.Doctor_Name, d.Experience_Years, h.Hospital_Name
FROM Doctors d
JOIN Hospitals h ON d.Hospital_ID = h.Hospital_ID
WHERE d.Experience_Years > 10
ORDER BY d.Experience_Years DESC;


--Q20: Find the count of appointments grouped by appointment status.
SELECT Appointment_Status, COUNT(*) AS Status_Count
FROM Appointments
GROUP BY Appointment_Status
ORDER BY Status_Count DESC;




-- Q21: Find hospitals that have more than 500 total appointments. (HAVING clause) 
SELECT h.Hospital_Name, COUNT(*) AS Total_Appointments
FROM Appointments a
JOIN Hospitals h ON a.Hospital_ID = h.Hospital_ID
GROUP BY h.Hospital_Name
HAVING COUNT(*) > 500
ORDER BY Total_Appointments DESC;



--Q22: Find the most common diagnosis among all treatments.
SELECT TOP 1 Diagnosis, COUNT(*) AS Diagnosis_Count
FROM Treatments
GROUP BY Diagnosis
ORDER BY Diagnosis_Count DESC;



 --Q23: List patients who have never had an appointment (subquery).
SELECT Patient_ID, Patient_Name
FROM Patients
WHERE Patient_ID NOT IN (
    SELECT DISTINCT Patient_ID FROM Appointments
);



-- PHASE C - ADVANCED QUERIES---------------------------------------------------------------------------------------------------------------------------
--Q24: Find the top 3 hospitals by total revenue generated.
SELECT TOP 3 h.Hospital_Name, SUM(t.Treatment_Cost) AS Total_Revenue
FROM Treatments t
JOIN Admissions a ON t.Admission_ID = a.Admission_ID
JOIN Hospitals h ON a.Hospital_ID = h.Hospital_ID
GROUP BY h.Hospital_Name
ORDER BY Total_Revenue DESC;



--Q25: For each department, find the doctor with the highest number of appointments (window function: RANK).
WITH DoctorAppointmentCounts AS (
    SELECT
        dept.Department_Name,
        d.Doctor_Name,
        COUNT(*) AS Appointment_Count,
        RANK() OVER (PARTITION BY dept.Department_Name ORDER BY COUNT(*) DESC) AS Rnk
    FROM Appointments a
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
    JOIN Departments dept ON d.Department_ID = dept.Department_ID
    GROUP BY dept.Department_Name, d.Doctor_Name
)
SELECT Department_Name, Doctor_Name, Appointment_Count
FROM DoctorAppointmentCounts
WHERE Rnk = 1;


--Q26: Calculate month-over-month growth in appointment counts. 
WITH MonthlyCounts AS (
    SELECT
        FORMAT(Appointment_Date, 'yyyy-MM') AS Appt_Month,
        COUNT(*) AS Appt_Count
    FROM Appointments
    GROUP BY FORMAT(Appointment_Date, 'yyyy-MM')
)
SELECT
    Appt_Month,
    Appt_Count,
    LAG(Appt_Count) OVER (ORDER BY Appt_Month) AS Prev_Month_Count,
    Appt_Count - LAG(Appt_Count) OVER (ORDER BY Appt_Month) AS Change,
    ROUND(
        (Appt_Count - LAG(Appt_Count) OVER (ORDER BY Appt_Month)) * 100.0
        / NULLIF(LAG(Appt_Count) OVER (ORDER BY Appt_Month), 0), 1
    ) AS Growth_Percent
FROM MonthlyCounts
ORDER BY Appt_Month;


--Q27: Find the percentage contribution of each department to total revenue.
WITH DeptRevenue AS (
    SELECT dept.Department_Name, SUM(t.Treatment_Cost) AS Dept_Revenue
    FROM Treatments t
    JOIN Admissions a ON t.Admission_ID = a.Admission_ID
    JOIN Departments dept ON a.Department_ID = dept.Department_ID
    GROUP BY dept.Department_Name
)
SELECT
    Department_Name,
    Dept_Revenue,
    ROUND(Dept_Revenue * 100.0 / SUM(Dept_Revenue) OVER (), 2) AS Pct_Of_Total_Revenue
FROM DeptRevenue
ORDER BY Pct_Of_Total_Revenue DESC;


--Q28: Find patients who have had more than 1 admission (repeat patients).
SELECT Patient_ID, COUNT(*) AS Admission_Count
FROM Admissions
GROUP BY Patient_ID
HAVING COUNT(*) > 1
ORDER BY Admission_Count DESC;


--Q29: Using a CTE, rank hospitals by average length of stay (lowest = most efficient).
WITH HospitalLOS AS (
    SELECT h.Hospital_Name, AVG(a.Length_of_Stay * 1.0) AS Avg_LOS
    FROM Admissions a
    JOIN Hospitals h ON a.Hospital_ID = h.Hospital_ID
    GROUP BY h.Hospital_Name
)
SELECT
    Hospital_Name,
    ROUND(Avg_LOS, 2) AS Avg_Length_Of_Stay,
    RANK() OVER (ORDER BY Avg_LOS ASC) AS Efficiency_Rank
FROM HospitalLOS
ORDER BY Efficiency_Rank;



--Q30: Find average revenue per doctor, and doctors performing above average. 
WITH DoctorRevenue AS (
    SELECT d.Doctor_Name, SUM(t.Treatment_Cost) AS Total_Revenue
    FROM Treatments t
    JOIN Admissions a ON t.Admission_ID = a.Admission_ID
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
    GROUP BY d.Doctor_Name
)
SELECT
    Doctor_Name,
    Total_Revenue,
    (SELECT AVG(Total_Revenue) FROM DoctorRevenue) AS Overall_Avg_Revenue
FROM DoctorRevenue
WHERE Total_Revenue > (SELECT AVG(Total_Revenue) FROM DoctorRevenue)
ORDER BY Total_Revenue DESC;
GO

--Q31: Find the busiest day of the week for appointments.
SELECT
    DATENAME(WEEKDAY, Appointment_Date) AS Day_Of_Week,
    COUNT(*) AS Appointment_Count
FROM Appointments
GROUP BY DATENAME(WEEKDAY, Appointment_Date)
ORDER BY Appointment_Count DESC;



--Q32: For every hospital, show patient count (via admissions), doctor count,and total revenue -- all in one result. 
SELECT
    h.Hospital_Name,
    COUNT(DISTINCT a.Patient_ID)  AS Patient_Count,
    COUNT(DISTINCT doc.Doctor_ID) AS Doctor_Count,
    ISNULL(SUM(t.Treatment_Cost), 0) AS Total_Revenue
FROM Hospitals h
LEFT JOIN Admissions a  ON h.Hospital_ID = a.Hospital_ID
LEFT JOIN Doctors doc   ON h.Hospital_ID = doc.Hospital_ID
LEFT JOIN Treatments t  ON t.Admission_ID = a.Admission_ID
GROUP BY h.Hospital_Name
ORDER BY Total_Revenue DESC;



--Q33: Find treatment outcome success rate (%) by department.
SELECT
    dept.Department_Name,
    COUNT(*) AS Total_Treatments,
    SUM(CASE WHEN t.Treatment_Outcome = 'Recovered' THEN 1 ELSE 0 END) AS Successful_Count,
    ROUND(
        SUM(CASE WHEN t.Treatment_Outcome = 'Recovered' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 1
    ) AS Success_Rate_Percent
FROM Treatments t
JOIN Admissions a ON t.Admission_ID = a.Admission_ID
JOIN Departments dept ON a.Department_ID = dept.Department_ID
GROUP BY dept.Department_Name
ORDER BY Success_Rate_Percent DESC;

