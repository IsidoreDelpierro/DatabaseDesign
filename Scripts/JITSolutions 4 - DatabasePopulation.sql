--This is the fourth of eight scripts. You can get all files for this project on my GitHub repository here: https://github.com/IsidoreDelpierro/DatabaseDesign.git I will be uploading material for other projects in the long run here: https://github.com/isidoredelpierro/  
USE [JoinITSolutions]
GO

-- Populate Administration.Course
INSERT INTO Administration.Course (sector, title, duration)
VALUES 
('IT', 'Introduction to Programming', 12),
('IT', 'Data Structures and Algorithms', 15),
('IT', 'Database Management Systems', 10),
('IT', 'Web Development', 12),
('IT', 'Networking Fundamentals', 10),
('Business', 'Financial Management', 8),
('Business', 'Marketing Strategies', 10),
('Business', 'Human Resource Management', 12),
('Business', 'Operations Management', 10),
('Business', 'Entrepreneurship', 8);
GO

-- Populate Person.Status
INSERT INTO Person.Status (status)
VALUES 
('Current'),
('Inactive'),
('Former');
GO

-- Populate Person.Race
INSERT INTO Person.Race (race, commonname)
VALUES 
('Asian', 'Asian'),
('Black or African American', 'Black'),
('White', 'White'),
('Hispanic or Latino', 'Hispanic'),
('American Indian or Alaska Native', 'Native American'),
('Pacific Islander', 'Pacific Islander'),
('Other', 'Other');
GO

-- Populate Trainee.Program
INSERT INTO Trainee.Program (program)
VALUES 
('Certificate'),
('Diploma'),
('Degree');
GO

-- Populate Administration.Evaluation
INSERT INTO Administration.Evaluation (exam)
VALUES 
('Midterm Exam'),
('Final Exam'),
('Project Evaluation'),
('Quizzes');
GO


-- Populate Administration.Section
INSERT INTO Administration.Section (name, fee, country)
VALUES 
('USA', 3000.00, 'United States of America, Canada'),
('EUR', 1500.00, 'Europe, Asia, Australia, South America'),
('CMR', 750.00, 'Cameroon, Africa');
GO


