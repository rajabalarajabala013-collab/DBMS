mysql> CREATE TABLE employee (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     salary INT
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> 
mysql> INSERT INTO employee VALUES
    -> (1, 'John', 5000),
    -> (2, 'Alice', 6000),
    -> (3, 'Bob', 4500);
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee;
+----+-------+--------+
| id | name  | salary |
+----+-------+--------+
|  1 | John  |   5000 |
|  2 | Alice |   6000 |
|  3 | Bob   |   4500 |
+----+-------+--------+
3 rows in set (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE SumProcedure(IN a INT, IN b INT)
    -> BEGIN
    ->     DECLARE c INT;
    -> 
    ->     SET c = a + b;
    -> 
    ->     SELECT CONCAT('Sum of two numbers = ', c) AS Result;
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL SumProcedure(10,20);
+-------------------------+
| Result                  |
+-------------------------+
| Sum of two numbers = 30 |
+-------------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE FUNCTION SumFunction(a INT, b INT)
    -> RETURNS INT
    -> DETERMINISTIC
    -> BEGIN
    ->     DECLARE c INT;
    -> 
    ->     SET c = a + b;
    -> 
    ->     RETURN c;
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> SELECT SumFunction(5,5) AS Result;
+--------+
| Result |
+--------+
|     10 |
+--------+
1 row in set (0.00 sec)

