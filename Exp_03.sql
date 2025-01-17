/* Q1 */

create database university;
use university;

create table student(
sname varchar(20),
student_number int primary key,
class int,
major varchar(3)
);


create table course(
course_name varchar(50),
course_number varchar(15) primary key,
credit_hours int,
department varchar(10));

create table section(
section_identifier int primary key,
course_number varchar(15),
semester varchar(10),
syear int,
instructor varchar(20),
foreign key(course_number) references course(course_number)
on delete cascade
on update cascade
);

create table grade_report(
student_number int,
section_identifier int,
grade varchar(2),
foreign key(student_number) references student(student_number),
foreign key(section_identifier) references section(section_identifier)
on delete cascade
on update cascade
);

create table prerequisite(
course_number varchar(15),
prerequisite_number varchar(20) primary key,
foreign key(course_number) references course(course_number)
on delete cascade
on update cascade
);

/* Q2 */

insert into student values('Smith',17,1,'CS');
insert into student values('Brown',8,2,'CS');

insert into course values('Intro to Computer Science','CS1310',4,'CS');
insert into course values('Data Structures','CS3320',4,'CS');
insert into course values('Discrete Mathematics','MATH2410',3,'MATH');
insert into course values('Database','CS3380',3,'CS');

insert into section values(85,'MATH2410','Fall',07,'King');
insert into section values(92,'CS1310','Fall',07,'Anderson');
insert into section values(102,'CS3320','Spring',08,'Knuth');
insert into section values(112,'MATH2410','Fall',08,'Chang');
insert into section values(119,'CS1310','Fall',08,'Anderson');
insert into section values(135,'CS3380','Fall',08,'Stone');

insert into grade_report values(17,112,'B');
insert into grade_report values(17,119,'C');
insert into grade_report values(8,85,'A');
insert into grade_report values(8,92,'A');
insert into grade_report values(8,102,'B');
insert into grade_report values(8,135,'A');

insert into prerequisite values('CS3380', 'CS3320');
insert into prerequisite values('CS3380', 'MATH2410');
insert into prerequisite values('CS3320', 'CS1310');

#3. Retrieve the list of  all courses and grades of ‘Smith’

select course.course_name, grade_report.grade 
from grade_report join course join student 
where student.major=course.department and grade_report.student_number=student.student_number and student.sname="Smith";

#4. List the names of students who took the section of the ‘Database’ course offered in fall 2008 and their grades in that section.

select student.sname, grade_report.grade, course.course_name, section.semester, section.syear 
from student join grade_report join section join course
where student.student_number=grade_report.student_number and 
grade_report.section_identifier=section.section_identifier and
course.course_number=section.course_number and
course.course_name="Database" and
section.semester="Fall" and
section.syear=08;

#5. List the prerequisites of the ‘Database’ course.	

select prerequisite.prerequisite_number, course.course_name 
from prerequisite join course 
where prerequisite.course_number=course.course_number and course.course_name="Database";


#6. Retrieve the names of all senior students majoring in‘CS’(computerscience).

select name from student where major='CS' and class=2;


#7. Retrieve the names of all courses taught by Professor King in 2007 and 2008.
SELECT course.course_name
FROM section INNER JOIN course ON section.course_number=course.course_number
WHERE section.instructor='king' AND section.year IN('07','08'); 

#8. For each section taught by Professor King, retrieve the course number,semester, year, and number of students who took the section
SELECT section.course_number,section.semester,section.year,count(DISTINCT grade_report.student_number) 
FROM section INNER JOIN grade_report ON grade_report.section_identifier=section.section_identifier
WHERE section.section_identifier='king' GROUP BY grade_report.section_identifier;

#9. Retrieve the name and transcript of each senior student (Class = 4)majoring in CS. A transcript includes course name, course number, credit hours, semester, year, and grade for each course completed by the student.
SELECT student.name,course.course_name,course.course_number,course.credit_hours,section.semester,section.year,grade_report.grade
FROM student 
INNER JOIN grade_report ON grade_report.student_number=student.student_number
INNER JOIN section ON section.section_identifier=grade_report.section_identifier 
INNER JOIN course ON course.course_number=section.course_number
WHERE student.class=4;

#10 Write SQL update statements to do the following on the database schema
#A.Insertanewstudent,<‘Johnson’,25,1,‘Math’>,inthedatabase.
INSERT INTO student VALUES('Johnson',25,1,'Math');		
SELECT * FROM student;
								
#B.Change the class of student ‘Smith’ t o2.
UPDATE student SET class=2 WHERE name='smith';
SELECT * FROM student;

#C.Insertanewcourse,<‘KnowledgeEngineering’,‘CS4390’,3,‘CS’>
alter table course modify course_name varchar(50);

alter table course modify course_number varchar(10);
INSERT INTO course VALUES('Knowledge Engineering','4390',3,'CS');
SELECT * FROM course;

#D.Delete therecord forthestudentwhose nameis ‘Smith’and whosestudent number is17.
DELETE FROM student WHERE name='smith' AND student_number=17;
SELECT * FROM student;
