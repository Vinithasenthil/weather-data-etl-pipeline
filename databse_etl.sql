create database weather_etl;
use weather_etl;
CREATE TABLE seattle_weather (
    date DATE,
    precipitation FLOAT,
    temp_max FLOAT,
    temp_min FLOAT,
    wind FLOAT,
    weather VARCHAR(50)
);
select*from seattle_weather;
select count(*) FROM 
seattle_weather;


