mysql> CREATE TABLE customers (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     address VARCHAR(100),
    ->     salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> INSERT INTO customers (id, name, address, salary) VALUES
    -> (1, 'John', 'New York', 5000.00),
    -> (2, 'Alice', 'Los Angeles', 6000.00),
    -> (3, 'Bob', 'Chicago', 4500.00),
    -> (4, 'David', 'Houston', 7000.00),
    -> (5, 'Emma', 'Boston', 5500.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM customers;
+----+-------+-------------+---------+
| id | name  | address     | salary  |
+----+-------+-------------+---------+
|  1 | John  | New York    | 5000.00 |
|  2 | Alice | Los Angeles | 6000.00 |
|  3 | Bob   | Chicago     | 4500.00 |
|  4 | David | Houston     | 7000.00 |
|  5 | Emma  | Boston      | 5500.00 |
+----+-------+-------------+---------+
5 rows in set (0.00 sec)

**************IMPLICIT CURSOR (MYSQL)**************

mysql> UPDATE customers
    -> SET salary = salary + 500;
Query OK, 5 rows affected (0.01 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> 
mysql> SELECT ROW_COUNT() AS rows_updated;
+--------------+
| rows_updated |
+--------------+
|            5 |
+--------------+
1 row in set (0.00 sec)

**************EXPLICIT CURSOR (MYSQL)**************

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE p()
    -> BEGIN
    ->     DECLARE done INT DEFAULT FALSE;
    ->     DECLARE c_id INT;
    ->     DECLARE c_name VARCHAR(50);
    ->     DECLARE c_salary DECIMAL(10,2);
    -> 
    ->     DECLARE cur CURSOR FOR
    ->         SELECT id, name, salary FROM customers;
    -> 
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND
    ->         SET done = TRUE;
    -> 
    ->     OPEN cur;
    -> 
    ->     read_loop: LOOP
    ->         FETCH cur INTO c_id, c_name, c_salary;
    -> 
    ->         IF done THEN
    ->             LEAVE read_loop;
    ->         END IF;
    -> 
    ->         SELECT c_id AS ID, 
    ->                c_name AS Name, 
    ->                c_salary AS Salary;
    ->     END LOOP;
    -> 
    ->     CLOSE cur;
    -> 
    -> END//
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL p();
+------+------+---------+
| ID   | Name | Salary  |
+------+------+---------+
|    1 | John | 5500.00 |
+------+------+---------+
1 row in set (0.00 sec)

+------+-------+---------+
| ID   | Name  | Salary  |
+------+-------+---------+
|    2 | Alice | 6500.00 |
+------+-------+---------+
1 row in set (0.00 sec)

+------+------+---------+
| ID   | Name | Salary  |
+------+------+---------+
|    3 | Bob  | 5000.00 |
+------+------+---------+
1 row in set (0.00 sec)

+------+-------+---------+
| ID   | Name  | Salary  |
+------+-------+---------+
|    4 | David | 7500.00 |
+------+-------+---------+
1 row in set (0.00 sec)

+------+------+---------+
| ID   | Name | Salary  |
+------+------+---------+
|    5 | Emma | 6000.00 |
+------+------+---------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


