/*
-----------------------------
Stored Procedure: Load Bronze Layer ( Source to Bronze)
-----------------------------
Script Purpose:
  This Stored Procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
  - Truncates the 'bronze' tables before loading the data
  - Uses BULK INSERT command to load data from csv files to the 'bronze' tables.

Parameters:
  None
  This stored Procedure does not accept any parameters or return any values

Usage Example:
  EXEC bronze.load_bronze
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/

-- Create a Stored Procedure for bronze layer

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

-- Timing of Loadings
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	-- ERROR HANDLING 'TRY-CATCH'
	BEGIN TRY
SET @batch_start_time = GETDATE();
		PRINT '';
		PRINT '====== Loading Bronze Layer =====';

		--	Tables for CAR

SET @start_time = GETDATE();
		PRINT '';
		PRINT '====== Loading CAR Table =====';
		-- first empty the table
		TRUNCATE TABLE bronze.car_eu_car_sales;
		-- load tyhe data in empty table
		BULK INSERT bronze.car_eu_car_sales
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/car/eu_car_sales.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();
		--Tables for ECON
		PRINT '';
		PRINT '====== Loading ECON Tables =====';
		-- first empty the table
		TRUNCATE TABLE bronze.econ_eu_country_data;
		-- load tyhe data in empty table
		BULK INSERT bronze.econ_eu_country_data
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/econ/eu_country_data.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();
		-- first empty the table
		TRUNCATE TABLE bronze.econ_eu_gdp_capita;
		-- load tyhe data in empty table
		BULK INSERT bronze.econ_eu_gdp_capita
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/econ/eu_gdp_capita.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';	

SET @start_time = GETDATE();
		 -- first empty the table
		TRUNCATE TABLE bronze.econ_eu_inflation;
		-- load tyhe data in empty table
		BULK INSERT bronze.econ_eu_inflation
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/econ/eu_inflation.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();
		 -- first empty the table
		TRUNCATE TABLE bronze.econ_eu_population;
		-- load tyhe data in empty table
		BULK INSERT bronze.econ_eu_population
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/econ/eu_population.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();
		-- Tables for NRG
		PRINT '';
		PRINT '====== Loading NRG Tables =====';
		-- first empty the table
		TRUNCATE TABLE bronze.nrg_eu_electricity_generation;
		-- load tyhe data in empty table
		BULK INSERT bronze.nrg_eu_electricity_generation
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/nrg/eu_electricity_generation.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();
		-- first empty the table
		TRUNCATE TABLE bronze.nrg_eu_electricity_prices;
		-- load tyhe data in empty table
		BULK INSERT bronze.nrg_eu_electricity_prices
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/nrg/eu_electricity_prices.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();
		-- first empty the table
		TRUNCATE TABLE bronze.nrg_eu_fuel_prices;
		-- load tyhe data in empty table
		BULK INSERT bronze.nrg_eu_fuel_prices
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1/nrg/eu_fuel_prices.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

--Batch timing
SET @batch_end_time = GETDATE();
PRINT''
PRINT'Loading bronze Layer finished'
PRINT'>>| Total Load Duration : '+CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR)+'sec';


	END TRY
	BEGIN CATCH
		PRINT '== ERROR OCCURED DURING LOADING bronze Layer ';
		PRINT 'Error Message'+ ERROR_MESSAGE();
		PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END

