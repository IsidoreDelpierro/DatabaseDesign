--This is the sixth of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/  
/*
	PREREQUISITES
		I have designed this script to be run on the destination server. 
		Ensure that on the destination server you have created a Linked Server named PRODSERVER
			PRODSERVER should connect the destination to the source from which the data will be pulled 
*/

-- Step 1: Check if JOINITDEVDB exists, create if it doesn't
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'JOINITDEVDB')
BEGIN
    PRINT 'Database JOINITDEVDB does not exist. Creating it now...';
    CREATE DATABASE JOINITDEVDB;
END
ELSE
BEGIN
    PRINT 'Database JOINITDEVDB already exists.';
END
GO

-- Step 2: Use JOINITDEVDB
USE JOINITDEVDB;
GO

-- Step 3: Check if the schema exists, create if it doesn't
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Trainee')
BEGIN
    PRINT 'Schema Trainee does not exist. Creating it now...';
    EXEC('CREATE SCHEMA Trainee');
END
GO

-- Step 4: Check if TraineeInformation table exists, create if it doesn't
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Trainee' AND TABLE_NAME = 'TraineeInformation')
BEGIN
    PRINT 'Table TraineeInformation does not exist. Creating it now...';
    CREATE TABLE Trainee.TraineeInformation (
        id INT PRIMARY KEY 
        ,fname VARCHAR(30) NOT NULL
		,mname VARCHAR(30) NULL
		,lname VARCHAR(30) NOT NULL
        ,gender VARCHAR(1) NOT NULL CONSTRAINT chk_gender CHECK(gender = 'M' OR gender = 'F')
        ,dateofbirth DATE 
        ,homeaddress VARCHAR(80)
    );
END
ELSE
BEGIN
	PRINT 'Table TraineeInformation already exists. Emptying it now.';
	TRUNCATE TABLE [JOINITDEVDB].[Trainee].[TraineeInformation]
	PRINT 'Table TraineeInformation emptied successfully';
END
GO

-- Step 5: Copy data from JoinITSolutions.Trainee.Students to JOINITDEVDB.Trainee.TraineeInformation
INSERT INTO JOINITDEVDB.Trainee.TraineeInformation (id, fname, mname, lname, gender, dateofbirth, homeaddress)
SELECT id, fname, mname, lname, gender, dateofbirth, homeaddress
FROM PRODSERVER.JoinITSolutions.Trainee.Trainee;
GO

PRINT 'Data transfer completed successfully!';

SELECT [id] AS [ID]
      ,CONCAT(fname,' ',mname,' ',lname) AS [TRAINEE's NAME]
      ,[gender] AS [GENDER]
      ,[dateofbirth] AS [BIRTHDAY]
      ,[homeaddress] AS [TRAINEE's ADDRESS]
  FROM [JOINITDEVDB].[Trainee].[TraineeInformation]