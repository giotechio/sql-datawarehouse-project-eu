
-- GOLD LAYER country Dimention 
CREATE VIEW gold.dim_countries AS 
SELECT 
Country,
Capital,
Currency,
YEAR(EU_join_Year) AS EU_JOIN_YEAR,
area_sq_km,
language,
pol_system
  FROM [DWHEU].[silver].[econ_eu_country_data]



-- Gold Layer Fact View
CREATE VIEW gold.fact_CAR_NRG_ECON AS
SELECT 
	year(car.year) AS Year,
	car.Country,
	ISNULL(car.EV_sales,0) AS EV_sales,
	ISNULL(car.all_car_sales,0) AS Total_Car_sales,
	gen.gross_generation_TWH AS Total_el_gen_TWH,
	ep.price_kwh_eur AS electricity_price_KWH,
	fp.p_95_eur_l AS Petrol_price_litre,
	fp.dsl_eur_l AS Diesel_price_litre,
	gdp.GDP_capita AS GDP_Capita,
	pop.population AS Total_Population,
	infl.inflation_rate AS Inflation_Rate
FROM silver.car_eu_car_sales AS car
LEFT JOIN silver.nrg_eu_electricity_generation AS gen
ON car.year = gen.year AND car.country = gen.country
LEFT JOIN silver.nrg_eu_electricity_prices AS ep
ON car.year = ep.year AND car.country = ep.country
LEFT JOIN silver.nrg_eu_fuel_prices AS fp
ON car.year = fp.year AND car.country = fp.country
LEFT JOIN silver.econ_eu_gdp_capita AS gdp
ON car.year = gdp.year AND car.country = gdp.country
LEFT JOIN silver.econ_eu_population AS pop
ON car.year = pop.year AND car.country = pop.country
LEFT JOIN silver.econ_eu_inflation AS infl
ON car.year = infl.year AND car.country = infl.country
