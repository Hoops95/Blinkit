### Todo
# 1) DB Connection
## - Connection String
# 2) Load Files
## - File Format: CSV Only
## - Initial Preprocessing
## - (Optinal) LIMIT INSERTION 100 row
# 3) Save Files to DB
## Consider same schema for already existing tables
"""
This script:
1) Reads DB credentials securely using environment variables
2) Loads CSV files from a raw data folder
3) Inserts them into the bronze schema in PostgreSQL
4) Automatically generates table names based on filenames
===========================================================
"""

# ======================
#   1) IMPORTS
# ======================
import pandas as pd
import os
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Load variables from .env (NOT INCLUDED IN GITHUB)
load_dotenv()

# ======================
#   2) DB CONNECTION  (SECURE)
# ======================


DB_CONNECTION = dict(
    host=os.environ.get("DB_HOST"),
    port=os.environ.get("DB_PORT"),
    user=os.environ.get("DB_USER"),
    password=os.environ.get("DB_PASSWORD"),
    dbname=os.environ.get("DB_NAME")
)

# Create SQLAlchemy engine using environment variables
conn = create_engine(
    "postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}".format(**DB_CONNECTION)
)

# ======================
#   3) RAW DATA FOLDER  (SECURE)
# ======================


raw_folder = os.environ.get("RAW_DATA_PATH")  
# Example .env value:
# RAW_DATA_PATH="./data_raw"

if raw_folder is None:
    raise ValueError("❌ RAW_DATA_PATH not found in .env file.")


# ======================
#   4) LOAD CSV FILES
# ======================
print("\n=========== START LOADING RAW DATA FILES ===========\n")

for file in os.listdir(raw_folder):

    if file.endswith(".csv"):
        file_path = os.path.join(raw_folder, file)

        # Log visible (safe)
        print(f"Loading file: {file}")

        df = pd.read_csv(file_path)

        # Generate table name based on file name
        table_name = file.replace(".csv", "").lower()

        # ======================
        #   5) INSERT INTO BRONZE
        # ======================
        df.to_sql(
            name=table_name,
            con=conn,
            schema="bronze",
            if_exists="replace",   # replace table each time
            index=False
        )

        print(f"✔ Loaded into bronze.{table_name}")

print("\n----------- DONE LOADING DATA -----------\n")