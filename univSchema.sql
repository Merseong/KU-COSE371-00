--1
CREATE TABLE department (
    dept_name varchar(20),
    building varchar(20),
    budget numeric(12,0),
    PRIMARY KEY (dept_name)
);
--2
CREATE TABLE instructor (
    ID char(5),
    name varchar(20) not null,
    dept_name varchar(20),
    salary numeric(8,2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department
);
--3
CREATE TABLE student (
    ID varchar(5),
    name varchar(20) not null,
    dept_name varchar(20),
    tot_cred numeric(3,0),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department
);
--4
CREATE TABLE advisor (
    s_id varchar(5),
    i_id char(5),
    PRIMARY KEY (s_id),
    FOREIGN KEY (s_id) REFERENCES student,
    FOREIGN KEY (i_id) REFERENCES instructor
);
--5
CREATE TABLE course (
    course_id varchar(8),
    title varchar(50),
    dept_name varchar(20),
    credits numeric(2,0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department
);
--6
CREATE TABLE prereq (
    course_id varchar(8),
    prereq_id varchar(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course,
    FOREIGN KEY (prereq_id) REFERENCES course
);
--7
CREATE TABLE classroom (
    building varchar(20),
    room_no varchar(6),
    capacity int,
    PRIMARY KEY (building, room_no)
);
--8
CREATE TABLE section (
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4,0),
    building varchar(20),
    room_no varchar(6),
    time_slot_id varchar(8),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (building, room_no) REFERENCES classroom,
    FOREIGN KEY (course_id) REFERENCES course
);
--9
CREATE TABLE teaches (
    ID char(5),
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4,0),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES instructor,
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section
);
--10
CREATE TABLE takes (
    ID varchar(5),
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4,0),
    grade varchar(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES student,
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section
);