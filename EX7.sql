mysql> CREATE TABLE Authors (
    ->     AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> CREATE TABLE Books (
    ->     BookID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Title VARCHAR(100),
    ->     Genre VARCHAR(50),
    ->     PublicationYear INT
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE BookAuthors (
    ->     BookID INT,
    ->     AuthorID INT,
    ->     PRIMARY KEY (BookID, AuthorID),
    ->     FOREIGN KEY (BookID) REFERENCES Books(BookID),
    ->     FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -> );
Query OK, 0 rows affected (0.12 sec)

mysql> CREATE TABLE Borrowers (
    ->     BorrowerID INT PRIMARY KEY AUTO_INCREMENT,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50),
    ->     MembershipDate DATE
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> CREATE TABLE BorrowedBooks (
    ->     BorrowerID INT,
    ->     BookID INT,
    ->     BorrowedDate DATE,
    ->     ReturnDate DATE,
    ->     PRIMARY KEY (BorrowerID, BookID),
    ->     FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID),
    ->     FOREIGN KEY (BookID) REFERENCES Books(BookID)
    -> );
Query OK, 0 rows affected (0.14 sec)

mysql> INSERT INTO Authors (FirstName, LastName) VALUES ('George', 'Orwell');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Authors (FirstName, LastName) VALUES ('Aldous', 'Huxley');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Authors (FirstName, LastName) VALUES ('J.K.', 'Rowling');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Books (Title, Genre, PublicationYear) VALUES ('1984', 'Dystopian', 1949);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Books (Title, Genre, PublicationYear) VALUES ('Brave New World', 'Dystopian', 1932);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Books (Title, Genre, PublicationYear) VALUES ('Harry Potter and the Sorcerer''s Stone', 'Fantasy', 1997);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO BookAuthors (BookID, AuthorID) VALUES (1, 1);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO BookAuthors (BookID, AuthorID) VALUES (2, 2);
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO BookAuthors (BookID, AuthorID) VALUES (3, 3);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Borrowers (FirstName, LastName, MembershipDate) VALUES ('John', 'Doe', '2023-01-01');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Borrowers (FirstName, LastName, MembershipDate) VALUES ('Jane', 'Smith', '2023-02-15');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO BorrowedBooks (BorrowerID, BookID, BorrowedDate, ReturnDate)
    -> VALUES (1, 1, '2023-03-01', '2023-03-15');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO BorrowedBooks (BorrowerID, BookID, BorrowedDate, ReturnDate)
    -> VALUES (2, 3, '2023-03-05', '2023-03-20');
Query OK, 1 row affected (0.02 sec)

mysql> SELECT 
    ->     B.Title AS BookName,
    ->     CONCAT(A.FirstName, ' ', A.LastName) AS AuthorName,
    ->     CONCAT(BR.FirstName, ' ', BR.LastName) AS BorrowerName,
    ->     BB.BorrowedDate,
    ->     BB.ReturnDate
    -> FROM Books B
    -> JOIN BookAuthors BA 
    ->     ON B.BookID = BA.BookID
    -> JOIN Authors A 
    ->     ON BA.AuthorID = A.AuthorID
    -> LEFT JOIN BorrowedBooks BB 
    ->     ON B.BookID = BB.BookID
    -> LEFT JOIN Borrowers BR 
    ->     ON BB.BorrowerID = BR.BorrowerID;
+---------------------------------------+---------------+--------------+--------------+------------+
| BookName                              | AuthorName    | BorrowerName | BorrowedDate | ReturnDate |
+---------------------------------------+---------------+--------------+--------------+------------+
| 1984                                  | George Orwell | John Doe     | 2023-03-01   | 2023-03-15 |
| Brave New World                       | Aldous Huxley | NULL         | NULL         | NULL       |
| Harry Potter and the Sorcerer's Stone | J.K. Rowling  | Jane Smith   | 2023-03-05   | 2023-03-20 |
+---------------------------------------+---------------+--------------+--------------+------------+
3 rows in set (0.00 sec)
