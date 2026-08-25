mysql> use db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select* from customers;
+----+-------+-------------+---------+
| id | name  | address     | salary  |
+----+-------+-------------+---------+
|  1 | John  | New York    | 5500.00 |
|  2 | Alice | Los Angeles | 6500.00 |
|  3 | Bob   | Chicago     | 5000.00 |
|  4 | David | Houston     | 7500.00 |
|  5 | Emma  | Boston      | 6000.00 |
+----+-------+-------------+---------+
5 rows in set (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE GetCustomer()
    -> BEGIN
    ->     DECLARE c_id INT DEFAULT 5;
    ->     DECLARE c_name VARCHAR(100);
    ->     DECLARE c_addr VARCHAR(255);
    -> 
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND
    ->     BEGIN
    ->         SELECT 'No such customer!' AS Message;
    ->     END;
    -> 
    ->     DECLARE EXIT HANDLER FOR SQLEXCEPTION
    ->     BEGIN
    ->         SELECT 'Error!' AS Message;
    ->     END;
    -> 
    ->     SELECT name, address 
    ->     INTO c_name, c_addr
    ->     FROM customer
    ->     WHERE id = c_id;
    -> 
    ->     SELECT CONCAT('Name: ', c_name) AS Output;
    ->     SELECT CONCAT('Address: ', c_addr) AS Output;
    -> 
    -> END //
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> DELIMITER ;
mysql> 
mysql> CALL GetCustomer();
+---------+
| Message |
+---------+
| Error!  |
+---------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE CheckCustomer(IN cc_id INT)
    -> BEGIN
    ->     DECLARE c_name VARCHAR(100);
    ->     DECLARE c_addr VARCHAR(255);
    -> 
    ->     DECLARE invalid_id CONDITION FOR SQLSTATE '45000';
    -> 
    ->     DECLARE EXIT HANDLER FOR NOT FOUND
    ->     BEGIN
    ->         SELECT 'No such customer!' AS Message;
    ->     END;
    -> 
    ->     DECLARE EXIT HANDLER FOR SQLEXCEPTION
    ->     BEGIN
    ->         SELECT 'Error!' AS Message;
    ->     END;
    -> 
    ->     IF cc_id <= 0 THEN
    ->         SIGNAL invalid_id
    ->         SET MESSAGE_TEXT = 'ID must be greater than zero!';
    ->     ELSE
    -> 
    ->         SELECT name, address
    ->         INTO c_name, c_addr
    ->         FROM customers
    ->         WHERE id = cc_id;
    -> 
    ->         SELECT CONCAT('Name: ', c_name) AS Output;
    ->         SELECT CONCAT('Address: ', c_addr) AS Output;
    -> 
    ->     END IF;
    -> 
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> 
mysql> CALL CheckCustomer(5);
+------------+
| Output     |
+------------+
| Name: Emma |
+------------+
1 row in set (0.00 sec)

+-----------------+
| Output          |
+-----------------+
| Address: Boston |
+-----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> CALL CheckCustomer(5);
+------------+
| Output     |
+------------+
| Name: Emma |
+------------+
1 row in set (0.00 sec)

+-----------------+
| Output          |
+-----------------+
| Address: Boston |
+-----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


mysql> CALL GetCustomer();
+---------+
| Message |
+---------+
| Error!  |
+---------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)

