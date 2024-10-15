--  CREATING TABLES 


-- Students table
CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT, 
	email TEXT UNIQUE, 
	enrollment_date TEXT
);

-- Professors table
CREATE TABLE professors (
professor_id SERIAL PRIMARY KEY,
first_name TEXT,
last_name TEXT,
department TEXT
);

-- Courses table
CREATE TABLE courses (
course_id SERIAL PRIMARY KEY,
course_name TEXT,
course_description TEXT,
professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- Enrollments table
CREATE TABLE enrollments (
student_id INT,
course_id INT,
enrollment_date DATE,
	PRIMARY KEY (student_id, course_id),
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


-- INSERT DATA INTO TABLES 

--Insert student information into students table
INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('Amanda', 'Halley', 'amanda.halley@example.com', '2024-09,05'),
('John', 'Doe', 'john.doe@example.com', '2024-09,05'),
('Chris', 'Stamp', 'chirsstamp@example.com', '2024-09,05'),
('Jane', 'Dawe', 'jane.dawe@example.com', '2024-09,05'),
('Sally', 'Bishop', 'sally.bishop@example.com', '2024-09,05');

--Insert professor information into professors table
INSERT INTO professors (first_name, last_name, department) VALUES
('Carson', 'Thorne', 'Physics'),
('Brianna', 'Bishop', 'Biology'),
('Kian', 'Lee', 'Math'),
('Becca', 'Kavanagh', 'Chemistry')


-- Insert course information into course table
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to Physics', '1'),
('Biology 201', 'Advanced Biology', '2'),
('Math 301', 'Advanced Math', '3')

-- inserts enrollments into enrollments table 
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
('1', '1', '2024-01-01'), -- Amanda enrolled in Physics 101
('1', '2', '2024-01-01'), -- Amanda enrolled in Biology 201
('2', '3', '2024-01-01'), -- John enrolled in Math 301
('3', '2', '2024-01-01'), -- Chris enrolled in Biology 201
('4', '1', '2024-01-01') -- Jane enrolled in Physics 101


-- TASKS

-- Retrieving full names of students enrolled in physics 101 (first and last name in one column)
SELECT students.first_name || ' ' || students.last_name AS full_name
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE courses.course_id = '1'

--Retrieve a list of all courses along with the professor’s full name who teaches each course.
SELECT courses.course_name, professors.first_name || ' ' || professors.last_name AS professor_full_name
FROM courses
JOIN professors ON professors.professor_id = courses.professor_id

-- Retrieve all courses that have students enrolled in them
SELECT courses.course_name AS enrolled_courses
FROM courses
JOIN students ON students.student_id = courses.course_id

-- Update student email
UPDATE students 
SET email = 'updated@example.com'
WHERE student_id = 2 -- updates john doe's email

-- Remove a student from one of their courses
DELETE FROM enrollments 
WHERE student_id = 1 AND course_id = 1 -- removed amanda from physics 101






