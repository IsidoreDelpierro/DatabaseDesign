-- DATABASE CREATION 
--This is the first of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/ 

USE master
GO 

-- Create the database with its filegroups and files 
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name='JoinITSolutions')
	BEGIN
		DECLARE @DATAFILEPATH VARCHAR(200); DECLARE @LOGFILEPATH VARCHAR(200);
		SET @DATAFILEPATH='E:\PROD\DATA\'; SET @LOGFILEPATH='L:\PROD\LOG\';
		CREATE DATABASE JoinITSolutions
			ON PRIMARY
				(NAME='JIT_Primary',
				FILENAME='E:\PROD\DATA\JIT_Primary.mdf',
				--FILENAME=CONCAT(@DATAFILEPATH,'JIT_Primary.mdf'),
				SIZE=8MB,
				MAXSIZE=1024MB,
				FILEGROWTH=10MB),
			FILEGROUP INSTRUCTOR
				(NAME='JIT_Instructor',
				FILENAME='E:\PROD\DATA\JIT_Instructor.ndf',
				--FILENAME=CONCAT(@DATAFILEPATH,'JIT_Instructor.ndf'),
				SIZE=8MB,
				MAXSIZE=1024MB,
				FILEGROWTH=10MB),
			FILEGROUP TRAINEE
				(NAME='JIT_Trainee',
				FILENAME='E:\PROD\DATA\JIT_Trainee.ndf',
				--FILENAME=CONCAT(@DATAFILEPATH,'JIT_Trainee.ndf'),
				SIZE=8MB,
				MAXSIZE=1024MB,
				FILEGROWTH=10MB),
			FILEGROUP ADMINISTRATION
				(NAME='JIT_Administration',
				FILENAME='E:\PROD\DATA\JIT_Administration.ndf',
				--FILENAME=CONCAT(@DATAFILEPATH,'JIT_Administration.ndf'),
				SIZE=8MB,
				MAXSIZE=1024MB,
				FILEGROWTH=10MB),
			FILEGROUP PERSON
				(NAME='JIT_Person',
				FILENAME='E:\PROD\DATA\JIT_Person.ndf',
				--FILENAME=CONCAT(@DATAFILEPATH,'JIT_Person.ndf'),
				SIZE=8MB,
				MAXSIZE=1024MB,
				FILEGROWTH=10MB)
			LOG ON
				(NAME='JIT_Log',
				FILENAME='L:\PROD\LOG\JIT_Log.ldf',
				--FILENAME=CONCAT(@LOGFILEPATH,'JIT_Log.ldf'),
				SIZE=8MB,
				MAXSIZE=2048MB,
				FILEGROWTH=10MB) 
	END
GO


-- Point to the database we just created 
USE JoinITSolutions 
GO 

/*
ALTER DATABASE JoinITSolutions
	MODIFY FILEGROUP TRAINEE DEFAULT; 
GO
*/

-- Create schemas 
CREATE SCHEMA Instructor
GO
CREATE SCHEMA Trainee
GO
CREATE SCHEMA Administration
GO
CREATE SCHEMA Person
GO

-- Create tables inside filegroups 
CREATE TABLE Administration.Course (
	 id INT IDENTITY 
	,sector VARCHAR(40) NOT NULL
	,title VARCHAR(50) NOT NULL
	,duration INT NOT NULL
	,CONSTRAINT pk_course_id PRIMARY KEY(id)
)
ON ADMINISTRATION;
GO  

CREATE TABLE Person.Status (
	 id INT IDENTITY 
	,status VARCHAR(10) CONSTRAINT df_status_current DEFAULT 'current'
	,CONSTRAINT pk_status_id PRIMARY KEY(id)
)
ON PERSON;
GO 

CREATE TABLE Person.Race (
	 id INT IDENTITY 
	,race VARCHAR(50) NOT NULL
	,commonname VARCHAR(50) NOT NULL
	,CONSTRAINT pk_race_id PRIMARY KEY(id) 
)
ON PERSON;
GO 

CREATE TABLE Trainee.Program (
	 id INT IDENTITY 
	,program VARCHAR(30) NOT NULL
	,CONSTRAINT pk_program_id PRIMARY KEY(id)
)
ON TRAINEE;
GO 

/**/
CREATE TABLE Administration.Evaluation (
	 id INT IDENTITY  
	,exam VARCHAR(30) NOT NULL
	,CONSTRAINT pk_evaluation_id PRIMARY KEY(id)
)
ON ADMINISTRATION;
GO 
/**/

