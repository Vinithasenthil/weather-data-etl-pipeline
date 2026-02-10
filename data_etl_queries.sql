USE weather_etl;
-- TOPIC 1: BASIC LOAD VALIDATION
-- Purpose: Verify data is loaded successfully

SELECT COUNT(*) AS total_records
FROM seattle_weather;

-- TOPIC 2: INCREMENTAL LOAD VALIDATION
-- Purpose: Identify latest record for incremental logic

SELECT MAX(date) AS last_loaded_date
FROM seattle_weather;

SELECT MIN(date) AS first_loaded_date
FROM seattle_weather;

-- TOPIC 3: DUPLICATE RECORD CHECK
-- Purpose: Ensure no duplicate records exist

SELECT date, COUNT(*) AS duplicate_count
FROM seattle_weather
GROUP BY date
HAVING COUNT(*) > 1;

-- TOPIC 4: NULL VALUE CHECK (DATA QUALITY)
-- Purpose: Validate data cleaning effectiveness

SELECT
    SUM(date IS NULL) AS null_dates,
    SUM(precipitation IS NULL) AS null_precipitation,
    SUM(temp_max IS NULL) AS null_temp_max,
    SUM(temp_min IS NULL) AS null_temp_min,
    SUM(wind IS NULL) AS null_wind,
    SUM(weather IS NULL) AS null_weather
FROM seattle_weather;

-
-- TOPIC 5: WEATHER CATEGORY DISTRIBUTION
-- Purpose: Understand data distribution

SELECT weather, COUNT(*) AS weather_count
FROM seattle_weather
GROUP BY weather
ORDER BY weather_count DESC;

-- TOPIC 6: TEMPERATURE SUMMARY STATISTICS
-- Purpose: Validate numeric data correctness

SELECT
    AVG(temp_max) AS avg_max_temperature,
    AVG(temp_min) AS avg_min_temperature,
    MAX(temp_max) AS highest_temperature,
    MIN(temp_min) AS lowest_temperature
FROM seattle_weather;

-- TOPIC 7: DAILY RECORD CONSISTENCY CHECK
-- Purpose: Ensure records are properly distributed by date

SELECT date, COUNT(*) AS records_per_day
FROM seattle_weather
GROUP BY date
ORDER BY date;

-- TOPIC 8: INCREMENTAL SAFETY CHECK
-- Purpose: Confirm re-running ETL does not duplicate data

SELECT COUNT(*) AS total_records_after_rerun
FROM seattle_weather;
