I strongly advise that you go through the PDF in the "Documentation" folder before you proceed. 
Also, I have a post on LinkedIn that contains extra information that you may want to checkout.


INSTRUCTIONS 
============

Download the entire package containing the SQL Scripts 

NB: 
	This database design has been implemented using T-SQL (MS SQL Server). 
	So, if you are using a different Database Management System you might have to make a few adjustments to the script so that the syntax conforms with your DBMS.
	
	The script that creates the database tables [JITSolutions 1 - DatabaseCreation.sql] creates specific files in specific locations on your system.
	To have the script run smoothly on your environment you have to create the same disk partitions, folders and file names.
	Otherwise, you have to modify that section of the script so it reflects the structure of your environment 
	
	Once you have made all the modifications specified above you can run the scripts. 
	If you're using MS SQL Server and you've made all the necessary adjustments and you still get errors, consider removing the "GO" statement, then running the scripts one segment at a time.
	
	
	Run the scripts in this order:
	
	1) JITSolutions 1 - DatabaseCreation.sql (after successfully running this first script, use SSMS to generate a database diagram before you proceed with the other scripts) 
	
	2) JITSolutions 2 - ViewsCreation.sql 
	
	3) JITSolutions 3 - StoredProceduresCreation.sql 
	
	4) JITSolutions 4 - DatabasePopulation.sql
	
	5) JITSolutions 5 - TestingViews-Procedures.sql  (This script is meant for testing purposes. Run one line at a time.)
	
	6) JITSolutions 6 - LinkedServers.sql (Before running this one, create a linked server with the exact same name as the one on the script. Also download and restore the AdventureWorks database used in the script. Either that or you modify the script to conform with an existing database on your system)  
	
	7) JITSolutions 7 - TempTables.sql (this also need AdventureWorks database, or you modify the script to conform with an existing database on your system)
	
	8) JITSolutions 8 - DMLTrigger.sql (first run lines 1 to 29 to create the AUDIT, then run lines 30 to 90 to create the TRIGGER. the rest is for testing) 




NB: I took the project a little beyong database design. So once you've successfully run scripts 1 to 5 you can stop if your interest doesn't go beyond database design. 
This pet project is a work-in-progress, so I welcome any suggestions on how to make it better. 

