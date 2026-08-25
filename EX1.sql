mysql> use db;
Database changed
mysql> CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(30), Age INT);
Query OK, 0 rows affected (0.11 sec)

mysql> CREATE TABLE Courses (CourseID INT PRIMARY KEY, CourseName VARCHAR(20));
Query OK, 0 rows affected (0.10 sec)

mysql> CREATE TABLE Enrollments (
    ->     StudentID INT REFERENCES Student(StudentID),
    ->     CourseID INT REFERENCES Courses(CourseID)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> INSERT INTO Students VALUES (1, 'Alice', 20);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Students VALUES (2, 'Bob', 22);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Students VALUES (3, 'Charlie', 21);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Students VALUES (4, 'David', 19);
Query OK, 1 row affected (0.02 sec)

mysql> 
mysql> INSERT INTO Courses VALUES (101, 'Database Management');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Courses VALUES (102, 'Algorithms');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Courses VALUES (103, 'Web Development');
Query OK, 1 row affected (0.01 sec)

mysql> 
mysql> INSERT INTO Enrollments VALUES (1, 101);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Enrollments VALUES (1, 102);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Enrollments VALUES (2, 102);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Enrollments VALUES (3, 101);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Enrollments VALUES (3, 103);
Query OK, 1 row affected (0.03 sec)

mysql> INSERT INTO Enrollments VALUES (4, 103);
Query OK, 1 row affected (0.01 sec)

mysql> Select *from Students;
+-----------+---------+------+
| StudentID | Name    | Age  |
+-----------+---------+------+
|         1 | Alice   |   20 |
|         2 | Bob     |   22 |
|         3 | Charlie |   21 |
|         4 | David   |   19 |
+-----------+---------+------+
4 rows in set (0.00 sec)

mysql> Select *from Courses;
+----------+---------------------+
| CourseID | CourseName          |
+----------+---------------------+
|      101 | Database Management |
|      102 | Algorithms          |
|      103 | Web Development     |
+----------+---------------------+
3 rows in set (0.00 sec)

mysql> Select *from Enrollments;
+-----------+----------+
| StudentID | CourseID |
+-----------+----------+
|         1 |      101 |
|         1 |      102 |
|         2 |      102 |
|         3 |      101 |
|         3 |      103 |
|         4 |      103 |
+-----------+----------+
6 rows in set (0.00 sec)

mysql> SELECT Name, Age FROM Students WHERE Age > 20;
+---------+------+
| Name    | Age  |
+---------+------+
| Bob     |   22 |
| Charlie |   21 |
+---------+------+
2 rows in set (0.00 sec)

mysql> SELECT Name FROM Students
    -> WHERE StudentID IN (
    ->     SELECT StudentID FROM Enrollments
    ->     WHERE CourseID = (
    ->         SELECT CourseID FROM Courses
    ->         WHERE CourseName = 'Database Management'
    ->     )
    -> );
+---------+
| Name    |
+---------+
| Alice   |
| Charlie |
+---------+
2 rows in set (0.00 sec)

mysql> SELECT AVG(Age) AS AverageAge FROM Students;
+------------+
| AverageAge |
+------------+
|    20.5000 |
+------------+
1 row in set (0.00 sec)

mysql> SELECT CourseID, CourseName FROM Courses
    -> WHERE CourseID IN (
    ->     SELECT CourseID FROM Enrollments
    ->     GROUP BY CourseID
    ->     HAVING COUNT(*) > 1
    -> );
+----------+---------------------+
| CourseID | CourseName          |
+----------+---------------------+
|      101 | Database Management |
|      102 | Algorithms          |
|      103 | Web Development     |
+----------+---------------------+
3 rows in set (0.00 sec)

mysql> SELECT Name, Age FROM Students
    -> WHERE Age > (SELECT AVG(Age) FROM Students);
+---------+------+
| Name    | Age  |
+---------+------+
| Bob     |   22 |
| Charlie |   21 |
+---------+------+
2 rows in set (0.00 sec)
