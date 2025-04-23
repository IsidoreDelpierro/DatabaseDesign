--This is the seventh of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/  
USE AdventureWorks2016;
GO

-- Step 1: Drop the temporary table if it exists 
IF OBJECT_ID('tempdb..#persontemp') IS NOT NULL
    DROP TABLE #persontemp;
GO

-- Step 2: Create and populate the temporary table
SELECT 
    BusinessEntityID,
    PersonType,
    NameStyle,
    Title,
    FirstName,
    MiddleName,
    LastName,
    Suffix,
    EmailPromotion,
    rowguid,
    ModifiedDate
INTO #persontemp
FROM AdventureWorks2016.Person.Person
WHERE FirstName IN ('Ken', 'Dylan');
GO

-- Step 3: Check if the target schema exists, create if necessary
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Trainee')
BEGIN
    EXEC('CREATE SCHEMA Trainee');
END;
GO

-- Step 4: Create JoinITSolutions.Trainee.MajorEmployee table if it does not exist
USE JoinITSolutions;
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'Trainee' AND TABLE_NAME = 'MajorEmployee')
BEGIN
    PRINT 'Creating table JoinITSolutions.Trainee.MajorEmployee...';
	CREATE TABLE Trainee.MajorEmployee (
        BusinessEntityID INT PRIMARY KEY,
        PersonType NCHAR(2),
        NameStyle BIT,
        Title NVARCHAR(8),
        FirstName NVARCHAR(50),
        MiddleName NVARCHAR(50),
        LastName NVARCHAR(50),
        Suffix NVARCHAR(10),
        EmailPromotion INT,
        rowguid UNIQUEIDENTIFIER,
        ModifiedDate DATETIME
    );
END
ELSE
BEGIN
    PRINT 'Table JoinITSolutions.Trainee.MajorEmployee already exists. Emptying it now.';
	TRUNCATE TABLE [JoinITSolutions].[Trainee].[MajorEmployee]
	PRINT 'Table JoinITSolutions.Trainee.MajorEmployee successfully emptied.';
END;
GO

-- Step 5: Insert only 'Ken' records into JoinITSolutions.Trainee.MajorEmployee
INSERT INTO JoinITSolutions.Trainee.MajorEmployee
SELECT * FROM #persontemp WHERE FirstName = 'Ken';

-- Step 6: Drop the temporary table
DROP TABLE #persontemp;
GO

PRINT 'Data transfer completed successfully!';


SELECT [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[rowguid]
      ,[ModifiedDate]
FROM [JoinITSolutions].[Trainee].[MajorEmployee]
GO