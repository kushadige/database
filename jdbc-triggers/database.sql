DROP DATABASE IF EXISTS odev;

CREATE DATABASE odev;
use odev;

CREATE TABLE artist(
	id INTEGER, 
	name VARCHAR(20), 
	gender CHAR(1), 
	status SMALLINT, 
	field VARCHAR(11),
	PRIMARY KEY(id),
	check(field in('Music','Painting','Calligraphy'))
);

CREATE TABLE Department
 (did INTEGER not null,
 name VARCHAR(30) not null,
 noOfStudents INTEGER,
 primary key(did));
 
CREATE TABLE Course
 (cid INTEGER not null,
 title VARCHAR(30) not null,
 credits INTEGER,
 did INTEGER,
 studentCount INTEGER,
 foreign key (did) references Department(did),
 primary key(cid));
 
CREATE TABLE Student
 (sid INTEGER not null,
 name VARCHAR(30) not null,
 did INTEGER,
 noOfCourses INTEGER,
 GPA FLOAT,
 foreign key(did) references Department(did),
 primary key(sid));
 
CREATE TABLE Take
 (sid INTEGER not null,
 cid INTEGER not null,
 grade FLOAT,
 foreign key (sid) references Student(sid),
 foreign key (cid) references Course(cid),
 primary key (sid,cid));
 
CREATE TABLE Teacher
 (tid INTEGER not null,
 name VARCHAR(30) not null,
 placeOfBirth VARCHAR(50),
 did INTEGER,
 foreign key (did) references Department(did),
 primary key(tid));
 
CREATE TABLE Teach
 (tid INTEGER not null,
 cid INTEGER not null,
 foreign key (tid) references Teacher(tid),
 foreign key (cid) references Course(cid),
 primary key (tid,cid));

INSERT INTO Department(did,name) VALUES (1,'Comp. Eng.');
INSERT INTO Department(did,name) VALUES (2,'Elec. Eng.');
INSERT INTO Department(did,name) VALUES (3,'Env. Eng.');
INSERT INTO Department(did,name) VALUES (4,'Ind. Eng.');

INSERT INTO Student(sid,name,did) VALUES (1,'Ali Turan', 1);
INSERT INTO Student(sid,name,did) VALUES (2,'Ahmet Buyuk', 1);
INSERT INTO Student(sid,name,did) VALUES (3,'Leyla Sahin', 1);
INSERT INTO Student(sid,name,did) VALUES (4,'Can Turkoglu', 2);
INSERT INTO Student(sid,name,did) VALUES (5,'Ali KURT',	2);
INSERT INTO Student(sid,name,did) VALUES (6,'Talat Sanli', 3);
INSERT INTO Student(sid,name,did) VALUES (7,'Ayse KURT', 3);
INSERT INTO Student(sid,name,did) VALUES (8,'Turgut Cemal', 4);
INSERT INTO Student(sid,name,did) VALUES (9,'Oznur Gunes', 2);
INSERT INTO Student(sid,name,did) VALUES (10,'Pelin Tugay', 4);
INSERT INTO Student(sid,name,did) VALUES (11,'Savas Tan', 4);

INSERT INTO Course(cid,title,credits,did) VALUES (1,'database',3,1);
INSERT INTO Course(cid,title,credits,did) VALUES (2,'operating system',3,1);
INSERT INTO Course(cid,title,credits,did) VALUES (3,'Introduction to Programming',4,1);
INSERT INTO Course(cid,title,credits,did) VALUES (4,'introduction to electronic',2,2);
INSERT INTO Course(cid,title,credits,did) VALUES (5,'statistic',4,4);
INSERT INTO Course(cid,title,credits,did) VALUES (6,'circuit theory',3,2);
INSERT INTO Course(cid,title,credits,did) VALUES (7,'introduction to environment',3,3);
INSERT INTO Course(cid,title,credits,did) VALUES (8,'operation research',3,4);
INSERT INTO Course(cid,title,credits,did) VALUES (9,'summer practice',2,4);
INSERT INTO Course(cid,title,credits,did) VALUES (10,'summer practice',3,3);
INSERT INTO Course(cid,title,credits,did) VALUES (11,'summer practice',3,1);
INSERT INTO Course(cid,title,credits,did) VALUES (12,'summer practice',3,2);

