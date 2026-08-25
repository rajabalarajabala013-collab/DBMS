-- Table Creation
CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(30), Age INT);
CREATE TABLE Courses (CourseID INT PRIMARY KEY, CourseName VARCHAR(20));
CREATE TABLE Enrollments (
    StudentID INT REFERENCES Student(StudentID),
    CourseID INT REFERENCES Courses(CourseID)
);

-- Insert values
INSERT INTO Students VALUES (1, 'Alice', 20);
INSERT INTO Students VALUES (2, 'Bob', 22);
INSERT INTO Students VALUES (3, 'Charlie', 21);
INSERT INTO Students VALUES (4, 'David', 19);

INSERT INTO Courses VALUES (101, 'Database Management');
INSERT INTO Courses VALUES (102, 'Algorithms');
INSERT INTO Courses VALUES (103, 'Web Development');

INSERT INTO Enrollments VALUES (1, 101);
INSERT INTO Enrollments VALUES (1, 102);
INSERT INTO Enrollments VALUES (2, 102);
INSERT INTO Enrollments VALUES (3, 101);
INSERT INTO Enrollments VALUES (3, 103);
INSERT INTO Enrollments VALUES (4, 103);

-- Simple Queries
-- Retrieve all students
SELECT * FROM Students;

-- Retrieve names and ages of students older than 20
SELECT Name, Age FROM Students WHERE Age > 20;

-- Nested Query
-- Names of students enrolled in the course 'Database Management'
SELECT Name FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments
    WHERE CourseID = (
        SELECT CourseID FROM Courses
        WHERE CourseName = 'Database Management'
    )
);

-- Subqueries
-- Average age of students
SELECT AVG(Age) AS AverageAge FROM Students;

-- Courses with more than one student enrolled
SELECT CourseID, CourseName FROM Courses
WHERE CourseID IN (
    SELECT CourseID FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(*) > 1
);

-- Students whose age is greater than the average age of all students
SELECT Name, Age FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);
