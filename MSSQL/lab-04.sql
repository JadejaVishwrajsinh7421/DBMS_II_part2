use CSE_4B_355

--Part-A 
--1. Write a scalar function to print "Welcome to DBMS Lab". 
CREATE FUNCTION OR ALTER FN_WELCOME()
RETURNS VARCHAR(20)
AS 
BEGIN
	RETURN 'WELCOME TO DBMS-II'
END

SELECT DBO.FN_WELCOME()

--2. Write a scalar function to calculate simple interest.  
CREATE OR ALTER FUNCTION FN_SI(@AMT FLOAT ,@RATE FLOAT ,@TIME FLOAT)

RETURNS FLOAT 
AS 
BEGIN
	RETURN (@AMT*@RATE*@TIME)/100
END

SELECT DBO.FN_SI(2000,5.1,6)

--3. Function to Get Difference in Days Between Two Given Dates 
CREATE OR ALTER FUNCTION FN_DATEDIFF(@DATE1 DATE ,@DATE2 DATE)
RETURNS INT 
AS 
BEGIN 
	RETURN DATEDIFF(DAY,@DATE1,@DATE2)
END

SELECT DBO.FN_DATEDIFF('2006-12-04','2007-02-22')

--4. Write a scalar function which returns the sum of Credits for two given CourseIDs. 
CREATE OR ALTER FUNCTION FN_SUMCREDITS(@CI1 VARCHAR(10) ,@CI2 VARCHAR(10))
RETURNS INT
AS 
BEGIN
	RETURN (SELECT  SUM(CourseCredits) 
			FROM COURSE 
			WHERE CourseID IN (@CI1,@CI2))
END

SELECT DBO.FN_SUMCREDITS('CS101','CS201')

--5. Write a function to check whether the given number is ODD or EVEN. 
CREATE OR ALTER FUNCTION FN_CHECKEVEN(@NUM INT)
RETURNS VARCHAR(10)

AS 
BEGIN
	DECLARE @RESULT VARCHAR(10)

	IF @NUM % 2 = 0
		SET @RESULT = 'EVEN'
	ELSE
		SET @RESULT = 'ODD'

	RETURN @RESULT
END;

SELECT DBO.FN_CHECKEVEN(77455)

--6. Write a function to print number from 1 to N. (Using while loop) 
CREATE OR ALTER FUNCTION FN_PRINTN(@NUM INT)
RETURNS VARCHAR(100)

AS 
BEGIN
	DECLARE @MESS VARCHAR(100) 
	SET @MESS = ''

	DECLARE @I INT
	SET @I =1

	WHILE @I != @NUM
		BEGIN
			SET @MESS = @MESS + CAST(@I AS VARCHAR (10)) + ''
			SET @I = @I+1
		END
	RETURN @MESS
END

SELECT DBO.FN_PRINTN(5)

--7. Write a scalar function to calculate factorial of total credits for a given CourseID.
CREATE OR ALTER FUNCTION FN_SUM(@CI VARCHAR(10))
RETURNS  INT

AS 
BEGIN
	DECLARE @NUM INT
	SELECT @NUM = CourseCredits FROM COURSE WHERE CourseID =@CI
	DECLARE @ANS INT
	SET @ANS =1
	DECLARE @I INT 
	SET @I =1

		WHILE @I<=@NUM
		BEGIN
			SET @ANS =@ANS* @I
			SET @I =@I +1
		END
	RETURN @ANS
END;

SELECT DBO.FN_SUM('CS301')

--8. Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case 
--statement)  
CREATE OR ALTER FUNCTION FN_
--9. Write a table-valued function that returns details of students whose names start with a given letter. 
--10. Write a table-valued function that returns unique department names from the STUDENT table. 
--Part-B 
--11. Write a scalar function that calculates age in years given a DateOfBirth. 
--12. Write a scalar function to check whether given number is palindrome or not. 
--13. Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department. 
--14. Write a table-valued function that returns all courses taught by faculty with a specific designation. 

--Part-C
--15. Write a scalar function that accepts StudentID and returns their total enrolled credits (sum of credits 
--from all active enrollments). 
--16. Write a scalar function that accepts two dates (joining date range) and returns the count of faculty 
--who joined in that period. 

