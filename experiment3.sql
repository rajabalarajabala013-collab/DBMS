-- Create table and insert sample data
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    student_email VARCHAR(100)
);

INSERT INTO students (student_name, student_email) VALUES ('Alice Johnson', 'alice@example.com');
INSERT INTO students (student_name, student_email) VALUES ('Bob Smith', 'bob@example.com');
INSERT INTO students (student_name, student_email) VALUES ('Charlie Brown', 'charlie@example.com');

-- Create a view
CREATE VIEW student_view AS
SELECT student_id, student_name, student_email FROM students;

-- DML operations
INSERT INTO students (student_name, student_email) VALUES ('Diana Prince', 'diana@example.com');

UPDATE students SET student_email = 'new_bob@example.com' WHERE student_name = 'Bob Smith';

DELETE FROM students WHERE student_name = 'Charlie Brown';

-- Verify changes through the view
SELECT * FROM student_view;

-- Create an index
CREATE INDEX idx_student_email ON students (student_email);