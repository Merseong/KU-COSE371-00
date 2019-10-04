-- Excercise 1
-- a. Find the titles of courses in the Comp. Sci. department that have 3 credits
SELECT title
FROM course
WHERE dept_name = 'Comp. Sci.' AND credits = 3;

-- b. Find the IDs of all students who were taught by an instructor named Einstein; make sure there are no duplicates in the result
SELECT DISTINCT takes.ID
FROM takes JOIN teaches USING (course_id,sec_id, semester, year)
WHERE teaches.ID = (
    SELECT ID 
    FROM instructor 
    WHERE instructor.name = 'Einstein'
    );

-- c. Find the highest salary of any instructor
SELECT MAX (salary) AS highest_salary
FROM instructor;

-- d. Find all instructors earning the highest salary (there may be more than one with the same salary)
SELECT *
FROM instructor
WHERE salary = (
    SELECT MAX (salary) 
    FROM instructor
    );

-- e. Find the enrollment for each section that was offered in Fall 2009
SELECT COUNT (ID) AS enrollment
FROM takes
WHERE semester = 'Fall' AND year = 2009
GROUP BY course_id, sec_id;

-- f. Find the maximum enrollment, across all sections, in Fall 2009
WITH enroll (enrollment) AS (
    SELECT COUNT (ID) AS enrollment
    FROM takes
    WHERE semester = 'Fall' AND year = 2009
    GROUP BY course_id, sec_id
)
SELECT MAX (enrollment) AS max_enrollment
FROM enroll;

-- g. Find the sections that had the maximum enrollment in Fall 2009
WITH enroll (course_id, sec_id, semester, year, enrollment) AS (
    SELECT course_id, sec_id, semester, year, COUNT (ID) AS enrollment
    FROM takes
    WHERE semester = 'Fall' AND year = 2009
    GROUP BY course_id, sec_id, semester, year
)
SELECT *
FROM section NATURAL JOIN enroll
WHERE enroll.enrollment = (
    WITH enroll (enrollment) AS (
    SELECT COUNT (ID) AS enrollment
    FROM takes
    WHERE semester = 'Fall' AND year = 2009
    GROUP BY course_id, sec_id
    )
    SELECT MAX (enrollment) AS max_enrollment
    FROM enroll
);

-- Excercise 2
/*
Make a relation grade points(grade, points), which provides a conversion from letter grades in
the takes relation to numeric scores. The tuples of the grade points relation : (A+, 4.3), (A, 4.0),
(A-, 3.7), (B+, 3.3), (B, 3.0), (B-, 2.7), (C+, 2.3), (C, 2.0), (C-, 1.7)
The grade points earned by a student for a course offering (section) is defined as the number
of credits for the course multiplied by the numeric points for the grade that the student
received.
You can assume for simplicity that no takes tuple has the null value for grade.
The result of the student who doesn’t take any class is 0
*/
CREATE TABLE grade_points (
    grade   varchar(4),
    points  numeric(2,1)
);
INSERT INTO grade_points VALUES ('A+', 4.3);
INSERT INTO grade_points VALUES ('A', 4.0);
INSERT INTO grade_points VALUES ('A-', 3.7);
INSERT INTO grade_points VALUES ('B+', 3.3);
INSERT INTO grade_points VALUES ('B', 3.0);
INSERT INTO grade_points VALUES ('B-', 2.7);
INSERT INTO grade_points VALUES ('C+', 2.3);
INSERT INTO grade_points VALUES ('C', 2.0);
INSERT INTO grade_points VALUES ('C-', 1.7);
-- a. Find the total grade-points earned by the student with ID 12345, across all courses taken by the student
SELECT SUM (gp) AS total_gp
FROM (
    SELECT (points * course.credits) AS gp
    FROM (takes NATURAL JOIN grade_points) JOIN course USING (course_id)
    WHERE takes.ID = '12345'
) AS grade_point;

-- b. Find the grade-point average (GPA) for the above student, that is, the total grade-points divided by the total credits for the associated courses 
SELECT (gp / tot_cred) AS GPA
FROM (
    SELECT SUM (points * course.credits) AS gp, SUM (course.credits) AS tot_cred
    FROM (takes NATURAL JOIN grade_points) JOIN course USING (course_id)
    WHERE takes.ID = '12345'
) AS studentGPA;

-- c. Find the ID and the grade-point average of every student
WITH studentGPA (ID, GPA) AS (
    SELECT ID, (gp / tot_cred) AS GPA
    FROM (
        SELECT ID, SUM (points * course.credits) AS gp, SUM (course.credits) AS tot_cred
        FROM (takes NATURAL JOIN grade_points) JOIN course USING (course_id)
        GROUP BY ID
    ) AS _GPA
)
SELECT ID, GPA
FROM studentGPA UNION (
    SELECT ID, 0.0000000000000000
    FROM student
    WHERE NOT EXISTS (
        SELECT *
        FROM studentGPA
        WHERE studentGPA.ID = student.ID
    )
);

-- Excercise 3
/*
Write the following inserts, deletes or updates in SQL,
using the university schema.
*/
-- a. Increase the salary of each instructor in the Comp. Sci. department by 10%
UPDATE instructor
    SET salary = salary * 1.1
    WHERE dept_name = 'Comp. Sci.';

-- b. Delete all courses that have never been offered (that is, do not occur in the section relation)
DELETE FROM course
WHERE course_id IN (
    SELECT course_id
    FROM (
        SELECT course.course_id
        FROM course
        ) AS co1 EXCEPT (
        SELECT DISTINCT course.course_id
        FROM course NATURAL JOIN section
    )
);

-- c. Insert every student whose tot_cred attribute is greater than 100 as an instructor in the same department, with a salary of $30,000
INSERT INTO instructor
    SELECT ID, name, dept_name, 30000
    FROM student
    WHERE tot_cred > 100;
