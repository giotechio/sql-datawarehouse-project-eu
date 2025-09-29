
/*
=====================
Quality Checks
---------------------
Script Purpose:

  The script perorms various chacks for :
- Null or duplicate primary keys
- Unwanted spaces in string fields
- etc
Perform all check for all the Tables in the Database
Make sure the PKs are correct in all tables to make joins in the future.
*/

--IF everything is fine than load the data into the silver Layer
-- Or load the corrected data into silverlaer Tables

-- Check primary key problems { All Tables }
-- Expectation NO RESULT
SELECT
CONCAT (YEAR(YEAR), ' ', TRIM(country)) AS CompKey,
COUNT(*) AS 'Bad_if > 1'
FROM bronze.econ_eu_inflation
GROUP BY CONCAT (YEAR(YEAR), ' ', TRIM(country))
HAVING COUNT(*) > 1 OR CONCAT(YEAR(YEAR), ' ', TRIM(country)) IS NULL;

-- tables without a year in KEY
-- Expectation NO RESULT
SELECT
TRIM(country) AS Country,
COUNT(*) AS 'Bad_if > 1'
FROM bronze.econ_eu_country_data
GROUP BY  TRIM(country)
HAVING COUNT(*) > 1 OR  TRIM(country) IS NULL;


-- Check for unwanted spaces
-- Expectation NO RESULT
SELECT
country
FROM bronze.econ_eu_country_data
WHERE country != TRIM(country)

-- Data Standartization and Consistency
-- EXPECTATION : 27 Distinct Countrues
SELECT DISTINCT country
FROM bronze.nrg_eu_electricity_generation;


-- Expectation : At least from 2016 to 2024 including
SELECT DISTINCT year(year) AS YEAR
FROM bronze.nrg_eu_fuel_prices;


-- Check NULLs in Car Sales 
-- If EV sales Null Then make it 0
-- if both EV and Car total are NULLS then remove the row

SELECT 
	EV_sales, 
	All_car_sales,
	ISNULL(EV_sales, 0) AS EV_SALES

FROM bronze.car_eu_car_sales
WHERE all_car_sales IS NOT NULL;


-- Check El_generation tables for NULLS 
-- If there are NULLS in gross Genereation - remove the raw as there is no data for that year


SELECT
*
FROM bronze.nrg_eu_electricity_generation
WHERE Gross_Generation_TWh IS NOT NULL;


-- Country Data chech and correct

SELECT	
country,
REPLACE(Upper(language),' ','') AS language,
REPLACE (pol_system, '_',' ') AS pol_system
FROM bronze.econ_eu_country_data;
