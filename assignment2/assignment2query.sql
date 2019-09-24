/* 의대생들의 이름 */
SELECT name
FROM student
WHERE student.dept_name = 'PMED';

/* 경영학과 학생들중 Kerpitan Lee 교수가 지도교수인 학생 */
SELECT student.ID, student.name, student.dept_name, student.tot_cred
FROM student, advisor, instructor
WHERE (student.ID = advisor.s_id) AND (advisor.i_id = instructor.ID) AND (instructor.name = 'Kerpitan Lee');

/* 총 학점이 60 이상인 모든 학생 */
SELECT *
FROM student
WHERE student.tot_cred >= 60; 

/* 강의들의 이름과 그 담당 교수의 이름 */
SELECT title, name
FROM (course NATURAL JOIN teaches) NATURAL JOIN instructor;

/* 학생들이 들은 수업의 이름과 학점 */
SELECT student.ID, name, title, grade
FROM (student NATURAL JOIN takes) NATURAL JOIN course;

/* 총 학점이 90 이상인 컴퓨터학과 학생 */
SELECT *
FROM student
WHERE student.tot_cred >= 90 AND student.dept_name = 'COSE';

/* Gambia Kim 교수가 진행하는 수업에서 학생들에게 준 점수 */
SELECT takes.ID, grade
FROM (instructor NATURAL JOIN teaches) JOIN (section NATURAL JOIN takes) USING (course_id, sec_id, semester, year)
WHERE instructor.name = 'Gambia Kim';

/* 2019년 2학기의 COSE371-01(데이터베이스)를 들은 학생의 이름과 학점 */
SELECT student.name, grade
FROM student NATURAL JOIN takes
WHERE takes.year = 2019 AND takes.semester = '2nd' AND takes.course_id = 'COSE371' AND takes.sec_id = '01';

/* 애기능생활관 301호에서 강의하는 수업들의 이름 */
SELECT title
FROM section NATURAL JOIN course
WHERE section.building = '애기능생활관' AND room_no = '301';

/* 자신의 지도교수가 수업하는 강의를 듣는 학생의 이름과 학점, 그 수업의 학수번호 */
SELECT takes.course_id, student.name, grade
FROM student, advisor, (teaches JOIN takes USING (course_id, sec_id, semester, year))
WHERE  student.ID = advisor.s_id AND teaches.ID = advisor.i_id AND takes.ID = student.ID;
