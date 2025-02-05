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
(5, 'Jade', 'Dawson', '2023-05-25', 0);

/* Step 2: Create temp variable */
DECLARE @TempEmployeeId int, @TempFirstName nvarchar(50), @TempLastName nvarchar(50), @TempHireDate DATE, @TempIsActive BIT

/* Step 3: Declare cursor to loop all the rows */
DECLARE row_cursor CURSOR FOR
SELECT EmployeeID, FirstName, LastName, HireDate, IsActive from Employees

/* Step 4: Open the cursor */
OPEN row_cursor

/* Step 5: Fetch the first row */
FETCH NEXT FROM row_cursor INTO @TempEmployeeId, @TempFirstName, @TempLastName, @TempHireDate, @TempIsActive

/* Step 6: Loop through each rows */
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @TempEmployeeId, @TempFirstName, @TempLastName, @TempHireDate, @TempIsActive

	FETCH NEXT FROM row_cursor INTO @TempEmployeeId, @TempFirstName, @TempLastName, @TempHireDate, @TempIsActive
END

/* Step 7: Close and deallocate cursor */
CLOSE row_cursor
DEALLOCATE row_cursor