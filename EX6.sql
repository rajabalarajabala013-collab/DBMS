mysql> DELIMITER ;
mysql> CREATE TABLE customer_update_log (
    ->     sid INT,
    ->     old_total INT,
    ->     new_total INT,
    ->     action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE TRIGGER up_classd
    -> BEFORE UPDATE ON customer
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO customer_update_log(sid, old_total, new_total)
    ->     VALUES(OLD.sid, OLD.stotal, NEW.stotal);
    -> END//
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> DELIMITER ;
mysql> UPDATE customer
    -> SET stotal = 1000
    -> WHERE sid = 3;
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM customer_update_log;
+------+-----------+-----------+---------------------+
| sid  | old_total | new_total | action_time         |
+------+-----------+-----------+---------------------+
|    3 |       900 |      1000 | 2026-07-30 11:32:16 |
+------+-----------+-----------+---------------------+
1 row in set (0.00 sec)

mysql> CREATE TABLE customer_delete_log (
    ->     sid INT,
    ->     sname VARCHAR(50),
    ->     stotal INT,
    ->     action VARCHAR(20),
    ->     action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.14 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE TRIGGER del_classb
    -> BEFORE DELETE ON customer
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO customer_delete_log
    ->     VALUES (
    ->         OLD.sid,
    ->         OLD.sname,
    ->         OLD.stotal,
    ->         'DELETED',
    ->         NOW()
    ->     );
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> DELETE FROM customer
    -> WHERE sid = 1;
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM customer_delete_log;
+------+-------+--------+---------+---------------------+
| sid  | sname | stotal | action  | action_time         |
+------+-------+--------+---------+---------------------+
|    1 | John  |    500 | DELETED | 2026-07-30 11:33:55 |
+------+-------+--------+---------+---------------------+
1 row in set (0.00 sec)

mysql> CREATE TABLE classb (
    ->     sid INT PRIMARY KEY,
    ->     sname VARCHAR(50),
    ->     sdept VARCHAR(20),
    ->     stotal INT,
    ->     grade CHAR(1)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> DELIMITER //
mysql> 
mysql> CREATE TRIGGER ins_classb
    -> BEFORE INSERT ON classb
    -> FOR EACH ROW
    -> BEGIN
    ->     IF NEW.stotal > 1000 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'Total not valid';
    ->     END IF;
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DELIMITER ;
mysql> INSERT INTO classb VALUES
    -> (1, 'John', 'IT', 900, 'A');
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM classb;
+-----+-------+-------+--------+-------+
| sid | sname | sdept | stotal | grade |
+-----+-------+-------+--------+-------+
|   1 | John  | IT    |    900 | A     |
+-----+-------+-------+--------+-------+
1 row in set (0.00 sec)

mysql> INSERT INTO classb VALUES
    -> (2, 'Jana', 'IT', 20000, 'A');
ERROR 1644 (45000): Total not valid

