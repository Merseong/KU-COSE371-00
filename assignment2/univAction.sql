--Department (3)
INSERT INTO department VALUES ('COSE', '우정정보관', 32240000);
INSERT INTO department VALUES ('BUSS', '경영본관', 20640000);
INSERT INTO department VALUES ('PMED', '이과대학', 36220000);
--Instructors (10)
--COSE
INSERT INTO instructor VALUES ('32000', 'Sulfur Steel', 'COSE', 34000);
INSERT INTO instructor VALUES ('32001', 'Gambia Kim', 'COSE', 30000);
INSERT INTO instructor VALUES ('32002', 'Younghwan Im', 'COSE', 31000);
INSERT INTO instructor VALUES ('32003', 'Jess Jang', 'COSE', 29000);
--BUSS
INSERT INTO instructor VALUES ('12000', 'Jaewoo Gang', 'BUSS', 30000);
INSERT INTO instructor VALUES ('12001', 'Yejoon Ahn', 'BUSS', 28000);
INSERT INTO instructor VALUES ('12002', 'Vik Ann', 'BUSS', 27000);
--PMED
INSERT INTO instructor VALUES ('18000', 'Kerpitan Lee', 'PMED', 37000);
INSERT INTO instructor VALUES ('18001', 'Gangsoo Kim', 'PMED', 34000);
INSERT INTO instructor VALUES ('18002', 'Daesoo Jeon', 'PMED', 35000);
--Students (20)
--COSE
INSERT INTO student VALUES ('32100', 'Minchae Jeong', 'COSE', 126);
INSERT INTO student VALUES ('32101', 'Alan Mathison Turing', 'COSE', 126);
INSERT INTO student VALUES ('32102', 'Yonaa Kim', 'COSE', 90);
INSERT INTO student VALUES ('32103', 'Enuen Park', 'COSE', 90);
INSERT INTO student VALUES ('32104', 'Gwangjang Minju', 'COSE', 54);
INSERT INTO student VALUES ('32105', 'Myunghwa Yu', 'COSE', 54);
INSERT INTO student VALUES ('32106', 'Sangyun Hyeon', 'COSE', 54);
INSERT INTO student VALUES ('32107', 'Mohammad Holt', 'COSE', 18);
INSERT INTO student VALUES ('32108', 'Daram Lee', 'COSE', 18);
INSERT INTO student VALUES ('32109', 'John von Neuumann', 'COSE', 18);
--BUSS
INSERT INTO student VALUES ('12100', 'Devonte Holden', 'BUSS', 126);
INSERT INTO student VALUES ('12101', 'Jiyoun Joo', 'BUSS', 90);
INSERT INTO student VALUES ('12102', 'Sangwon Song', 'BUSS', 54);
INSERT INTO student VALUES ('12103', 'Heather Myers', 'BUSS', 18);
INSERT INTO student VALUES ('12104', 'Cheonhoon Choi', 'BUSS', 18);
--PMED
INSERT INTO student VALUES ('18100', 'Louis Pasteur', 'PMED', 126);
INSERT INTO student VALUES ('18101', 'John von Neuumann', 'PMED', 90);
INSERT INTO student VALUES ('18102', 'Hojoon Yoon', 'PMED', 54);
INSERT INTO student VALUES ('18103', 'Mingi Jeong', 'PMED', 18);
INSERT INTO student VALUES ('18104', 'Mooser Joo', 'PMED', 18);
--Advisor (10)
--COSE
INSERT INTO advisor VALUES ('32100', '32000');
INSERT INTO advisor VALUES ('32101', '32000');
INSERT INTO advisor VALUES ('32102', '32000');
INSERT INTO advisor VALUES ('32103', '32001');
INSERT INTO advisor VALUES ('32104', '32001');
INSERT INTO advisor VALUES ('32105', '32002');
INSERT INTO advisor VALUES ('32106', '32002');
INSERT INTO advisor VALUES ('32107', '32002');
INSERT INTO advisor VALUES ('32108', '32003');
INSERT INTO advisor VALUES ('32109', '32003');
--BUSS
INSERT INTO advisor VALUES ('12100', '12000');
INSERT INTO advisor VALUES ('12101', '12000');
INSERT INTO advisor VALUES ('12102', '12001');
INSERT INTO advisor VALUES ('12103', '12001');
INSERT INTO advisor VALUES ('12104', '12002');
--PMED
INSERT INTO advisor VALUES ('18100', '18000');
INSERT INTO advisor VALUES ('18101', '18000');
INSERT INTO advisor VALUES ('18102', '18001');
INSERT INTO advisor VALUES ('18103', '18001');
INSERT INTO advisor VALUES ('18104', '18002');
--Classes (5)
INSERT INTO course VALUES ('COSE371', '데이터베이스', 'COSE', '3');
INSERT INTO course VALUES ('COSE222', '컴퓨터구조', 'COSE', '3');
INSERT INTO course VALUES ('COSE242', '데이터통신', 'COSE', '3');
INSERT INTO course VALUES ('BUSS207', '재무관리', 'BUSS', '3');
INSERT INTO course VALUES ('PEMD220', '의학유전학', 'PEMD', '3');
--Classrooms (6)
INSERT INTO classroom VALUES ('애기능생활관', '301', 100);
INSERT INTO classroom VALUES ('정보통신관', '205', 30);
INSERT INTO classroom VALUES ('정보통신관', '601', 30);
INSERT INTO classroom VALUES ('LP관', '432', 100);
INSERT INTO classroom VALUES ('LP관', '531', 100);
INSERT INTO classroom VALUES ('의대강의실', '제4', 30);
--Sections (10)
INSERT INTO section VALUES ('COSE371', '01', '2nd', 2019, '애기능생활관', '301', '00000000');
INSERT INTO section VALUES ('COSE371', '02', '2nd', 2019, '정보통신관', '205', '00001111');
INSERT INTO section VALUES ('COSE222', '01', '2nd', 2019, '애기능생활관', '301', '11110000');
INSERT INTO section VALUES ('COSE222', '02', '2nd', 2019, '정보통신관', '205', '11111111');
INSERT INTO section VALUES ('COSE222', '03', '2nd', 2019, '정보통신관', '205', '11110000');
INSERT INTO section VALUES ('COSE242', '00', '2nd', 2019, '정보통신관', '601', '00000000');
INSERT INTO section VALUES ('BUSS207', '01', '2nd', 2019, 'LP관', '432', '00000000');
INSERT INTO section VALUES ('BUSS207', '02', '2nd', 2019, 'LP관', '531', '00001111');
INSERT INTO section VALUES ('PEMD220', '01', '2nd', 2019, '의대강의실', '제4', '00000000');
INSERT INTO section VALUES ('PEMD220', '02', '2nd', 2019, '의대강의실', '제4', '00001111');