-- Populate Instructor.Instructor
DECLARE @counter INT = 1;
WHILE @counter <= 50
BEGIN
	INSERT INTO Instructor.Instructor (fname, mname, lname, gender, dateofbirth, hiredate, firedate, status, race, homeaddress)
	VALUES
	(
		-- fname
		CASE ABS(CHECKSUM(NEWID())) % 5
			WHEN 0 THEN 'Anurin'
			WHEN 1 THEN 'Mbang'
			WHEN 2 THEN 'Monameh'
			WHEN 3 THEN 'Bechem'
			WHEN 4 THEN 'Tchou'
			WHEN 5 THEN 'Ngo'
			WHEN 6 THEN 'Nkongho'
			WHEN 7 THEN 'Nkwenti'
			WHEN 8 THEN 'Ndiang'
			WHEN 9 THEN 'Nkwelle'
			WHEN 10 THEN 'Hamadou'
			WHEN 11 THEN 'Bouba'
			WHEN 12 THEN 'Oumarou'
			WHEN 13 THEN 'Moussa'
			WHEN 14 THEN 'Ngono'
			WHEN 15 THEN 'Kenfack'
			ELSE 'Ngiri'
		END,

		-- mname
		CASE ABS(CHECKSUM(NEWID())) % 21
			WHEN 0 THEN 'W.'
			WHEN 1 THEN 'Y.'
			WHEN 2 THEN 'V.'
			WHEN 3 THEN 'T.'
			WHEN 4 THEN 'S.'
			WHEN 5 THEN 'R.'
			WHEN 6 THEN 'P.'
			WHEN 7 THEN 'N.'
			WHEN 8 THEN 'M.'
			WHEN 9 THEN 'L.'
			WHEN 10 THEN 'K.'
			WHEN 11 THEN 'J.'
			WHEN 12 THEN 'H.'
			WHEN 13 THEN 'G.'
			WHEN 14 THEN 'F.'
			WHEN 15 THEN 'D.'
			WHEN 16 THEN 'C.'
			WHEN 17 THEN 'B.'
			WHEN 18 THEN 'X.'
			WHEN 19 THEN 'Q.'
			WHEN 20 THEN 'E.'
			ELSE 'Z.'
		END,

		-- lname
		CASE ABS(CHECKSUM(NEWID())) % 6
			WHEN 0 THEN 'Nfor'
			WHEN 1 THEN 'Chongwain'
			WHEN 2 THEN 'Fozoh'
			WHEN 3 THEN 'Fotso'
			WHEN 4 THEN 'Kangawa'
			WHEN 5 THEN 'Sali'
			WHEN 6 THEN 'Aboubakar'
			WHEN 7 THEN 'Abdoulaye'
			WHEN 8 THEN 'Yaya'
			WHEN 9 THEN 'Nana'
			WHEN 10 THEN 'Alhadji'
			WHEN 11 THEN 'Issa'
			WHEN 12 THEN 'Kamgain'
			WHEN 13 THEN 'Ousmanou'
			WHEN 14 THEN 'Kengne'
			WHEN 15 THEN 'Saidou' 
			ELSE 'Fon'
		END,

		-- gender
		CASE ABS(CHECKSUM(NEWID())) % 2
			WHEN 0 THEN 'M'
			ELSE 'F'
		END,

		-- dateofbirth
		DATEADD(day, ABS(CHECKSUM(NEWID())) % 6574, '1980-01-01'),

		-- hiredate
		DATEADD(day, ABS(CHECKSUM(NEWID())) % 5113, '2010-01-01'),

		-- firedate
			NULL,
        
        -- status 
		CASE ABS(CHECKSUM(NEWID())) % 3
			WHEN 0 THEN 3
			WHEN 1 THEN 2
			ELSE 1
		END,

		-- race
		ABS(CHECKSUM(NEWID())) % 7 + 1,

		-- homeaddress
		CONCAT(
			-- Street number
			ABS(CHECKSUM(NEWID())) % 100 + 1,
			' ',
			-- Street name
			CASE ABS(CHECKSUM(NEWID())) % 5
			WHEN 0 THEN 'Main Street'
			WHEN 1 THEN 'Oak Avenue'
			WHEN 2 THEN 'Pine Road'
			WHEN 3 THEN 'Maple Drive'
			ELSE 'Elm Street'
			END,
			', ',
			-- City
			CASE ABS(CHECKSUM(NEWID())) % 15
				WHEN 0 THEN 'Bainville'
				WHEN 1 THEN 'Fallon'
				WHEN 2 THEN 'Alberton'
				WHEN 3 THEN 'Danville'
				WHEN 4 THEN 'Decatur'
				WHEN 5 THEN 'Garland'
				WHEN 6 THEN 'Waco City'
				WHEN 7 THEN 'Austin'
				WHEN 8 THEN 'Los Angeles'
				WHEN 9 THEN 'Albany'
				WHEN 10 THEN 'San Diego'
				WHEN 11 THEN 'Angoon'
				WHEN 12 THEN 'Huslia'
				WHEN 13 THEN 'Nulato'
				WHEN 14 THEN 'Noorvik' 
				ELSE 'Aurora'
			END,
			', ',
			-- State/Province
			CASE ABS(CHECKSUM(NEWID())) % 5
				WHEN 0 THEN 'MT'
				WHEN 1 THEN 'AK'
				WHEN 2 THEN 'CA'
				WHEN 3 THEN 'TX'
				ELSE 'IL'
			END,
		' ',
		-- Postal code
		CONVERT(VARCHAR(10), ABS(CHECKSUM(NEWID())) % 1000000 + 100000)
		)
	);
	SET @counter += 1;
END;
GO



-- Populate Administration.Class
DECLARE @coursecounter INT = 1;
DECLARE @sectioncounter INT = 0;  
WHILE @coursecounter <= 30
BEGIN 
	INSERT INTO Administration.Class (course, section, teacher)
	VALUES   
	( 
		-- course field 
		CASE (@coursecounter % 10 + 1)
			WHEN 1 THEN 1 
			WHEN 2 THEN 2
			WHEN 3 THEN 3
			WHEN 4 THEN 4
			WHEN 5 THEN 5
			WHEN 6 THEN 6
			WHEN 7 THEN 7
			WHEN 8 THEN 8
			WHEN 9 THEN 9
			ELSE 10
		END,
		-- section field 
		@sectioncounter % 3 + 1,
        
		-- teacher field 
		ABS(CHECKSUM(NEWID())) % 50 + 1
	)
	SET @sectioncounter += 1
	SET @coursecounter += 1