CREATE TABLE Administration.Section (
	 id INT IDENTITY 
	,name VARCHAR(25) NOT NULL
	,fee MONEY NOT NULL
	,country VARCHAR(100)
	,CONSTRAINT pk_section_id PRIMARY KEY(id)
)
ON ADMINISTRATION;
GO 


CREATE TABLE Instructor.Instructor (
	 id INT IDENTITY 
	,fname VARCHAR(30) NOT NULL
	,mname VARCHAR(30) NULL
	,lname VARCHAR(30) NOT NULL
	,gender VARCHAR(1) NOT NULL CONSTRAINT chk_gender CHECK(gender = 'M' OR gender = 'F')
	,dateofbirth DATE 
	,hiredate DATE DEFAULT GETDATE()
	,firedate DATE  
	,status INT
	,race INT
	,homeaddress VARCHAR(80)
	,CONSTRAINT pk_instructor_id PRIMARY KEY(id) 
	,CONSTRAINT chk_firedate_hiredate_status CHECK(firedate IS NULL AND status=1 OR firedate>=hiredate)
	,CONSTRAINT fk_instructor_status FOREIGN KEY(status) REFERENCES Person.Status(id) 
	,CONSTRAINT fk_instructor_race FOREIGN KEY(race) REFERENCES Person.Race(id) 
)
ON INSTRUCTOR;
GO 


CREATE TABLE Administration.Class (
	 id INT IDENTITY 
	,course INT
	,section INT
	,teacher INT
	,CONSTRAINT pk_class_id PRIMARY KEY(id)
	,CONSTRAINT uc_course_section UNIQUE(course,section)
	,CONSTRAINT fk_class_course FOREIGN KEY(course)  REFERENCES Administration.Course(id) 
	,CONSTRAINT fk_class_section FOREIGN KEY(section) REFERENCES Administration.Section(id)
	,CONSTRAINT fk_class_instructor FOREIGN KEY(teacher) REFERENCES Instructor.Instructor(id) 
)
ON ADMINISTRATION;
GO 



CREATE TABLE Trainee.Trainee (
	 id INT IDENTITY 
	,fname VARCHAR(30) NOT NULL
	,mname VARCHAR(30) NULL
	,lname VARCHAR(30) NOT NULL
	,gender VARCHAR(1) NOT NULL CONSTRAINT chk_gender CHECK(gender = 'M' OR gender = 'F')
	,dateofbirth DATE 
	,race INT
	,homeaddress VARCHAR(80)
	,enrolldate DATE DEFAULT GETDATE()
	,completedate DATE 
	,status INT --CHECK constraint 
	,class INT
	,program INT
	,mentor INT
	,feecomplete BIT DEFAULT 'FALSE' 
	,CONSTRAINT pk_trainee_id PRIMARY KEY(id)
	,CONSTRAINT chk_completedate_enrolldate CHECK(completedate IS NULL AND status=1 OR completedate>enrolldate)
	,CONSTRAINT fk_trainee_race FOREIGN KEY(race) REFERENCES Person.Race(id) 
	,CONSTRAINT fk_trainee_status FOREIGN KEY(status) REFERENCES Person.Status(id) 
	,CONSTRAINT fk_trainee_class FOREIGN KEY(class) REFERENCES Administration.Class(id) 
	,CONSTRAINT fk_trainee_program FOREIGN KEY(program) REFERENCES Trainee.Program(id) 
	,CONSTRAINT fk_trainee_mentor FOREIGN KEY(mentor) REFERENCES Instructor.Instructor(id) 
)
ON TRAINEE;
GO 


CREATE TABLE Administration.Fee (
	 id INT IDENTITY 
	,trainee INT
	,fee MONEY CONSTRAINT chk_fee CHECK(fee>=0)
	,paydate DATE DEFAULT GETDATE()
	,CONSTRAINT pk_fee_id PRIMARY KEY(id)
	,CONSTRAINT fk_fee_trainee FOREIGN KEY(trainee) REFERENCES Trainee.Trainee(id) 
)
ON ADMINISTRATION;
GO 


CREATE TABLE Trainee.Result (
	 id INT IDENTITY 
	,trainee INT
	,quiz INT
	,midterm INT
	,final INT
	,project INT
	,CONSTRAINT pk_result_id PRIMARY KEY(id)
	,CONSTRAINT fk_result_trainee FOREIGN KEY(trainee) REFERENCES Trainee.Trainee(id) 
)
ON TRAINEE;
GO

USE JoinITSolutions
GO
