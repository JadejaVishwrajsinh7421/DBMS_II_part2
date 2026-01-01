--SQL Concepts Revision
--Part – A 
--1.	Retrieve all unique departments from the STUDENT table.
		SELECT DISTINCT StuDepartment
		FROM STUDENT

--2.	Insert a new student record into the STUDENT table.(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)
		INSERT INTO STUDENT VALUES(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
		UPDATE STUDENT 
		SET StuEmail='raj.p@univ.edu'
		WHERE StudentID = 1

--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
		ALTER TABLE STUDENT 
		ADD CGPA DECIMAL(3,2)

--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
		SELECT CourseName 
		FROM COURSE
		WHERE COURSENAME LIKE 'DATA%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)
		SELECT STUNAME
		FROM STUDENT 
		WHERE STUNAME LIKE '%Shah%'

--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)
		SELECT UPPER(FacultyName)
		FROM FACULTY

--8.	Find all faculty who joined after 2015. (FACULTY table)
		SELECT * 
		FROM FACULTY
		WHERE FacultyJoiningDate > '2015'

--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
		SELECT SQRT(CourseCredits)
		FROM COURSE
		WHERE CourseName='Database Management Systems'

--10.	Find the Current Date using SQL Server in-built function.
		SELECT GETDATE()

--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)
		SELECT TOP 3 STUNAME
		FROM STUDENT
		ORDER BY StuEnrollmentYear

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)
		SELECT *
		FROM ENROLLMENT
		WHERE YEAR(EnrollmentDate) = 2022

--13.	Find the number of courses offered by each department. (COURSE table)
		SELECT COUNT(CourseName),CourseDepartment
		FROM COURSE
		GROUP BY CourseDepartment

--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
		
		SELECT CourseID,COUNT(CourseID)
		FROM ENROLLMENT
		

		
--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)
		SELECT STUNAME,EnrollmentStatus
		FROM STUDENT
		INNER JOIN ENROLLMENT
		ON STUDENT.StudentID=ENROLLMENT.EnrollmentID

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
		SELECT STUNAME,CourseName
		FROM STUDENT
		INNER JOIN ENROLLMENT
		ON STUDENT.StudentID=ENROLLMENT.EnrollmentID
		INNER JOIN COURSE
		ON COURSE.CourseID=ENROLLMENT.CourseID

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT,  table)
		CREATE VIEW  VM_ActiveEnrollments
		AS 
		SELECT STUNAME,CourseName
		FROM STUDENT
		INNER JOIN ENROLLMENT
		ON STUDENT.StudentID=ENROLLMENT.EnrollmentID
		INNER JOIN COURSE
		ON COURSE.CourseID=ENROLLMENT.CourseID
		WHERE EnrollmentStatus = 'ACTIVE' 

		SELECT * 
		FROM VM_ActiveEnrollments

--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)
		SELECT STUNAME
		FROM STUDENT
		WHERE StudentID NOT IN (SELECT StudentID FROM ENROLLMENT)

--19.	Display course name having second highest credit. (COURSE table)
		SELECT  TOP 1 CourseName
		FROM COURSE
		WHERE CourseCredits <(SELECT MAX(CourseCredits) FROM COURSE)

--Part – B 

--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)
		SELECT CourseName,COUNT(StudentID)
		FROM COURSE 
		JOIN ENROLLMENT
		ON ENROLLMENT.CourseID=COURSE.CourseID
		GROUP BY CourseName
--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)
		SELECT EnrollmentStatus,COUNT(EnrollmentID)
		FROM ENROLLMENT
		GROUP BY EnrollmentStatus
		HAVING COUNT(EnrollmentID) >2

--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)
		SELECT CourseName,CourseCredits,COURSE.CourseID
		FROM COURSE
		JOIN COURSE_ASSIGNMENT
		ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID

		JOIN FACULTY
		ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID

		WHERE FacultyName = 'Dr. Sheth'
		ORDER BY CourseCredits
		--Part – C 

--23.	List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)
		SELECT  S.StuName,S.StudentID
		FROM STUDENT S
		JOIN ENROLLMENT E
		ON S.StudentID= E.StudentID
		GROUP BY S.StuName ,S.StudentID
		HAVING COUNT(E.CourseID)>3

--24.	Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)
		SELECT S.StuName
		FROM STUDENT S 
		WHERE StudentID IN(SELECT StudentID FROM ENROLLMENT WHERE CourseID = 'CS101') 
		AND StudentID IN(SELECT StudentID FROM ENROLLMENT WHERE CourseID ='CS201' )

--25.	Retrieve department-wise count of faculty members along with their average years of experience (calculate experience from JoiningDate). (Faculty table)

		SELECT FacultyDepartment,count(*) as 'faculty_members',AVG(DATEDIFF(YEAR,FacultyJoiningDate,GETDATE())) AS 'AVG_EXP'
		from FACULTY 
		GROUP BY FacultyDepartment