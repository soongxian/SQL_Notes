-- Rollback transaction if error found
SET XACT_ABORT ON

-- Capture start time 
DECLARE @StartTime DATETIME = GETDATE();

PRINT '*******************************************************'
PRINT 'SERVER: ' + @@SERVERNAME
PRINT 'DATABASE: ' +  DB_NAME()
PRINT 'USER: '+ CURRENT_USER
PRINT 'START TIME: ' + CONVERT (VARCHAR(20), @StartTime, 120)
PRINT '*******************************************************'

/* Start validation: Database */
BEGIN TRY
IF @@SERVERNAME NOT IN ('RyanLIM_Laptop','OtherServer_Name') 
BEGIN
DECLARE @ErrorMsg NVARCHAR(255) = @@SERVERNAME + ' failed server verification';
RAISERROR (@ErrorMsg, 16, 1);
END
END TRY
BEGIN CATCH
PRINT 'Transaction failed: ' + CASE WHEN ERROR_MESSAGE() IS NULL THEN '.' ELSE ERROR_MESSAGE() END
RETURN
END CATCH
/* End validation: Database */

/* Start validation: SQL Scripts */
BEGIN TRY
BEGIN TRANSACTION
-- Start of SQL script

-- Example of good data
-- (1 row) - State number of rows affected for consistency for code review. 
SELECT 1 / 1

-- Example of bad data
--SELECT 1 / 0

-- End of SQL script
COMMIT TRANSACTION -- ROLLBACK TRANSACTION  (COMMIT is used for making the changes / ROLLBACK is used for testing the changes)
PRINT 'Transaction complete.'
END TRY
BEGIN CATCH
PRINT 'Transaction failed at Line '+ ISNULL(CAST(ERROR_LINE() AS VARCHAR), '') + '. Error Msg: ' + ISNULL(ERROR_MESSAGE(), '')
ROLLBACK TRANSACTION
RAISERROR ('Transaction failed.', 16, 1)
END CATCH
/* End validation: SQL Scripts */

-- Capture the end time
DECLARE @EndTime DATETIME = GETDATE()

-- Calculate total time taken
DECLARE @TotalTime INT = DATEDIFF(SECOND, @StartTime, @EndTime)

PRINT '*******************************************************'
PRINT 'END TIME: ' + CONVERT (VARCHAR(20), GETDATE(), 120)
PRINT 'TOTAL TIME: ' + CAST(@TotalTime AS VARCHAR) + ' seconds';
PRINT '*******************************************************'