END
GO



-- Populate Trainee.Trainee
DECLARE @countvar INT = 1;
WHILE @countvar <= 1000
BEGIN
    INSERT INTO Trainee.Trainee(fname, mname, lname, gender, dateofbirth, race, homeaddress, enrolldate, completedate, status, class, program, mentor, feecomplete)
    VALUES 
    (
        -- First name
        CASE ABS(CHECKSUM(NEWID())) % 20
            WHEN 0 THEN 'Aisha'
            WHEN 1 THEN 'Fatima'
            WHEN 2 THEN 'Njong'
            WHEN 3 THEN 'Kume'
            WHEN 4 THEN 'Ngah'
            WHEN 5 THEN 'Atangana'
            WHEN 6 THEN 'Ibrahim'
            WHEN 7 THEN 'Fonyuy'
            WHEN 8 THEN 'Chefor'
            WHEN 9 THEN 'Bivenja'
            WHEN 10 THEN 'Dongmo'
			WHEN 11 THEN 'Manga'
            WHEN 12 THEN 'Onana'
            WHEN 13 THEN 'Ndongo'
            WHEN 14 THEN 'Che'
            WHEN 15 THEN 'Mana'
            WHEN 16 THEN 'Ngong'
            WHEN 17 THEN 'Mvondo'
            WHEN 18 THEN 'Mballa'
            WHEN 19 THEN 'Mbah'
            ELSE 'Tata'
        END,
        
        -- Middle name
        CASE ABS(CHECKSUM(NEWID())) % 10
            WHEN 0 THEN 'Awa'
            WHEN 1 THEN 'Osu'
            WHEN 2 THEN 'Nkwanda'
            WHEN 3 THEN 'Gaba'
            WHEN 4 THEN 'Kangawa'
            WHEN 5 THEN 'Fotso'
            WHEN 6 THEN 'Etame'
            WHEN 7 THEN 'Ngwa'
            WHEN 8 THEN 'Achu'
            WHEN 9 THEN 'Ndive'
            ELSE 'Bih'
        END,
        
        -- Last name
        CASE ABS(CHECKSUM(NEWID())) % 22
            WHEN 0 THEN 'Owusu'
            WHEN 1 THEN 'Mensah'
            WHEN 2 THEN 'Aneng'
            WHEN 3 THEN 'Banda'
            WHEN 4 THEN 'Tabi'
            WHEN 5 THEN 'Kah'
            WHEN 6 THEN 'Muna'
            WHEN 7 THEN 'Nfon'
            WHEN 8 THEN 'Abong'
            WHEN 9 THEN 'Ndumbe'
            WHEN 10 THEN 'Ngalim'
            WHEN 11 THEN 'Sama'
            WHEN 12 THEN 'Astaladjam'
            WHEN 13 THEN 'Abakar'
            WHEN 14 THEN 'Amougou'
            WHEN 15 THEN 'Simo'
            WHEN 16 THEN 'Eyenga'
            WHEN 17 THEN 'Essomba'
            WHEN 18 THEN 'Ndjidda'
            WHEN 19 THEN 'Kamdem'
            WHEN 20 THEN 'Agbor'
            WHEN 21 THEN 'Talla'
            ELSE 'Bongfen'
        END,
        
        -- Gender
        CASE ABS(CHECKSUM(NEWID())) % 2
            WHEN 0 THEN 'M'
            ELSE 'F'
        END,
        
        -- Date of birth
        DATEADD(day, ABS(CHECKSUM(NEWID())) % 10368, '1980-01-01'),
        
        -- Race
        ABS(CHECKSUM(NEWID())) % 7 + 1,
        
        -- Home address
        CONCAT(
            -- Street number
            ABS(CHECKSUM(NEWID())) % 100 + 1,
            ' ',
            -- Street name
            CASE ABS(CHECKSUM(NEWID())) % 13
                WHEN 0 THEN 'Main Street'
                WHEN 1 THEN 'Oak Avenue'
                WHEN 2 THEN 'Pine Road'
                WHEN 3 THEN 'Maple Drive'
                WHEN 4 THEN 'Boulevard Alexis-Nihon'
                WHEN 5 THEN 'Rue Claire'
                WHEN 6 THEN 'Wonyamongo'
                WHEN 7 THEN 'Malingo'
                WHEN 8 THEN 'Bonduma'
                WHEN 9 THEN 'Bakweri Town'
                WHEN 10 THEN 'Long Street'
                WHEN 11 THEN 'Tole'
                WHEN 12 THEN 'Saxehoff'
                ELSE 'Dirty South'
            END,
            ', ',
            -- City
            CASE ABS(CHECKSUM(NEWID())) % 13
                WHEN 0 THEN 'New York'
                WHEN 1 THEN 'Los Angeles'
                WHEN 2 THEN 'Chicago'
                WHEN 3 THEN 'Houston'
                WHEN 4 THEN 'Philadelphia'
                WHEN 5 THEN 'Douala'
                WHEN 6 THEN 'Bafoussam'
                WHEN 7 THEN 'Maroua'
                WHEN 8 THEN 'Montreal'
                WHEN 9 THEN 'Ottawa'
                WHEN 10 THEN 'Lagos'
                WHEN 11 THEN 'Gattineau'
                WHEN 12 THEN 'Dallas'
                ELSE 'Buea'
            END,
            ', ',
            -- State/Province
            CASE ABS(CHECKSUM(NEWID())) % 10
                WHEN 0 THEN 'NY'
                WHEN 1 THEN 'CA'
                WHEN 2 THEN 'IL'
                WHEN 3 THEN 'TX'
                WHEN 4 THEN 'ON'
                WHEN 5 THEN 'SW'
                WHEN 6 THEN 'NW'
                WHEN 7 THEN 'LT'
                WHEN 8 THEN 'QC'
                WHEN 9 THEN 'DC'
                ELSE 'PA'
            END,
            ' ',
            -- Postal code
            CONVERT(VARCHAR(10), ABS(CHECKSUM(NEWID())) % 1000000 + 100000)
        ),

		-- enrolldate
        DATEADD(day, ABS(CHECKSUM(NEWID())) % 2008, '2019-01-01'),
        
        -- completedate
        NULL,
        
        -- Status 
		CASE ABS(CHECKSUM(NEWID())) % 3
			WHEN 0 THEN 3
			WHEN 1 THEN 2
			ELSE 1
		END,
        
        -- Class
        ABS(CHECKSUM(NEWID())) % 9 + 1,
        
        -- Program
        ABS(CHECKSUM(NEWID())) % 3 + 1,
        
        -- Mentor
        ABS(CHECKSUM(NEWID())) % 50 + 1,
        
        -- Fee complete
        0 
    );
    SET @countvar += 1;
