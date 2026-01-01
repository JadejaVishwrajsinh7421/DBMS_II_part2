use CSE_4B_355

--Part – A 
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT
CREATE OR ALTER PROC PR_INSERT_STUDENT 
@StuID 	INT ,
@Name VARCHAR(100)	,
@Email	VARCHAR(100),
@Phone	VARCHAR(15),
@Department VARCHAR(50),
@DOB	DATE ,
@EnrollmentYear INT,
@CGPA DECIMAL(3,2)
AS 
BEGIN
INSERT INTO STUDENT  VALUES (@StuID,@Name,@Email,@Phone,@Department,@DOB,@EnrollmentYear,@CGPA)
END

EXEC PR_INSERT_STUDENT 10,'Harsh Parmar','harsh@univ.edu','9876543218','CSE','2005-09-18','2023',NULL
EXEC PR_INSERT_STUDENT 20,'Om Patel','om@univ.edu','9876543211','IT','2002-08-22','2022',NULL
SELECT * FROM STUDENT

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
CREATE OR ALTER PROC PR_INSERT_COURSE
@CourseID VARCHAR(10),
@CourseName VARCHAR(100),
@CourseCredits INT,
@CourseDepartment VARCHAR(50),
@CourseSemester INT

AS
BEGIN 
INSERT INTO Course  VALUES (@CourseID,@CourseName,@CourseCredits,@CourseDepartment,@CourseSemester)
END

EXEC PR_INSERT_COURSE 'CS330','Computer Networks',4	,'CSE',5
EXEC PR_INSERT_COURSE 'EC120','Electronic Circuits',3,'ECE',2

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
CREATE OR ALTER PROC PR_UPDATE_STUDENT
@EMAIL VARCHAR(100),
@PHONE VARCHAR(15),
@ID INT

AS 
BEGIN
	UPDATE STUDENT
	SET StuEmail = @EMAIL,STUPHONE = @PHONE
	WHERE StudentID = @ID

END

EXEC PR_UPDATE_STUDENT @EMAIL='harsh@UN.EDU',@PHONE='639789',@ID=10

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
CREATE OR ALTER PROC PR_DELETE_STUDENT
@NAME VARCHAR(50) 
AS 
BEGIN
	DELETE FROM STUDENT
	WHERE StudentID = @NAME
END

EXEC PR_DELETE_STUDENT 'Om Patel'

EXEC PR_DELETE_STUDENT 'Harsh Parmar'

--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
CREATE OR ALTER PROC PR__SELECT_STUDENT_BY_ID
@ID INT
AS 
BEGIN 
	SELECT *
	FROM STUDENT
	WHERE StudentID = @ID
END

EXEC PR__SELECT_STUDENT_BY_ID 1
--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
CREATE OR ALTER PROC PR_SELECT_5
AS 
BEGIN 
	SELECT TOP 5 *
	FROM STUDENT
	ORDER BY StuEnrollmentYear
END

EXEC PR_SELECT_5

--Part – B  

--7.	Create a stored procedure which displays faculty designation-wise count.
CREATE OR ALTER PROC PR_COUNT_FACULTY
AS
BEGIN
	SELECT COUNT(FacultyID) AS NO_FACULTY,FacultyDesignation
	FROM FACULTY
	GROUP BY FacultyDesignation
END

EXEC PR_COUNT_FACULTY

--8.	Create a stored procedure that takes department name as input and returns all students in that department.
CREATE OR ALTER PROC PR_STU_DEPT
@DEPT  VARCHAR(100)
AS BEGIN 
	SELECT StuName
	FROM STUDENT
	WHERE StuDepartment = @DEPT
END

EXEC PR_STU_DEPT 'ECE'

--Part – C 
--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
CREATE OR ALTER PROC PR_CREDITS
AS BEGIN 
	SELECT AVG(CourseCredits)AS AVG_CRED,MAX(CourseCredits)AS MAX_CRED,MIN(CourseCredits) AS MAX_CRED,CourseDepartment
	FROM COURSE
	GROUP BY CourseDepartment
END

EXEC PR_CREDITS 

--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
CREATE OR ALTER PROC PR_STU_COURSE
@STUID INT 
AS BEGIN
	SELECT CourseName,Grade
	FROM STUDENT S
	JOIN ENROLLMENT E
	ON S.StudentID= E.StudentID
	JOIN  COURSE C
	ON C.CourseID = E.CourseID
	WHERE S.StudentID = @STUID
END

EXEC PR_STU_COURSE 2
