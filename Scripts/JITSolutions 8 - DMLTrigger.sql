--This is the eighth of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/  
-- CREATE THE AUDIT TABLE 

USE JoinITSolutions;
GO

-- Step 1: Create Secured Schema if not exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Secured')
BEGIN
    EXEC('CREATE SCHEMA Secured');
	PRINT 'Secured schema created.';
END;
GO

-- Step 2: Create the audit table if it does not exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Secured' AND TABLE_NAME = 'TriggerAudit')
BEGIN
    CREATE TABLE Secured.TriggerAudit (
        AuditID INT IDENTITY(1,1) PRIMARY KEY,
        ActionType NVARCHAR(10),  -- INSERT, UPDATE, DELETE
        AffectedTable NVARCHAR(100),
        ExecutedBy NVARCHAR(100),
        ExecutionTime DATETIME DEFAULT GETDATE(),
        OriginalData NVARCHAR(MAX) NULL,
        NewData NVARCHAR(MAX) NULL
    );
END;
GO




-- CREATE THE TRIGGER ON MajorEmployee TABLE

USE JoinITSolutions;
GO

CREATE OR ALTER TRIGGER Trainee.MajorEmployeeAuditTrigger
ON Trainee.MajorEmployee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ActionType NVARCHAR(10) 

    -- Handle INSERT operations
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        SET @ActionType = 'INSERT';
        INSERT INTO Secured.TriggerAudit (ActionType, AffectedTable, ExecutedBy, OriginalData, NewData)
        SELECT 
            @ActionType, 
            'Trainee.MajorEmployee', 
            SYSTEM_USER, 
            NULL, 
            CONCAT('BusinessEntityID: ', i.BusinessEntityID, ', Name: ', i.FirstName, ' ', i.LastName)
        FROM inserted i;
    END

    -- Handle DELETE operations
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        SET @ActionType = 'DELETE';
        INSERT INTO Secured.TriggerAudit (ActionType, AffectedTable, ExecutedBy, OriginalData, NewData)
        SELECT 
            @ActionType, 
            'Trainee.MajorEmployee', 
            SYSTEM_USER, 
            CONCAT('BusinessEntityID: ', d.BusinessEntityID, ', Name: ', d.FirstName, ' ', d.LastName), 
            NULL
        FROM deleted d;
    END

    -- Handle UPDATE operations
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        SET @ActionType = 'UPDATE';
        INSERT INTO Secured.TriggerAudit (ActionType, AffectedTable, ExecutedBy, OriginalData, NewData)
        SELECT 
            @ActionType, 
            'Trainee.MajorEmployee', 
            SYSTEM_USER, 
            CONCAT('Old - BusinessEntityID: ', d.BusinessEntityID, ', Name: ', d.FirstName, ' ', d.LastName), 
            CONCAT('New - BusinessEntityID: ', i.BusinessEntityID, ', Name: ', i.FirstName, ' ', i.LastName)
        FROM inserted i
        JOIN deleted d ON i.BusinessEntityID = d.BusinessEntityID;
    END
END;
GO




-- TEST THE TRIGGER WITH DIFFERENT USERS 

USE master;
GO

-- Step i: Create SQL Server Logins
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Binsinla')
    CREATE LOGIN Binsinla WITH PASSWORD = 'Binsinla@Pass123', CHECK_POLICY = OFF;
GO
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Mainimo')
    CREATE LOGIN Mainimo WITH PASSWORD = 'Mainimo@Pass123', CHECK_POLICY = OFF;
GO
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Jaika')
    CREATE LOGIN Jaika WITH PASSWORD = 'Jaika@Pass123', CHECK_POLICY = OFF;
GO

-- Step ii: Switch to JoinITSolutions Database
USE JoinITSolutions;
GO

-- Step iii: Create Database Users for Each Login
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Binsinla')
    CREATE USER Binsinla FOR LOGIN Binsinla;
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Mainimo')
    CREATE USER Mainimo FOR LOGIN Mainimo;
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Jaika')
    CREATE USER Jaika FOR LOGIN Jaika;
GO

-- Step iv: Grant Permissions on MajorEmployee Table
GRANT SELECT, INSERT, UPDATE, DELETE ON Trainee.MajorEmployee TO Binsinla;
GRANT SELECT, INSERT, UPDATE, DELETE ON Trainee.MajorEmployee TO Mainimo;
GRANT SELECT, INSERT, UPDATE, DELETE ON Trainee.MajorEmployee TO Jaika;
GO

--User 1: Insert a New Employee 
EXECUTE AS USER = 'Binsinla';
INSERT INTO Trainee.MajorEmployee (BusinessEntityID, PersonType, NameStyle, FirstName, LastName)
VALUES (101, 'EM', 0, 'Ken', 'Adams');
REVERT;
GO

--User 2: Update an Employee Record 
EXECUTE AS USER = 'Mainimo';
UPDATE Trainee.MajorEmployee
SET FirstName = 'Kenny'
WHERE BusinessEntityID = 101;
REVERT;
GO

--User 3: Delete an Employee Record
EXECUTE AS USER = 'Jaika';
DELETE FROM Trainee.MajorEmployee WHERE BusinessEntityID = 101;
REVERT;
GO

-- VERIFY THE AUDIT TABLE 
SELECT * FROM Secured.TriggerAudit ORDER BY ExecutionTime DESC;
GO
