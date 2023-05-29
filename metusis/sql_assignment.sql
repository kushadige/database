-- Query 1

DROP DATABASE IF EXISTS metusis;

CREATE DATABASE metusis;
USE metusis;

CREATE TABLE department(
    DepartmentCode INTEGER,
    Name VARCHAR(225),
    Faculty VARCHAR(225),
    Institute VARCHAR(225),
    PRIMARY KEY (DepartmentCode)
);

CREATE TABLE instructor(
    InstructorID INTEGER, 
    Name VARCHAR(45), 
    Surname VARCHAR(45), 
    Title VARCHAR(45),  
    Department INTEGER,
    Email VARCHAR(45), 
    Office VARCHAR(45), 
    OfficePhone VARCHAR(45),
    PRIMARY KEY (InstructorID),
    FOREIGN KEY (Department) REFERENCES department(DepartmentCode)
);

CREATE TABLE TA(
    TAID INTEGER,
    Name VARCHAR(45), 
    Surname VARCHAR(45),
    Department INTEGER,
    Email VARCHAR(45), 
    Office VARCHAR(45),
    PRIMARY KEY (TAID),
    FOREIGN KEY (Department) REFERENCES department(DepartmentCode)
);

CREATE TABLE student(
    StudentID INTEGER,
    Name VARCHAR(45), 
    Surname VARCHAR(45),
    BirthDate DATE,
    Email VARCHAR(45), 
    Address VARCHAR(45), 
    StartingSemester INTEGER,
    Advisor INTEGER,
    Department INTEGER,
    PRIMARY KEY (StudentID),
    FOREIGN KEY (Department) REFERENCES department(DepartmentCode)
);

CREATE TABLE course(
    DepartmentCode INTEGER,
    CourseCode INTEGER,
    InstructorID INTEGER,
    Name VARCHAR(25),
    Credit INTEGER,
    PRIMARY KEY (CourseCode),
    FOREIGN KEY (DepartmentCode) REFERENCES department(DepartmentCode),
    FOREIGN KEY (InstructorID) REFERENCES instructor(InstructorID)
);

CREATE TABLE offerredcourses(
    CourseCode INTEGER,
    DepartmentCode INTEGER,
    Semester INTEGER,
    Section INTEGER,
    Instructor INTEGER,
    TA1 INTEGER,
    TA2 INTEGER,
    PRIMARY KEY (CourseCode, DepartmentCode, Semester, Section),
    FOREIGN KEY (CourseCode) REFERENCES course(CourseCode),
    FOREIGN KEY (DepartmentCode) REFERENCES department(DepartmentCode),
    FOREIGN KEY (TA1) REFERENCES TA(TAID),
    FOREIGN KEY (TA2) REFERENCES TA(TAID)
);

CREATE TABLE enrolledcourses(
    StudentID INTEGER,
    CourseCode INTEGER,
    DepartmentCode INTEGER,
    Semester INTEGER,
    Section INTEGER,
    Category VARCHAR(45),
    Letter DECIMAL(10,2),
    PRIMARY KEY (StudentID, CourseCode, DepartmentCode, Semester),
    FOREIGN KEY (CourseCode) REFERENCES course(CourseCode),
    FOREIGN KEY (DepartmentCode) REFERENCES department(DepartmentCode)
);


-- Query 2

INSERT INTO TA(TAID, Name, Surname, Department, Email, Office) 
VALUES 
    (200001, 'Beril', 'Akkaya', 568, 'akkaya@metu.edu.tr', 319),
    (200002, 'Çiya', 'Aydoğan', 568, 'aydogan@metu.edu.tr', 325),
    (200003, 'Ayser', 'Akgüneş', 568, 'akgunes@metu.edu.tr', 137),
    (200004, 'Melis', 'Boran', 568, 'boran@metu.edu.tr', 325),
    (200005, 'Gözdenur', 'Büyük', 568, 'buyuk@metu.edu.tr', 137),
    (200006, 'Tuğçe', 'Canbilen', 568, 'canbilen@metu.edu.tr', 137),
    (200007, 'Günsu', 'Dağıstanlı', 568, 'dagistanli@metu.edu.tr', 320),
    (200008, 'Can', 'Er', 568, 'er@metu.edu.tr', 136),
    (200009, 'Yasin Taha', 'Gürlesin', 568, 'gurlesin@metu.edu.tr', 321),
    (200010, 'Utku', 'Girit', 568, 'girit@metu.edu.tr', 138),
    (200011, 'Gülten', 'Gökayaz', 568, 'gokayaz@metu.edu.tr', 136),
    (200012, 'Tolga', 'Karabaş', 568, 'karabas@metu.edu.tr', 321),
    (200013, 'Melissa', 'Karagür', 568, 'karagur@metu.edu.tr', 214),
    (200014, 'Şakir Buğra', 'Kollar', 568, 'kollar@metu.edu.tr', 318),
    (200015, 'İlyas Alper', 'Şener', 568, 'sener@metu.edu.tr', 138),
    (200016, 'Hasan', 'Taş', 568, 'tas@metu.edu.tr', 327),
    (200017, 'Mehmet Sencer', 'Zengin', 568, 'zengin@metu.edu.tr', 324),
    (200018, 'Ali Yücel', 'Türegün', 568, 'turegun@metu.edu.tr', 327),
    (200019, 'Sıdıka', 'Tunç', 568, 'tunc@metu.edu.tr', 214);


-- Query 3

ALTER TABLE student
  ADD BirthPlace VARCHAR(45)
    AFTER BirthDate;


-- Query 4

ALTER TABLE course DROP FOREIGN KEY InstructorID;

ALTER TABLE course DROP COLUMN InstructorID;

ALTER TABLE course MODIFY Name VARCHAR(45);


-- Query 5

SELECT T2.Name, T2.Surname, T1.CourseCode, T1.Semester 
FROM 
    (SELECT Instructor, CourseCode, Semester FROM offerredcourses WHERE Semester > 20142) AS T1,
    instructor AS T2 
WHERE T2.InstructorID = T1.Instructor;


-- Query 6

SELECT 
    CONCAT(T2.Name, ' ', T2.Surname) AS 'Name&Surname', 
    T1.CourseCode, 
    T1.Semester, 
    T1.Letter 
FROM 
    (SELECT * FROM enrolledcourses WHERE Category = 'Must' AND Letter >= 1.00) AS T1, 
    (SELECT * FROM student WHERE address = 'METU Dormitories') AS T2 
WHERE T1.StudentID = T2.StudentID;


-- Query 7

SELECT DISTINCT 
    T3.StudentID, 
    T3.Letter
FROM
    (SELECT 
        T1.StudentID, 
        T1.Letter, 
        T2.Address 
    FROM 
        (SELECT * FROM enrolledcourses WHERE Semester = 20151) AS T1, 
        student AS T2 
    WHERE T1.StudentID = T2.StudentID) AS T3,
    (SELECT 
        T1.StudentID, 
        T1.Letter, 
        T2.Address 
    FROM 
        (SELECT * FROM enrolledcourses WHERE Semester = 20151) AS T1, 
        student AS T2 
    WHERE T1.StudentID = T2.StudentID) AS T4
WHERE 
    T3.Letter > T4.Letter AND 
    T4.Address = 'METU Dormitories' AND 
    T3.Address != 'METU Dormitories';