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

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	BEGIN TRY 
		
		TRUNCATE TABLE bronze.car_eu_car_sales;
		BULK INSERT bronze.car_eu_car_sales
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\car\eu_car_sales.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		TRUNCATE TABLE bronze.econ_eu_country_data;
		BULK INSERT bronze.econ_eu_country_data
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\econ\eu_country_data.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


		TRUNCATE TABLE bronze.econ_eu_gdp_capita;
		BULK INSERT bronze.econ_eu_gdp_capita
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\econ\eu_gdp_capita.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		TRUNCATE TABLE bronze.econ_eu_inflation;
		BULK INSERT bronze.econ_eu_inflation
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\econ\eu_inflation.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		TRUNCATE TABLE bronze.econ_eu_population;
		BULK INSERT bronze.econ_eu_population
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\econ\eu_population.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		TRUNCATE TABLE bronze.nrg_eu_fuel_prices;
		BULK INSERT bronze.nrg_eu_fuel_prices
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\nrg\eu_fuel_prices.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		TRUNCATE TABLE bronze.nrg_eu_electricity_prices;
		BULK INSERT bronze.nrg_eu_electricity_prices
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\nrg\eu_electricity_prices.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		TRUNCATE TABLE bronze.nrg_eu_electricity_generation;
		BULK INSERT bronze.nrg_eu_electricity_generation
		FROM 'C:\Users\My Computer\Desktop\PROJECT_1\nrg\eu_electricity_generation.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

	END TRY
	BEGIN CATCH -- display the error messages
		PRINT ' - - - - - - - - - - - - - - '
		PRINT 'Error MEssage' + ERROR_MESSAGE();
		PRINT 'Error MEssage' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error MEssage' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH

END -- end of stored procedure