END;



-- Populate Administration.Fee
DECLARE @feecounter INT = 1;
WHILE @feecounter <= 1000
BEGIN
    INSERT INTO Administration.Fee (trainee, fee, paydate)
    VALUES 
    (
        -- Trainee ID (randomly selected from 1 to 1000)
        --ABS(CHECKSUM(NEWID())) % 1000 + 1,
		@feecounter,
        
        -- State/Province
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 3000
            WHEN 1 THEN 1500
            WHEN 2 THEN 750
            ELSE 0
        END,

		-- Fee payment date 
        DATEADD(day, ABS(CHECKSUM(NEWID())) % 2968, '2018-01-01')
        
    );
    SET @feecounter += 1;
END;
GO 



-- Populate Trainee.Result 
DECLARE @resultcounter INT = 1;
WHILE @resultcounter <= 1000
BEGIN
	INSERT INTO Trainee.Result (trainee, quiz, midterm, final, project)
	VALUES
	(
	-- Trainee ID (randomly selected from 1 to 1000)
	ABS(CHECKSUM(NEWID())) % 1000 + 1,

    -- quiz (random integer between 1 and 5) i.e. quiz accounts for 5% of total exam score 
    ABS(CHECKSUM(NEWID())) % 5 + 1,
    
    -- midterm (random integer between 5 and 15) i.e. midterm accounts for 15% of total exam score 
    ABS(CHECKSUM(NEWID())) % 11 + 5,
    
    -- final (random integer between 10 and 30) i.e. final accounts for 30% of total exam score
    ABS(CHECKSUM(NEWID())) % 21 + 10,
    
    -- project (random integer between 30 and 50) i.e. project accounts for 50% of total exam score 
    ABS(CHECKSUM(NEWID())) % 21 + 30
	);
	SET @resultcounter += 1;
END;
GO
