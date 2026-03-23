--Part – A 
use CSE_4B_355

--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error. 
BEGIN TRY

	DECLARE @A INT = 10,@B INT = 10;

	DECLARE @RESULT INT;
	SET @RESULT = @A / @B;

	PRINT @RESULT;
END TRY

BEGIN CATCH

	PRINT 'Error occurs that is - Divide by zero error.'

END CATCH

GO
CREATE OR ALTER PROCEDURE PR_DivideNumbers
	@A	INT,
	@B	INT
AS
BEGIN
	BEGIN TRY
		DECLARE @RESULT INT;
		SET @RESULT = @A / @B;

		PRINT 'Result = ' + CAST(@RESULT AS VARCHAR);
	END TRY
	BEGIN CATCH
		PRINT 'Error occurs that is - Divide by zero error.'
	END CATCH
END;
GO

EXEC PR_DivideNumbers 10,2;
EXEC PR_DivideNumbers 10,0;

--WITHOUT PARAMETERS
BEGIN TRY
	SELECT 10 / 0
END TRY
BEGIN CATCH
	THROW;		-- rethrows the same error.
END CATCH

--2. Try to convert string to integer and handle the error using try…catch block. 
BEGIN TRY
	DECLARE @STR VARCHAR(10) = 'ABC';
	DECLARE @NUM INT;

	SET @NUM = CAST(@STR AS INT);

	PRINT 'Converted Number = ' + CAST(@NUM AS VARCHAR);
END TRY

BEGIN CATCH
	PRINT 'Error: Cannot convert string to integer';
	SELECT 
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result.
GO
CREATE OR ALTER PROCEDURE PR_AddNumbers
	@N1 INT,@N2 INT
AS
BEGIN
	BEGIN TRY
		DECLARE @SUM INT;
		SET @SUM = @N1 + @N2;

		PRINT 'Sum = ' + CAST(@SUM AS VARCHAR);
	END TRY
	BEGIN CATCH
		-- ERROR FUNCTIONS

		SELECT 
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_PROCEDURE() AS ErrorProcedure
	END CATCH;
END;
GO

EXEC PR_AddNumbers 10,20;
EXEC PR_AddNumbers 10,'DARSHAN';

--4. Handle a Primary Key Violation while inserting data into student table and print the error details such 
--as the error message, error number, severity, and state. 
GO
CREATE OR ALTER PROCEDURE PR_CheckStudent
	@SID INT
AS
BEGIN
	BEGIN TRY

	DECLARE @COUNT INT;

	SELECT @COUNT = COUNT(*) FROM STUDENT WHERE StudentID = @SID;

	IF @COUNT = 0
		THROW 50001,'No StudentID is available in database',1
	ELSE
		PRINT 'StudentID exists in database'

	END TRY

	BEGIN CATCH
			
	SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_STATE() AS ErrorState,
        ERROR_MESSAGE() AS ErrorMessage

	END CATCH
END;


--5. Throw custom exception using stored procedure which accepts StudentID as input & that throws 
--Error like no StudentID is available in database. 

GO
CREATE OR ALTER PROCEDURE PR_CheckStudent
	@SID INT
AS
BEGIN
	BEGIN TRY

	DECLARE @COUNT INT;

	SELECT @COUNT = COUNT(*) FROM STUDENT WHERE StudentID = @SID;

	IF @COUNT = 0
		THROW 50001,'No StudentID is available in database',1
	ELSE
		PRINT 'StudentID exists in database'

	END TRY

	BEGIN CATCH
			
	SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_STATE() AS ErrorState,
        ERROR_MESSAGE() AS ErrorMessage

	END CATCH
END;
GO

--6. Handle a Foreign Key Violation while inserting data into Enrollment table and print appropriate error 
--message. 
GO
CREATE OR ALTER PROCEDURE PR_InsertEnrollment
	@EnrollID INT,
	@StudentID INT
AS
BEGIN
	BEGIN TRY

	INSERT INTO ENROLLMENT(EnrollmentID, StudentID)
	VALUES(@EnrollID, @StudentID);

	PRINT 'Record Inserted Successfully';

	END TRY

	BEGIN CATCH

	IF ERROR_NUMBER() = 547
		PRINT 'Foreign Key Violation: StudentID does not exist';
	ELSE
		PRINT ERROR_MESSAGE();

	END CATCH
END;
GO
--Part – B 

--7. Handle Invalid Date Format 
BEGIN TRY

	DECLARE @DATE VARCHAR(20) = '32-13-2024';
	DECLARE @NEWDATE DATE;

	SET @NEWDATE = CAST(@DATE AS DATE);

	PRINT 'Valid Date = ' + CAST(@NEWDATE AS VARCHAR);

END TRY

BEGIN CATCH

	PRINT 'Invalid Date Format';
	SELECT ERROR_MESSAGE() AS ErrorMessage;

END CATCH

--8. Procedure to Update faculty’s Email with Error Handling. 
GO
CREATE OR ALTER PROCEDURE PR_UpdateFacultyEmail
	@FID INT,
	@EMAIL VARCHAR(100)
AS
BEGIN

	BEGIN TRY

	UPDATE FACULTY
	SET Email = @EMAIL
	WHERE FacultyID = @FID;

	IF @@ROWCOUNT = 0
		PRINT 'FacultyID not found';
	ELSE
		PRINT 'Email Updated Successfully';

	END TRY

	BEGIN CATCH

	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END;

--9. Throw custom exception that throws error if the data is invalid. 
GO
CREATE OR ALTER PROCEDURE PR_CheckAge
	@AGE INT
AS
BEGIN

	IF @AGE < 18
		THROW 50002, 'Invalid Age: Age must be greater than 18', 1;

	PRINT 'Valid Age';

END;
GO

--Part – C 

--10. Write a script that checks if a faculty’s salary is NULL. If it is, use RAISERROR to show a message with a 
--severity of 16. (Note: Do not use any table)
DECLARE @Salary INT = NULL;

IF @Salary IS NULL
BEGIN
	RAISERROR('Faculty salary cannot be NULL',16,1);
END
ELSE
BEGIN
	PRINT 'Salary = ' + CAST(@Salary AS VARCHAR);
END