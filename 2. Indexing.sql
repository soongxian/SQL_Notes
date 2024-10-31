/* Step 1: Create Employee table and insert value */

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    HireDate DATE,
    IsActive BIT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate, IsActive) VALUES
(1, 'Basyir', 'Abdullah', '2021-01-10', 1),
(2, 'Aisyah', 'Mohammad', '2022-03-15', 0),
(3, 'Eugene', 'Soh', '2020-07-20', 1),
(4, 'Haoyi', 'Chiew', '2021-09-12', 1),
(5, 'Ashi', 'Rajendran', '2019-11-05', 1),
(6, 'Jade', 'Dawson', '2023-05-25', 0);

/* Step 2: Create index */
CREATE INDEX idx_emp_name_hire ON Employees(FirstName,LastName,HireDate);
CREATE INDEX idx_emp_name_active ON Employees(FirstName,LastName) where isActive = 1;

/* Step 3: Check performance of index */
select EmployeeId from Employees
select FirstName + ' ' + LastName, HireDate from Employees
select FirstName + ' ' + LastName from Employees where isActive = 1

-- Will see that idx_emp_name_active does not increase in User Scan with the queries above
SELECT
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    dm_reads.user_seeks AS UserSeeks, 
    dm_reads.user_scans AS UserScans,
    dm_reads.user_lookups AS UserLookups,
    dm_reads.user_updates AS UserUpdates
FROM 
    sys.indexes i
LEFT JOIN 
    sys.dm_db_index_usage_stats dm_reads 
    ON i.index_id = dm_reads.index_id AND i.object_id = dm_reads.object_id
WHERE 
    OBJECTPROPERTY(i.object_id, 'IsUserTable') = 1;

/* Step 4: Removing index that do not serve function*/
DROP INDEX idx_emp_name_active ON Employees;