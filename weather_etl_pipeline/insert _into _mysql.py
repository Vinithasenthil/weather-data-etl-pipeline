import pandas as pd
from sqlalchemy import create_engine, text

# ---------- CONFIG ----------
CSV_FILE = "data/seattle_weather_cleaned.csv"
DB_URL = "mysql+pymysql://root:Babirusa%402003@localhost/weather_etl"
TABLE_NAME = "seattle_weather"

# ---------- CONNECT ----------
engine = create_engine(DB_URL)

# ---------- READ CSV ----------
df = pd.read_csv(CSV_FILE)
df["date"] = pd.to_datetime(df["date"])

# ---------- GET MAX DATE FROM DB ----------
with engine.connect() as conn:
    result = conn.execute(
        text(f"SELECT MAX(date) FROM {TABLE_NAME}")
    ).fetchone()

max_date = result[0]

print(f"Last date in DB: {max_date}")

# ---------- FILTER NEW RECORDS ----------
if max_date is not None:
    df_incremental = df[df["date"] > pd.to_datetime(max_date)]
else:
    df_incremental = df  # first run

print(f"New rows to load: {len(df_incremental)}")

# ---------- LOAD ONLY NEW DATA ----------
if not df_incremental.empty:
    df_incremental.to_sql(
        name=TABLE_NAME,
        con=engine,
        if_exists="append",
        index=False
    )
    print("Incremental load completed")
else:
    print("No new data to load")
