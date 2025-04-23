--This is the fifth of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/  
--	//	VIEWS & STORED PROCEDURES	// 

USE [JoinITSolutions]
GO

--	//	TESTING VIEWS	// 
SELECT * FROM [Trainee].[TraineeDemographics]
SELECT * FROM [Instructor].[InstructorDemographics]
SELECT * FROM [Trainee].[TraineeResults]
SELECT * FROM [Administration].[CourseInfo]


--	//	TESTING STORED PROCEDURES	// 
EXEC [Trainee].[InstructorMenteeResults] @MentorID = 15 -- results of students mentored by this instructor 
EXEC [Administration].[TraineesInProgram] @ProgramID = 3 -- demographics of trainees in this program 
EXEC [Trainee].[FlushDroppedTrainees] 
