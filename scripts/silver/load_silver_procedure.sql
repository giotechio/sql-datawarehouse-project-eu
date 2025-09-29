/*
=====================================
Stored Procedure: Load Silver Layer ( FROM Bronze to Silver)
-------------------------------------
Script Purpose:
This Stored Proceedure performs ETL process to populate the SILVER schema tables from the BRONZE schema.
Actions Performed:
- Truncates Silver Tables
- Inserts transformed and cleansed Data from bronze layer into silver layer Tables
- calculates times of loading each table together with total time of loading
- handles the errors durinmg the loading

Parameters:
No parameters needed

Usage: 

EXEC silver.load_silver
===================================
*/


-- Create Stored Procedure for Silver Layer

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
-- Timing of Loadings
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	-- ERROR HANDLING 'TRY-CATCH'
	BEGIN TRY
SET @batch_start_time = GETDATE();
		PRINT '';
		PRINT '====== Loading SILVER Layer =====';

		--				data Load script
		--	Tables for CAR
--Timing
SET @start_time = GETDATE();

		-- LOAD DATA INTO SILVER Layer Tables

		-- Car Sales table Load
		PRINT''
		PRINT '------ Load CAR Tables ------'
		TRUNCATE TABLE silver.car_eu_car_sales;
		INSERT INTO silver.car_eu_car_sales (
				year , country, EV_sales, all_car_sales, Non_EV_sales 
		)
		SELECT 
				year , country, EV_sales, all_car_sales, Non_EV_sales  
		FROM bronze.car_eu_car_sales ;
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();

		-- Country Data table Load
		PRINT''
		PRINT '------ Load ECON Tables ------'
		TRUNCATE TABLE silver.econ_eu_country_data;
		INSERT INTO silver.econ_eu_country_data (
				country
			  ,country_short
			  ,Capital
			  ,currency
			  ,currency_short
			  ,EU_join_Year
			  ,area_sq_km
			  ,language
			  ,pol_system
			  ,head_govt
			  ,head_state 
		)
		SELECT 
				country
			  ,country_short
			  ,Capital
			  ,currency
			  ,currency_short
			  ,EU_join_Year
			  ,area_sq_km
			  ,REPLACE(Upper(language),' ','') AS language
			  ,REPLACE (pol_system, '_',' ') AS pol_system
			  ,head_govt
			  ,head_state
		FROM bronze.econ_eu_country_data ;
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();

		-- GDP per Capita table Load
		
		TRUNCATE TABLE silver.econ_eu_gdp_capita;
		INSERT INTO silver.econ_eu_gdp_capita (
				year , country, GDP_capita 
		)
		SELECT 
				year , country, GDP_capita  
		FROM bronze.econ_eu_gdp_capita ;

SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();

		-- Inflation table Load
		
		TRUNCATE TABLE silver.econ_eu_inflation;
		INSERT INTO silver.econ_eu_inflation (
				year , country, inflation_rate 
		)
		SELECT 
				year , country, inflation_rate  
		FROM bronze.econ_eu_inflation ;
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();


		-- Population table Load
		
		TRUNCATE TABLE silver.econ_eu_population;
		INSERT INTO silver.econ_eu_population (
				year , country, population 
		)
		SELECT 
				year , country, population  
		FROM bronze.econ_eu_population ;
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();

		-- Electricity Generation table Load
		PRINT''
		PRINT '------ Load NRG Tables ------'
		TRUNCATE TABLE silver.nrg_eu_electricity_generation;
		INSERT INTO silver.nrg_eu_electricity_generation (
				year
			  ,country
			  ,Gross_Generation_TWh
			  ,hard_coal
			  ,brown_coal
			  ,Oil_petroleum
			  ,natural_gas
			  ,manufactured_gas
			  ,Nuclear
			  ,Hydro
			  ,Wind
			  ,Solid_biofuels
			  ,biogases
			  ,liquid_biofuels
			  ,solar
			  ,geothermal
			  ,tide_wave_ocean
			  ,non_renewable
			  ,gen_type_Electr_only
			  ,gen_type_CHP_plants
			  ,gen_type_Autoproducer_electricity_only
			  ,gen_type_Autoproducer_CHP_plants
			  ,Combustible_Fuels_MW
			  ,Nuclear_MW
			  ,Hydro_MW
			  ,Wind_MW
			  ,Solar_PV_M
			  ,Solar_thermal_MW
			  ,Geothermal_MW
			  ,Tide_Wave_Ocean_MW
			  ,Other_MW
		)
		SELECT 
					year
			  ,country
			  ,Gross_Generation_TWh
			  ,hard_coal
			  ,brown_coal
			  ,Oil_petroleum
			  ,natural_gas
			  ,manufactured_gas
			  ,Nuclear
			  ,Hydro
			  ,Wind
			  ,Solid_biofuels
			  ,biogases
			  ,liquid_biofuels
			  ,solar
			  ,geothermal
			  ,tide_wave_ocean
			  ,non_renewable
			  ,gen_type_Electr_only
			  ,gen_type_CHP_plants
			  ,gen_type_Autoproducer_electricity_only
			  ,gen_type_Autoproducer_CHP_plants
			  ,Combustible_Fuels_MW
			  ,Nuclear_MW
			  ,Hydro_MW
			  ,Wind_MW
			  ,Solar_PV_M
			  ,Solar_thermal_MW
			  ,Geothermal_MW
			  ,Tide_Wave_Ocean_MW
			  ,Other_MW  
		FROM bronze.nrg_eu_electricity_generation 
		WHERE Gross_Generation_TWh IS NOT NULL;
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @start_time = GETDATE();


		-- Electricity Prices table Load
		
		TRUNCATE TABLE silver.nrg_eu_electricity_prices;
		INSERT INTO silver.nrg_eu_electricity_prices (
				year , country, price_kwh_eur 
		)
		SELECT 
				year , country, price_kwh_eur  
		FROM bronze.nrg_eu_electricity_prices ;


		-- Fuel Prices table Load
		
		TRUNCATE TABLE silver.nrg_eu_fuel_prices;
		INSERT INTO silver.nrg_eu_fuel_prices (
				year , country, p_95_eur_l, dsl_eur_l 
		)
		SELECT 
				year , country, p_95_eur_l, dsl_eur_l 
		FROM bronze.nrg_eu_fuel_prices ;
SET @end_time = GETDATE();
PRINT'>> Load Duration : '+CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+'sec';

SET @batch_end_time = GETDATE();
PRINT''
PRINT'------Loading SILVER Layer finished ------'
PRINT'>>| Total Load Duration : '+CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR)+'sec';


	END TRY
	BEGIN CATCH
		PRINT '== ERROR OCCURED DURING LOADING bronze Layer ';
		PRINT 'Error Message'+ ERROR_MESSAGE();
		PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH


END

-- EXEC silver.load_silver
