CREATE DATABASE mycourse;

USE mycourse;

CREATE TABLE IF NOT EXISTS students (
id INT(50) PRIMARY KEY,
NAME VARCHAR(100),
age INT(50),
gender VARCHAR(50)
);

INSERT INTO students VALUE
(111, 'Dhea Rahma Dianti', 20, 'female'),
(112, 'Aditya Kusumaputri', 20, 'female'),
(113, 'Edith Firjatullah', 19, 'male'),
(114, 'Cindy Permatasari', 19, 'female'),
(115, 'Devi Dwi Novitasari', 19, 'female'),
(116, 'Ardiansyah Gofur', 19, 'male'),
(117, 'Revalina Kawindra', 19, 'female');

CREATE TABLE IF NOT EXISTS course (
id INT(50) PRIMARY KEY,
course_name VARCHAR(100),
credits INT(50)
);

DROP TABLE course;

INSERT INTO course VALUE
(4211, 'Data Mining', 3),
(4212, 'Basis Data', 3),
(4213, 'Design UI/UX', 2),
(4214, 'Android', 4),
(4215, 'Java', 4),
(4216, 'Python', 3),
(4217, 'System Architecture', 3);

CREATE TABLE IF NOT EXISTS student_course (
student_id INT(50),
course_id INT(50),
grade VARCHAR(50),
FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (course_id) REFERENCES course(id)
);

INSERT INTO student_course VALUES
(111, 4213, 'A'),
(112, 4211, 'A'),
(113, 4212, 'B'),
(114, 4215, 'A'),
(115, 4214, 'B'),
(116, 4217, 'B'),
(117, 4216, 'A');

DROP TABLE student_course;

DELIMITER //
CREATE PROCEDURE totalCredit(
	IN idStudent INT(50),
	OUT jmlCredits INT(50)
)
BEGIN
	SELECT COUNT(credits) INTO jmlCredits FROM students a JOIN student_course b ON a.id =b.student_id 
	JOIN course c ON b.course_id = c.id WHERE idStudent = a.id;
	
END //
DELIMITER;

SET @jumlahStok = 10;
CALL totalCredit(111,@jmlCredits);
SELECT @jmlCredits AS 'Jumlah credit setelah di perbarui';
DROP PROCEDURE totalCredit;

SET totalcredit COUNT(*);
	UPDATE buku SET credits