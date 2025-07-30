
/*
---------------------
Create Database and Schemas
---------------------

Script Purpose:
  This script creates a database named "DWHEU" after cheking if it already exists.
If the database exists , it will be droped and recreated. 
The script creates three schemas within the database, named: 'bronze','silver'and 'gold'.

!! Warning !!
  This script will permanently drop the database "DWHEU". All the data contained in this 
database will be permanently deleted. 
If you need the data , make a copy or a backup before running this script.
*/



USE master;
GO

-- Drop and recreate the "DWHEU" database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DWHEU')
BEGIN
  ALTER DATABASE DWHEU SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DWHEU;
END;
GO

-- Create the databse 'DWHEU'
CREATE DATABASE DWHEU
GO

USE DWHEU;

--Create Schemas
GO 
CREATE SCHEMA bronze;

GO 
CREATE SCHEMA silver;

GO 
CREATE SCHEMA gold;