INSERT INTO Teacher VALUES (1,'Selami Durgun', 'amasya',1);
INSERT INTO Teacher VALUES (2,'Cengiz Tahir', 'istanbul',1);
INSERT INTO Teacher VALUES (3,'Derya Seckin', 'mersin',1);
INSERT INTO Teacher VALUES (4,'Dogan Gedikli', 'istanbul',2);
INSERT INTO Teacher VALUES (5,'Ayten Kahraman', 'istanbul',3);
INSERT INTO Teacher VALUES (6,'Tahsin Ugur', 'izmir',4);
INSERT INTO Teacher VALUES (7,'Selcuk Ozan', 'amasya',4);

INSERT INTO Teach VALUES(1,1);
INSERT INTO Teach VALUES(3,2);
INSERT INTO Teach VALUES(2,3);
INSERT INTO Teach VALUES(4,4);
INSERT INTO Teach VALUES(7,5);
INSERT INTO Teach VALUES(4,6);
INSERT INTO Teach VALUES(5,7);
INSERT INTO Teach VALUES(6,8);
INSERT INTO Teach VALUES(7,9);
INSERT INTO Teach VALUES(5,10);
INSERT INTO Teach VALUES(1,11);
INSERT INTO Teach VALUES(4,12);
INSERT INTO teach VALUES(1,12);
INSERT INTO teach VALUES(1,10);
INSERT INTO teach VALUES(1,8);

INSERT INTO Take VALUES(1,1,3);
INSERT INTO Take VALUES(1,3,2.5);
INSERT INTO Take VALUES(1,4,3.5);
INSERT INTO Take VALUES(1,6,3);
INSERT INTO Take VALUES(1,9,4);
INSERT INTO Take VALUES(1,10,3);
INSERT INTO Take VALUES(2,1,4);
INSERT INTO Take VALUES(2,2,4);
INSERT INTO Take VALUES(2,3,4);
INSERT INTO Take VALUES(2,4,4);
INSERT INTO Take VALUES(2,5,4);
INSERT INTO Take VALUES(2,6,4);
INSERT INTO Take VALUES(2,7,4);
INSERT INTO Take VALUES(2,8,4);
INSERT INTO Take VALUES(2,9,4);
INSERT INTO Take VALUES(2,10,3);
INSERT INTO Take VALUES(2,11,4);
INSERT INTO Take VALUES(3,1,4);
INSERT INTO Take VALUES(3,2,4);
INSERT INTO Take VALUES(3,3,4);
INSERT INTO Take VALUES(3,4,4);
INSERT INTO Take VALUES(3,5,4);
INSERT INTO Take VALUES(3,6,4);
INSERT INTO Take VALUES(3,7,4);
INSERT INTO Take VALUES(3,8,4);
INSERT INTO Take VALUES(3,9,4);
INSERT INTO Take VALUES(3,10,3);
INSERT INTO Take VALUES(3,11,3.5);
INSERT INTO Take VALUES(4,1,2.5);
INSERT INTO Take VALUES(4,5,1.5);
INSERT INTO Take VALUES(5,11,3.5);
INSERT INTO Take VALUES(5,1,3);
INSERT INTO Take VALUES(5,5,1.5);
INSERT INTO Take VALUES(6,2,4);
INSERT INTO Take VALUES(7,5,1.5);
INSERT INTO Take VALUES(7,1,2.5);
INSERT INTO Take VALUES(7,8,1.5);
INSERT INTO Take VALUES(7,2,3);
INSERT INTO Take VALUES(8,2,3.5);
INSERT INTO Take VALUES(8,7,1.5);
INSERT INTO Take VALUES(10,2,4);
INSERT INTO Take VALUES(10,8,3);
INSERT INTO Take VALUES(11,8,1);

INSERT INTO artist VALUES(1,'Baris Manco','M',0,'Music');
INSERT INTO artist VALUES(2,'Travis Scott','M',0,'Calligraphy');
INSERT INTO artist VALUES(3,'Anneke van Giersbergen','F',1,'Music');
INSERT INTO artist VALUES(4,'Oguzhan Kuslar','M',1,'Painting');
INSERT INTO artist VALUES(5,'Frida Kahlo','F',0,'Painting');
INSERT INTO artist VALUES(6,'Hulusi Yazgan','M',1,'Calligraphy');