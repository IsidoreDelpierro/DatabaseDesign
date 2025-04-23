--This is the second of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/ 
USE JoinITSolutions
GO

-- //	CREATING VIEWS	//

-- Create TraineeDemographics view 
CREATE VIEW Trainee.TraineeDemographics AS
	SELECT  
		CONCAT(t.[fname], ' ', t.[mname], ' ', t.[lname]) AS [TRAINEE's NAME]
		,t.[gender] AS [SEX]
		,t.[dateofbirth] AS [BIRTHDAY]
		,r.[commonname] AS [RACE]
		,t.[homeaddress] AS [ADDRESS]
		,t.[enrolldate] AS [ENROLLMENT] 
		,s.[status] AS [STATUS]
		, CONCAT(i.[fname], ' ', i.[mname], ' ', i.[lname]) AS [MENTOR]
	FROM [JoinITSolutions].[Trainee].[Trainee] t
		INNER JOIN [JoinITSolutions].[Person].[Race] r ON t.[race]=r.[id] 
		INNER JOIN [JoinITSolutions].[Person].[Status] s ON t.[status]=s.[id]
		INNER JOIN [JoinITSolutions].[Instructor].[Instructor] i ON t.[mentor]=i.[id]
GO

-- Create InstructorDemographics view 
CREATE VIEW Instructor.InstructorDemographics AS
	SELECT  
		CONCAT(i.[fname], ' ', i.[mname], ' ', i.[lname]) AS [INSTRUCTOR's NAME]
		,i.[gender] AS [SEX]
		,i.[dateofbirth] AS [BIRTHDAY]
		,r.[commonname] AS [RACE]
		,i.[homeaddress] AS [ADDRESS]
		,i.[hiredate] AS [HIRED] 
		,s.[status] AS [STATUS] 
	FROM [JoinITSolutions].[Instructor].[Instructor] i
		INNER JOIN [JoinITSolutions].[Person].[Race] r ON i.[race]=r.[id] 
		INNER JOIN [JoinITSolutions].[Person].[Status] s ON i.[status]=s.[id]
GO


-- Create TraineeResults view 
CREATE VIEW Trainee.TraineeResults AS
	SELECT  
		CONCAT(t.[fname], ' ', t.[mname], ' ', t.[lname]) AS [TRAINEE's NAME]
		,t.[gender] AS [SEX]
		,t.[dateofbirth] AS [BIRTHDAY] 
		--,r.[commonname] AS [RACE]
		,t.[enrolldate] AS [ENROLLMENT]  
		, CONCAT(i.[fname], ' ', i.[mname], ' ', i.[lname]) AS [MENTOR]
		--,[class]
		--,[program] 
		,rs.[quiz] AS [QUIZ]
		,rs.[midterm] AS [MIDTERM]
		,rs.[final] AS [FINAL]
		,rs.[project] AS [PROJECT]
		,rs.[quiz] + rs.[midterm] + rs.[final] + rs.[project] AS [TOTAL]
	FROM [JoinITSolutions].[Trainee].[Trainee] t
		INNER JOIN [JoinITSolutions].[Person].[Race] r ON t.[race]=r.[id] 
		INNER JOIN [JoinITSolutions].[Person].[Status] s ON t.[status]=s.[id]
		INNER JOIN [JoinITSolutions].[Instructor].[Instructor] i ON t.[mentor]=i.[id]
		INNER JOIN [JoinITSolutions].[Trainee].[Result] rs ON t.[id]=rs.[trainee]
GO 

-- Create CourseInfo view 
CREATE VIEW Administration.CourseInfo AS 
	SELECT  
		cr.[sector] AS [SECTOR]
		,cr.[title] AS [COURSE TITLE]
		,cr.[duration] AS [LENGTH]
		,sc.[name] AS [ZONE]
		,sc.[fee] AS [COST]
		, CONCAT(i.[fname], ' ', i.[mname], ' ', i.[lname]) AS [INSTRUCTOR]
		,i.[gender] AS [SEX] 
		,i.[hiredate] AS [HIRE DATE] 
		,r.[commonname] AS [RACE] 
		,i.[homeaddress] AS [ADDRESS]
	FROM [JoinITSolutions].[Administration].[Class] cl
		INNER JOIN [JoinITSolutions].[Administration].[Course] cr ON cr.[id]=cl.[course] 
		INNER JOIN [JoinITSolutions].[Instructor].[Instructor] i ON i.[id]=cl.[teacher]
		INNER JOIN [JoinITSolutions].[Person].[Race] r ON i.[race]=r.[id] 
		INNER JOIN [JoinITSolutions].[Administration].[Section] sc ON sc.[id]=cl.[section] 
GO


