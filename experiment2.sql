-- Table Creation
CREATE TABLE Student (StudentID INT, Name VARCHAR(30), Age INT);
CREATE TABLE Courses (CourseID INT, CourseName VARCHAR(20));
CREATE TABLE Enrollments (
    EnrollmentID INT,
    StudentID INT,
    CourseID INT,
    Grade VARCHAR(5)
);

-- Insert values
INSERT INTO Student VALUES (1, 'Alice', 20);
INSERT INTO Student VALUES (2, 'Bob', 22);
INSERT INTO Student VALUES (3, 'Charlie', 21);

INSERT INTO Courses VALUES (1, 'Math');
INSERT INTO Courses VALUES (2, 'English');
INSERT INTO Courses VALUES (3, 'History');

INSERT INTO Enrollments VALUES (1, 1, 1, 'A');
INSERT INTO Enrollments VALUES (2, 1, 2, 'B');
INSERT INTO Enrollments VALUES (3, 2, 1, 'A-');
INSERT INTO Enrollments VALUES (4, 3, 3, 'B+');
INSERT INTO Enrollments VALUES (5, 3, 2, 'A');

-- INNER JOIN: Student's enrollments with course details
SELECT Students.StudentID, Students.Name, Students.Age,
       Courses.CourseID, Courses.CourseName, Enrollments.Grade
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- LEFT JOIN: All students and their enrollments (including students with none)
SELECT Students.StudentID, Students.Name, Students.Age,
       Courses.CourseID, Courses.CourseName, Enrollments.Grade
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
LEFT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- RIGHT JOIN: All courses/enrollments (including courses with none)
SELECT Students.StudentID, Students.Name, Students.Age,
       Courses.CourseID, Courses.CourseName, Enrollments.Grade
FROM Courses
RIGHT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
RIGHT JOIN Students ON Enrollments.StudentID = Students.StudentID;