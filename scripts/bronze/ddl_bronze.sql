/*
-----------------------------------
DDL script: Create 'bronze' Tables
-----------------------------------
Script Purpose :
  This script creates tables in the 'bronze' schema, dropping existing tables if any.
Run this script to re-define the DDL structure of the 'bronze' tables.
*/

-- DDL for Bronze Layer, Create Tables

--T_SQL - check if tables already exist

-- Tables for CAR
IF OBJECT_ID ('bronze.car_eu_car_sales', 'U') IS NOT NULL
	DROP TABLE bronze.car_eu_car_sales;

	CREATE TABLE bronze.car_eu_car_sales (
		year DATE,
		country NVARCHAR(50),
		EV_sales INT,
		all_car_sales INT,
		Non_EV_sales INT

		);

-- Tables for ECON
IF OBJECT_ID ('bronze.econ_eu_country_data', 'U') IS NOT NULL
	DROP TABLE bronze.econ_eu_country_data;

	CREATE TABLE bronze.econ_eu_country_data (
		country NVARCHAR(50),
		country_short NVARCHAR(50),
		Capital NVARCHAR(50),
		currency NVARCHAR(50),
		currency_short NVARCHAR(50),
		EU_join_Year DATE,
		area_sq_km INT,
		language NVARCHAR(50),
		pol_system NVARCHAR(50),
		head_govt NVARCHAR(50),
		head_state NVARCHAR(50)
	
		);

IF OBJECT_ID ('bronze.econ_eu_gdp_capita', 'U') IS NOT NULL
	DROP TABLE bronze.econ_eu_gdp_capita;
	CREATE TABLE bronze.econ_eu_gdp_capita (
		year DATE,
		country NVARCHAR(50),
		GDP_capita INT

	);

IF OBJECT_ID ('bronze.econ_eu_inflation', 'U') IS NOT NULL
	DROP TABLE bronze.econ_eu_inflation;
	CREATE TABLE bronze.econ_eu_inflation (
		year DATE,
		country NVARCHAR(50),
		inflation_rate float

	);

IF OBJECT_ID ('bronze.econ_eu_population', 'U') IS NOT NULL
	DROP TABLE bronze.econ_eu_population;
	CREATE TABLE bronze.econ_eu_population (
		year DATE,
		country NVARCHAR(50),
		population INT

	);

-- Tables for NRG
IF OBJECT_ID ('bronze.nrg_eu_electricity_generation', 'U') IS NOT NULL
	DROP TABLE bronze.nrg_eu_electricity_generation;
	CREATE TABLE bronze.nrg_eu_electricity_generation (
		year DATE,
		country NVARCHAR(50),
		Gross_Generation_TWh FLOAT,
		hard_coal FLOAT,
		brown_coal FLOAT,
		Oil_petroleum FLOAT,
		natural_gas FLOAT,
		manufactured_gas FLOAT,
		Nuclear FLOAT,
		Hydro FLOAT,
		Wind FLOAT,
		Solid_biofuels FLOAT,
		biogases FLOAT,
		liquid_biofuels FLOAT,
		solar FLOAT,
		geothermal FLOAT,
		tide_wave_ocean FLOAT,
		non_renewable FLOAT,
		gen_type_Electr_only FLOAT,
		gen_type_CHP_plants FLOAT,
		gen_type_Autoproducer_electricity_only FLOAT,
		gen_type_Autoproducer_CHP_plants FLOAT,
		Combustible_Fuels_MW FLOAT,
		Nuclear_MW FLOAT,
		Hydro_MW FLOAT,
		Wind_MW FLOAT,
		Solar_PV_M FLOAT,
		Solar_thermal_MW FLOAT,
		Geothermal_MW FLOAT,
		Tide_Wave_Ocean_MW FLOAT,
		Other_MW FLOAT

	);

IF OBJECT_ID ('bronze.nrg_eu_electricity_prices', 'U') IS NOT NULL
	DROP TABLE bronze.nrg_eu_electricity_prices;
	
	CREATE TABLE bronze.nrg_eu_electricity_prices (

		year DATE,
		country NVARCHAR(50),
		price_kwh_eur FLOAT

	);

IF OBJECT_ID ('bronze.nrg_eu_fuel_prices', 'U') IS NOT NULL
	DROP TABLE bronze.nrg_eu_fuel_prices;
	CREATE TABLE bronze.nrg_eu_fuel_prices (
		year DATE,
		country NVARCHAR(50),
		p_95_eur_l FLOAT,
		dsl_eur_l FLOAT

	);
