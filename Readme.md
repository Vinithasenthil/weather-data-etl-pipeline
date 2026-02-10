# Weather Data ETL Pipeline

## Overview
This project implements an end-to-end ETL (Extract, Transform, Load) pipeline.
Weather data is cleaned, converted to CSV, and incrementally loaded into a
MySQL database with validation.


## Tech Stack
- Python
- Pandas
- MySQL
- SQLAlchemy
- PyMySQL


## Project Structure
Weather Data ETL Pipeline/
├── data/
│   ├── seattle-weather.xlsx
│   └── seattle_weather_cleaned.csv
├── data_cleaning.py
├── insert_into_mysql.py
├── weather_etl_pipeline.py
├── database_etl.sql
├── data_etl_queries.sql
├── requirements.txt
└── README.md


## Installation
Install required libraries:
pip install -r requirements.txt


## Step-by-Step Execution

### Step 1: Data Cleaning and CSV Creation
Run:
python data_cleaning.py

This step:
- Cleans and standardizes data
- Converts Excel to CSV
- Saves cleaned data as seattle_weather_cleaned.csv

### Step 2: Create Database and Table
Run the SQL file:
database_etl.sql

This creates:
- Database: weather_etl
- Table: seattle_weather


### Step 3: Incremental Load into MySQL
Run:
python insert_into_mysql.py

This step:
- Reads cleaned CSV
- Checks last loaded date in MySQL
- Loads only new records
- Prevents duplicate inserts


### Step 4: Validation
Run SQL queries from:
data_etl_queries.sql

This verifies:
- Record count
- Incremental load safety
- No duplicates
- No null values


## Incremental Load Behavior
- First run: full data load
- Re-run: no duplicate data inserted
- Safe to execute multiple times


## Project Status
ETL pipeline implemented, validated, and ready for evaluation.