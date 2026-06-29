CREATE TABLE Students (
    StudentID NUMBER PRIMARY KEY,
    FullName VARCHAR2(100),
    Gender VARCHAR2(10),
    Department VARCHAR2(50)
);
CREATE TABLE Courses (
    CourseID NUMBER PRIMARY KEY,
    CourseName VARCHAR2(100),
    Credits NUMBER
);
CREATE TABLE Enrollments (
    EnrollmentID NUMBER PRIMARY KEY,
    StudentID NUMBER,
    CourseID NUMBER,
    Marks NUMBER,

    CONSTRAINT fk_student
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    CONSTRAINT fk_course
        FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);
INSERT ALL
INTO Students VALUES (1,'John Doe','Male','Computer Science')
INTO Students VALUES (2,'Alice Smith','Female','Information Technology')
INTO Students VALUES (3,'David King','Male','Computer Science')
INTO Students VALUES (4,'Grace Lee','Female','Business')
INTO Students VALUES (5,'Peter James','Male','Business')
SELECT * FROM dual;
INSERT ALL
INTO Courses VALUES (101,'Database Programming',3)
INTO Courses VALUES (102,'Java Programming',4)
INTO Courses VALUES (103,'Networking',3)
SELECT * FROM dual;
INSERT ALL
INTO Enrollments VALUES (1,1,101,80)
INTO Enrollments VALUES (2,1,102,75)
INTO Enrollments VALUES (3,2,101,90)
INTO Enrollments VALUES (4,2,103,85)
INTO Enrollments VALUES (5,3,101,70)
INTO Enrollments VALUES (6,3,102,65)
INTO Enrollments VALUES (7,4,103,95)
INTO Enrollments VALUES (8,5,102,60)
SELECT * FROM dual;
COMMIT;
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;

WITH StudentMarks AS
(
    SELECT StudentID, Marks
    FROM Enrollments
)
SELECT *
FROM StudentMarks;

WITH StudentList AS
(
    SELECT StudentID, FullName
    FROM Students
),
StudentScores AS
(
    SELECT StudentID, Marks
    FROM Enrollments
)
SELECT
    StudentList.FullName,
    StudentScores.Marks
FROM StudentList
JOIN StudentScores
ON StudentList.StudentID = StudentScores.StudentID;
WITH Numbers (Num) AS
(
    SELECT 1 FROM dual
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 5
)
SEARCH DEPTH FIRST BY Num SET order_col
SELECT Num
FROM Numbers;

WITH AverageMarks AS
(
    SELECT StudentID,
           AVG(Marks) AS AverageMark
    FROM Enrollments
    GROUP BY StudentID
)
SELECT *
FROM AverageMarks;

WITH StudentCourse AS
(
    SELECT
        s.FullName,
        c.CourseName,
        e.Marks
    FROM Students s
    JOIN Enrollments e
        ON s.StudentID = e.StudentID
    JOIN Courses c
        ON c.CourseID = e.CourseID
)
SELECT *
FROM StudentCourse;

SELECT
    StudentID,
    Marks,
    ROW_NUMBER() OVER(ORDER BY Marks DESC) AS Row_Number
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    RANK() OVER(ORDER BY Marks DESC) AS Rank_Number
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    DENSE_RANK() OVER(ORDER BY Marks DESC) AS Dense_Rank
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    PERCENT_RANK() OVER(ORDER BY Marks) AS Percent_Rank
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    SUM(Marks) OVER() AS Total_Marks
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    AVG(Marks) OVER() AS Average_Marks
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    MIN(Marks) OVER() AS Lowest_Mark
FROM Enrollments;

SELECT
    StudentID,
    Marks,
    MAX(Marks) OVER() AS Highest_Mark
FROM Enrollments;
-- LAG()
SELECT
    StudentID,
    Marks,
    LAG(Marks) OVER(ORDER BY Marks) AS Previous_Mark
FROM Enrollments;
-- LEAD()
SELECT
    StudentID,
    Marks,
    LEAD(Marks) OVER(ORDER BY Marks) AS Next_Mark
FROM Enrollments;
-- NTILE()
SELECT
    StudentID,
    Marks,
    NTILE(4) OVER(ORDER BY Marks) AS Quartile
FROM Enrollments;
-- CUME_DIST()
SELECT
    StudentID,
    Marks,
    CUME_DIST() OVER(ORDER BY Marks) AS Cumulative_Distribution
FROM Enrollments;