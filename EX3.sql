mysql> CREATE TABLE students (
    ->     student_id SERIAL PRIMARY KEY,
    ->     student_name VARCHAR(100),
    ->     student_email VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.12 sec)

mysql> INSERT INTO students (student_name, student_email) VALUES ('Alice Johnson', 'alice@example.com');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO students (student_name, student_email) VALUES ('Bob Smith', 'bob@example.com');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO students (student_name, student_email) VALUES ('Charlie Brown', 'charlie@example.com');
Query OK, 1 row affected (0.02 sec)

mysql> CREATE VIEW student_view AS
    -> SELECT student_id, student_name, student_email FROM students;
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO students (student_name, student_email) VALUES ('Diana Prince', 'diana@example.com');
Query OK, 1 row affected (0.02 sec)

mysql> 
mysql> UPDATE students SET student_email = 'new_bob@example.com' WHERE student_name = 'Bob Smith';
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> 
mysql> DELETE FROM students WHERE student_name = 'Charlie Brown';
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM student_view;
+------------+---------------+---------------------+
| student_id | student_name  | student_email       |
+------------+---------------+---------------------+
|          1 | Alice Johnson | alice@example.com   |
|          2 | Bob Smith     | new_bob@example.com |
|          4 | Diana Prince  | diana@example.com   |
+------------+---------------+---------------------+
3 rows in set (0.00 sec)

mysql> CREATE INDEX idx_student_email ON students (student_email);
Query OK, 0 rows affected (0.11 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW INDEX FROM students;
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name          | Seq_in_index | Column_name   | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| students |          0 | PRIMARY           |            1 | student_id    | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          0 | student_id        |            1 | student_id    | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_student_email |            1 | student_email | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.03 sec)

