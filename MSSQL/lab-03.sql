--Part – A 
--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
CREATE OR ALTER PROC PR_DATE
@DATE DATE 
AS BEGIN 
	SELECT FacultyName,FacultyJoiningDate
	FROM FACULTY
	WHERE FacultyJoiningDate =@DATE
END 

EXEC PR_DATE '2010-07-15'

--2.	Create a stored procedure for ENROLLMENT table where user enters  StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.
CREATE OR ALTER PROC PR_DETAILS
@ID INT 
AS BEGIN 
	SELECT  EnrollmentID, EnrollmentDate, Grade, EnrollmentStatus
	FROM ENROLLMENT
	WHERE StudentID = @ID
END

EXEC PR_DETAILS 1

--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
CREATE OR ALTER PROC PR_CREDITSRANGE
@MIN INT,
@MAX INT
AS BEGIN 
	SELECT CourseName,CourseCredits
	FROM COURSE
	WHERE CourseCredits BETWEEN @MIN AND @MAX
END 

EXEC PR_CREDITSRANGE 1,4

--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
CREATE OR ALTER PROC PR_STULIST 
@CNAME VARCHAR(100)
AS BEGIN 
	SELECT StuName
	FROM STUDENT 
	JOIN ENROLLMENT
	ON ENROLLMENT.StudentID = STUDENT.StudentID
	JOIN COURSE
	ON COURSE.CourseID=ENROLLMENT.CourseID
	WHERE CourseName = @CNAME
END

EXEC PR_STULIST 'Data Structures'

--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
CREATE OR ALTER PROC PR_COURSE_ASSIGN
@FNAME VARCHAR(100)
AS BEGIN 
	SELECT *
	FROM COURSE_ASSIGNMENT 
	JOIN COURSE
	ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
	JOIN FACULTY 
	ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
	WHERE FacultyName =@FNAME
END

EXEC PR_COURSE_ASSIGN 'Dr. Patel'

--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
CREATE OR ALTER PROC PR_SEM_DETAILS
@SEM INT,@Y INT 
AS BEGIN
	SELECT AssignmentID,CourseID,FacultyName,Semester,Year,ClassRoom
	FROM COURSE_ASSIGNMENT
	JOIN FACULTY
	ON COURSE_ASSIGNMENT.FacultyID = FACULTY.FacultyID
	WHERE Semester =@SEM AND Year =@Y
END 

EXEC PR_SEM_DETAILS 1,2024


--Part – B 

--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
CREATE OR ALTER PROC PR_STATUS_LIKE
@STATUS VARCHAR(10)
AS BEGIN
	SELECT EnrollmentID,StudentID,CourseID,EnrollmentDate,Grade,EnrollmentStatus
	FROM ENROLLMENT
	WHERE EnrollmentStatus  LIKE @STATUS+'%'
END

EXEC PR_STATUS_LIKE 'D'
--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
CREATE OR ALTER PROC PR_STU_PRINT
@NAME VARCHAR(100)
AS BEGIN 
	SELECT *
	FROM STUDENT
	WHERE StuName =@NAME OR StuDepartment =@NAME 
END 

EXEC PR_STU_PRINT 'RajPatel'

--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
CREATE OR ALTER PROC PR_STU_COURSE
@CID VARCHAR(10),
@CNT INT  OUTPUT
AS BEGIN 
	SELECT @CNT=COUNT(*)
	FROM ENROLLMENT
	WHERE CourseID =@CID
	GROUP BY EnrollmentStatus
END 

DECLARE @CT INT
EXEC PR_STU_COURSE 'CS101',@CNT = @CT  OUTPUT
SELECT @CT
--Part – C 

--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
CREATE OR ALTER PROC PR_YEAR
@YEAR INT 
AS BEGIN 
	SELECT classroom,CourseName,FacultyName
	from COURSE c
	join COURSE_ASSIGNMENT ca
	on c.CourseID = ca.CourseID
	join faculty f
	on F.FacultyID = ca.FacultyID
	where ca.year = @YEAR
	group by classroom,CourseName,FacultyName
END

EXEC PR_YEAR 2024

--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
CREATE OR ALTER PROC PR_DATE_RANGE
@FROM DATE ,@TO DATE 
AS BEGIN 
	SELECT EnrollmentID,StuNAME,CourseName
	FROM ENROLLMENT
	JOIN STUDENT
	ON STUDENT.StudentID = ENROLLMENT.StudentID
	JOIN COURSE
	ON COURSE.CourseID = ENROLLMENT.CourseID
	WHERE EnrollmentDate BETWEEN @FROM AND @TO
END 

EXEC PR_DATE_RANGE '2021-07-01','2022-01-05'

--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
CREATE OR ALTER PROC PR_SUM_CREDIT
@FID INT ,@TOT INT OUTPUT
AS BEGIN 
	SELECT @TOT = SUM(CourseCredits)
	FROM COURSE
	JOIN COURSE_ASSIGNMENT
	ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
	JOIN FACULTY
	ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
	WHERE FacultY.FacultyID =@FID
END 

DECLARE @TT INT 
EXEC PR_SUM_CREDIT 101,@TOT=@TT OUTPUT
SELECT @TT
