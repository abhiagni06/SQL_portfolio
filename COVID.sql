--COVID19 INDIA LATEST MAY'22 OVERVIEW:

--creating the table covid in public schema
CREATE TABLE public.covid
(
  states_uts character varying(150) NOT NULL,
  total_cases bigint NOT NULL,
  active bigint NOT NULL,
  discharged bigint NOT NULL,
  deaths bigint NOT NULL,
  active_ratio DECIMAL NOT NULL,
  recovery_ratio DECIMAL NOT NULL,
  death_ratio DECIMAL NOT NULL,
  population bigint NOT NULL,
  PRIMARY KEY (states_uts)
);

ALTER TABLE IF EXISTS public.covid
    OWNER to postgres;
    
--Created empty table covid check
SELECT * FROM covid

--importing data from covid.csv
COPY PUBLIC.covid FROM 'C:\Users\Abhishek\Desktop\Datasets\rough\Latest Covid-19 India Statusupdate.csv' DELIMITER ',' CSV HEADER;

--covid table all data
SELECT * FROM covid

--What are the total cases values, active cases,discharged cases,
--deaths,active ratio,recovery ratio, death ratio, percent infected
--creating the table according to requirement

SELECT SUM(population) AS total_population,
SUM(total_cases)ind_total_cases,ROUND((SUM(total_cases)/SUM(population))*100,2) AS PERCENT_INFECTED,
SUM(active)ind_active,ROUND((SUM(active)/SUM(total_cases))*100,3) AS ACTIVE_RATIO,
SUM(discharged)ind_discharged,ROUND((SUM(discharged)/SUM(total_cases))*100,2) AS recovery_RATIO,
SUM(deaths)ind_deaths,ROUND((SUM(deaths)/SUM(total_cases))*100,2) AS DEATH_RATIO
FROM covid

--TOP 10s with total cases values, active cases,discharged cases,
--deaths,active ratio,recovery ratio, death ratio, percent infected
--creating the table according to requirement

SELECT * ,ROUND((total_cases/population)*100,2) AS percent_infected
FROM covid
ORDER BY total_cases DESC
LIMIT 10;

--Bottom 10s with total cases values, active cases,discharged cases,
--deaths,active ratio,recovery ratio, death ratio, percent infected
--creating the table according to requirement

SELECT * ,ROUND((total_cases/population)*100,2) AS percent_infected
FROM covid
ORDER BY total_cases
LIMIT 10;

--COMPARISON total cases vs discharged
SELECT states_uts,total_cases,discharged FROM covid
ORDER BY total_cases DESC

--COMPARISON total cases vs deaths
SELECT states_uts,total_cases,deaths FROM covid
ORDER BY total_cases DESC

--Highest deaths
SELECT states_uts,deaths FROM covid
ORDER BY deaths DESC
LIMIT 10;

--Highest death ratio
SELECT states_uts,death_ratio FROM covid
ORDER BY death_ratio DESC
LIMIT 10;

--Highest recovery ratio
SELECT states_uts,recovery_ratio FROM covid
ORDER BY recovery_ratio DESC
LIMIT 10;

--Lowest recovery ratio
SELECT states_uts,recovery_ratio FROM covid
ORDER BY recovery_ratio 
LIMIT 10;

--Hotspots on map
SELECT states_uts,total_cases FROM covid
ORDER BY total_cases DESC;