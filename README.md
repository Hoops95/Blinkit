# BlinkitBlinkit Grocery Analytics Project 🚀

Building a modern **data warehouse** for Blinkit using **Python + PostgreSQL**, following **Medallion Architecture (Bronze → Silver → Gold)**.  
This project demonstrates a complete **end-to-end data pipeline** from raw data ingestion to analytics-ready tables, designed for Power BI dashboards (coming soon).

---

## 📊 Project Highlights

- **Data Engineering**: ETL pipeline from raw CSVs → Bronze → Silver → Gold  
- **Data Cleaning & Standardization**: Ensures high-quality, reliable data  
- **Data Modeling**: Fact & Dimension tables (Fact Constellation)  
- **Business Intelligence**: Power BI dashboards (under development)  

---

## 🏗 Architecture & Medallion Layers

### 🥉 Bronze Layer – Raw Data
- Load raw CSV files from Blinkit datasets  
- No transformations applied  
- Maintains original data for traceability and auditing  

### 🥈 Silver Layer – Cleaned & Standardized Data
- Clean and validate data  
- Remove duplicates, handle missing values  
- Standardize formats (dates, numeric fields, IDs, emails, etc.)  
- Create flags and helper columns (e.g., `is_delayed_flag`)  

### 🥇 Gold Layer – Analytics-Ready Data
- Fact and Dimension tables for analytics  
- Apply business rules (sales, delivery, inventory, marketing)  
- Curated dataset ready for dashboards  

---

## 🔄 Data Pipeline Workflow

1. Extract raw data from CSV files (`data_raw/`)  
2. Load into **Bronze** layer using `scripts/Load_Data.py`  
3. Clean, validate, and standardize data in **Silver** layer (`sql/silver.sql`)  
4. Transform into **Gold** layer (fact & dimension tables) (`sql/gold.sql`)  
5. Connect **Power BI** for interactive dashboards and insights  

## 🧰 Technologies Used
- Python (pandas, sqlalchemy)
- PostgreSQL 14+
- pgAdmin
- dotenv
- SQL DDL + DML
- Medallion Architecture
- VS Code
-Power BI 

# Blinkit Dashboard (Continued)
