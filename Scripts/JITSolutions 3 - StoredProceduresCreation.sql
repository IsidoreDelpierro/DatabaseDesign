--This is the third of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/  
USE JoinITSolutions
GO 

--	//	CREATING STORED PROCEDURES	// 

-- Create InstructorMenteeResults procedure 
CREATE PROCEDURE [Trainee].[InstructorMenteeResults] @MentorID INT 
	AS
		SELECT  
			CONCAT(t.[fname], ' ', t.[mname], ' ', t.[lname]) AS [TRAINEE's NAME]
			,t.[gender] AS [SEX]
			,t.[dateofbirth] AS [BIRTH DATE] 
			,t.[enrolldate] AS [ENROLLED]  
			,cr.[title] AS [COURSE TITLE]
			,sc.[name] AS [ZONE]
			, CONCAT(i.[fname], ' ', i.[mname], ' ', i.[lname]) AS [MENTOR] 
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
			INNER JOIN [JoinITSolutions].[Administration].[Class] cl ON cl.[id]=t.[class]
			INNER JOIN [JoinITSolutions].[Administration].[Course] cr ON cr.[id]=cl.[course]
			INNER JOIN [JoinITSolutions].[Administration].[Section] sc ON sc.[id]=cl.[section]
		WHERE i.[id]=@MentorID
GO 


-- Create TraineesInProgram procedure
CREATE PROCEDURE [Administration].[TraineesInProgram] @ProgramID INT
	AS 
		SELECT 
			CONCAT(t.[fname], ' ', t.[mname], ' ', t.[lname]) AS [TRAINEE's  NAME]
			,t.[gender] AS [SEX]
			,t.[dateofbirth] AS [BIRTH DATE] 
			,t.[enrolldate] AS [ENROLLED]
			,CONCAT(sc.[name],' - ',cr.[title]) AS [ZONE & COURSE]
			,p.[program] AS [PROGRAM]
			,sc.[fee] AS [COST]
			, CONCAT(i.[fname], ' ', i.[mname], ' ', i.[lname]) AS [MENTOR] 
			,t.[homeaddress] AS [TRAINEE's  ADDRESS]
		FROM [JoinITSolutions].[Trainee].[Trainee] t
			INNER JOIN [JoinITSolutions].[Trainee].[Program] p ON p.[id]=t.[program]
			INNER JOIN [JoinITSolutions].[Administration].[Class] cl ON cl.[id]=t.[class]
			INNER JOIN [JoinITSolutions].[Administration].[Section] sc ON sc.[id]=cl.[section]
			INNER JOIN [JoinITSolutions].[Administration].[Course] cr ON cr.[id]=cl.[course]
			INNER JOIN [JoinITSolutions].[Instructor].[Instructor] i ON t.[mentor]=i.[id]
		WHERE t.[program]=@ProgramID
GO


-- Create FlushDroppedTrainees procedure
CREATE PROCEDURE [Trainee].[FlushDroppedTrainees]
AS
	IF EXISTS(SELECT * FROM sys.tables WHERE name='DroppedTrainees') 
		DROP TABLE [Trainee].[DroppedTrainees] 
	SELECT  id AS [ID], CONCAT(fname,+' '+mname,+' '+lname) AS [TRAINEE's NAME], gender AS [SEX],dateofbirth AS [BIRTH DATE]
			,race AS [RACE],homeaddress AS [TRAINEE's HOME ADDRESS], enrolldate AS [ENROLLED], completedate AS [GRADUATED]
			,status AS [STATUS], class AS [CLASS], program AS [PROG], mentor AS [MENTOR], feecomplete AS [FEES?]
	INTO [JoinITSolutions].[Trainee].[DroppedTrainees]
	FROM [JoinITSolutions].[Trainee].[Trainee]
	SELECT * FROM [Trainee].[DroppedTrainees]
GO


