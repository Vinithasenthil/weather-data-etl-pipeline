import pandas as pd

# ---------- COLLECT / EXTRACT ----------
input_file = "data/seattle-weather.xlsx"
df = pd.read_excel(input_file)

print("Data extracted")
print(df.head())

# ---------- TRANSFORM ----------
# Remove duplicates
df = df.drop_duplicates()

# Handle missing values
df = df.fillna({
    "precipitation": 0,
    "temp_max": df["temp_max"].mean(),
    "temp_min": df["temp_min"].mean(),
    "wind": df["wind"].mean()
})

# Standardize column names
df.columns = df.columns.str.lower()

# Convert date column
df["date"] = pd.to_datetime(df["date"])

# Standardize weather column
df["weather"] = df["weather"].str.title()

print(f"Rows processed after cleaning: {len(df)}")


# Data quality check
assert df.isnull().sum().sum() == 0
print("Data cleaned and transformed")

# ---------- CONVERT TO CSV ----------
output_file = "data/seattle_weather_cleaned.csv"
df.to_csv(output_file, index=False)

print("Excel converted to cleaned CSV successfully")

