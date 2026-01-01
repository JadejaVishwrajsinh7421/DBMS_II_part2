--1. Write a stored procedure to return course-wise student count for a specific semester. 
CREATE OR ALTER PROC PR_STU_COURSE_SEM
@SEM INT
AS BEGIN
	SELECT C.COURSENAME,COUNT(E.StudentID) AS STUDENTCOUNT
	FROM COURSE C
	JOIN ENROLLMENT E
	ON C.CourseID= E.CourseID
	WHERE C.CourseSemester = @SEM
	GROUP BY COURSENAME
END 

EXEC PR_STU_COURSE_SEM 1

--2. Create a stored procedure that returns all students who have completed 2 or more 
--than 2 courses. 
CREATE OR ALTER PROC PR_STU_2C
AS BEGIN
	SELECT S.StuName,C.CourseName,COUNT(C.CourseID)
	FROM STUDENT S
	JOIN ENROLLMENT E
	ON E.StudentID = S.StudentID
	JOIN COURSE C
	ON C.CourseID =E.CourseID
	GROUP BY S.StuName,C.CourseName
	HAVING COUNT(C.CourseID)  >=2
END

EXEC PR_STU_2C

--3. Create a stored procedure to list students without any active enrollment. 
CREATE OR ALTER PROC PR_STU_NOT_ACTIVE
AS BEGIN 
	SELECT S.StuName,S.StudentID
	FROM STUDENT S
	WHERE StudentID NOT IN (
		SELECT StudentID
		FROM ENROLLMENT
		WHERE EnrollmentStatus = 'ACTIVE'
	);
END;

EXEC PR_STU_NOT_ACTIVE


--4. Write a stored procedure to list faculty who teach more than one course in the same year. 
CREATE OR ALTER PROC PR_FAC_MULTI_COURSE_YEAR
AS
BEGIN
    SELECT 
        f.FacultyID,
        f.FacultyName,
        ca.Year,
        COUNT(ca.CourseID) AS CourseCount
    FROM FACULTY f
    JOIN COURSE_ASSIGNMENT ca ON f.FacultyID = ca.FacultyID
    GROUP BY f.FacultyID, f.FacultyName, ca.Year
    HAVING COUNT(ca.CourseID) > 1;
END;

EXEC PR_FAC_MULTI_COURSE_YEAR
--5. Create a stored procedure to find faculty who are not assigned any course in a given 
--year. 
CREATE OR ALTER PROC PR_FAC_NOT_ASSIGNED
    @Year INT
AS
BEGIN
    SELECT f.FacultyID, f.FacultyName
    FROM FACULTY f
    WHERE f.FacultyID NOT IN (
        SELECT FacultyID
        FROM COURSE_ASSIGNMENT
        WHERE Year = @Year
    );
END;

EXEC PR_FAC_NOT_ASSIGNED 2024
--6. Write a stored procedure to fetch top N students based on number of completed 
--courses. 
CREATE OR ALTER PROC PR_TOP_N_STUDENTS
    @N INT
AS
BEGIN
    SELECT TOP (@N)
        s.StuName,
        COUNT(e.CourseID) AS CompletedCourses
    FROM STUDENT s
    JOIN ENROLLMENT e ON s.StudentID = e.StudentID
    WHERE e.EnrollmentStatus = 'Completed'
    GROUP BY  s.StuName
    ORDER BY COUNT(e.CourseID) DESC;
END;

EXEC PR_TOP_N_STUDENTS 3

--7. Write a stored procedure that returns students with at least one Active and one 
--Completed course. 
CREATE OR ALTER PROC PR_STU_ACTIVE_COMPLETED
AS
BEGIN
    SELECT DISTINCT s.StudentID, s.StuName
    FROM STUDENT s
    WHERE 
        EXISTS (
            SELECT 1 FROM ENROLLMENT e
            WHERE e.StudentID = s.StudentID
            AND e.EnrollmentStatus = 'Active'
        )
        AND
        EXISTS (
            SELECT 1 FROM ENROLLMENT e
            WHERE e.StudentID = s.StudentID
            AND e.EnrollmentStatus = 'Completed'
        );
END;

EXEC PR_STU_ACTIVE_COMPLETED

--8. Write a stored procedure to return students whose age is below a given value. 
CREATE OR ALTER PROC PR_STU_AGE_BELOW
    @Age INT
AS
BEGIN
    SELECT 
        StudentID,
        StuName,
        DATEDIFF(YEAR, StuDateOfBirth, GETDATE()) AS Age
    FROM STUDENT
    WHERE DATEDIFF(YEAR, StuDateOfBirth, GETDATE()) < @Age;
END;

EXEC PR_STU_AGE_BELOW 25

--9. Create a stored procedure that returns courses never enrolled by any student. 
CREATE OR ALTER PROC PR_COURSE_NEVER_ENROLLED
AS
BEGIN
    SELECT c.CourseID, c.CourseName
    FROM COURSE c
    WHERE c.CourseID NOT IN (
        SELECT CourseID FROM ENROLLMENT
    );
END;

EXEC PR_COURSE_NEVER_ENROLLED

--10. Write a stored procedure to display students enrolled in the latest semester of their department. 
CREATE OR ALTER PROC PR_STU_LATEST_SEM_DEPT
AS
BEGIN
    SELECT DISTINCT s.StudentID, s.StuName, c.CourseSemester
    FROM STUDENT s
    JOIN ENROLLMENT e ON s.StudentID = e.StudentID
    JOIN COURSE c ON e.CourseID = c.CourseID
    WHERE c.CourseSemester = (
        SELECT MAX(c2.CourseSemester)
        FROM COURSE c2
        WHERE c2.CourseDepartment = s.StuDepartment
    );
END;

EXEC PR_STU_LATEST_SEM_DEPT 

--11. Create a stored procedure to fetch department-wise highest enrollment course. 

