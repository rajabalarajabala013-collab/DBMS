mysql> use db;
Database changed
mysql> CREATE TABLE Student (StudentID INT, Name VARCHAR(30), Age INT);
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE Courses (CourseID INT, CourseName VARCHAR(20));
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE Enrollments (
    ->     EnrollmentID INT,
    ->     StudentID INT,
    ->     CourseID INT,
    ->     Grade VARCHAR(5)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> INSERT INTO Student VALUES (1, 'Alice', 20);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Student VALUES (2, 'Bob', 22);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Student VALUES (3, 'Charlie', 21);
Query OK, 1 row affected (0.02 sec)

mysql> 
mysql> INSERT INTO Courses VALUES (1, 'Math');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Courses VALUES (2, 'English');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Courses VALUES (3, 'History');
Query OK, 1 row affected (0.02 sec)

mysql> 
mysql> INSERT INTO Enrollments VALUES (1, 1, 1, 'A');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Enrollments VALUES (2, 1, 2, 'B');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Enrollments VALUES (3, 2, 1, 'A-');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Enrollments VALUES (4, 3, 3, 'B+');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Enrollments VALUES (5, 3, 2, 'A');
Query OK, 1 row affected (0.02 sec)

mysql> SELECT Student.StudentID, Student.Name, Student.Age,
    ->        Courses.CourseID, Courses.CourseName, Enrollments.Grade
    -> FROM Student
    -> INNER JOIN Enrollments ON Student.StudentID = Enrollments.StudentID
    -> INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID;
+-----------+---------+------+----------+------------+-------+
| StudentID | Name    | Age  | CourseID | CourseName | Grade |
+-----------+---------+------+----------+------------+-------+
|         2 | Bob     |   22 |        1 | Math       | A-    |
|         1 | Alice   |   20 |        1 | Math       | A     |
|         3 | Charlie |   21 |        2 | English    | A     |
|         1 | Alice   |   20 |        2 | English    | B     |
|         3 | Charlie |   21 |        3 | History    | B+    |
+-----------+---------+------+----------+------------+-------+
5 rows in set (0.00 sec)

mysql> SELECT Student.StudentID, Student.Name, Student.Age,
    ->        Courses.CourseID, Courses.CourseName, Enrollments.Grade
    -> FROM Student
    -> LEFT JOIN Enrollments ON Student.StudentID = Enrollments.StudentID
    -> LEFT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;
+-----------+---------+------+----------+------------+-------+
| StudentID | Name    | Age  | CourseID | CourseName | Grade |
+-----------+---------+------+----------+------------+-------+
|         1 | Alice   |   20 |        2 | English    | B     |
|         1 | Alice   |   20 |        1 | Math       | A     |
|         2 | Bob     |   22 |        1 | Math       | A-    |
|         3 | Charlie |   21 |        2 | English    | A     |
|         3 | Charlie |   21 |        3 | History    | B+    |
+-----------+---------+------+----------+------------+-------+
5 rows in set (0.00 sec)

mysql> SELECT Student.StudentID, Student.Name, Student.Age,
    ->        Courses.CourseID, Courses.CourseName, Enrollments.Grade
    -> FROM Courses
    -> RIGHT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
    -> RIGHT JOIN Student ON Enrollments.StudentID = Student.StudentID;
+-----------+---------+------+----------+------------+-------+
| StudentID | Name    | Age  | CourseID | CourseName | Grade |
+-----------+---------+------+----------+------------+-------+
|         1 | Alice   |   20 |        2 | English    | B     |
|         1 | Alice   |   20 |        1 | Math       | A     |
|         2 | Bob     |   22 |        1 | Math       | A-    |
|         3 | Charlie |   21 |        2 | English    | A     |
|         3 | Charlie |   21 |        3 | History    | B+    |
+-----------+---------+------+----------+------------+-------+
5 rows in set (0.01 sec)

mysql> 


