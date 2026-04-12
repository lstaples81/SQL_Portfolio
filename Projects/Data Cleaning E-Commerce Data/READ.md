# Data Cleaning with SQL

## Overview
This project demonstrates how to clean and prepare raw data using SQL Server (T-SQL). 

The goal is to transform messy, inconsistent data into a structured and analysis-ready dataset by applying real-world data cleaning techniques used in business environments.

---

## Objectives
- Remove duplicate records
- Handle missing (NULL) values
- Standardize text fields and categories
- Fix inconsistent data entries
- Validate and prepare clean data for analysis

---

## Tools & Technologies
- SQL Server (T-SQL)
- GitHub

---

## Technical Skills Demonstrated
- Data cleaning and preprocessing
- Handling NULL values (IS NULL, UPDATE, DELETE)
- Removing duplicates using ROW_NUMBER()
- Data standardization (LTRIM, RTRIM, LOWER)
- Data type corrections (ALTER TABLE)
- Conditional logic (CASE statements)
- Data validation techniques

---

## Data Cleaning Steps

### 1. Data Inspection
- Reviewed raw data using SELECT statements
- Identified missing values and inconsistencies

### 2. Duplicate Removal
- Used ROW_NUMBER() to detect duplicates
- Removed duplicate records while preserving original entries

### 3. Handling Missing Values
- Replaced NULL values with defaults where appropriate
- Removed records with critical missing data

### 4. Data Standardization
- Trimmed extra spaces from text fields
- Standardized inconsistent values (e.g., country names, status labels)

### 5. Data Type Fixes
- Converted columns to appropriate data types (DATE, DECIMAL, INT)

### 6. Invalid Data Removal
- Removed negative values and incorrect records
- Filtered out unrealistic dates

### 7. Data Validation
- Verified row counts and data integrity
- Checked for remaining NULL values and inconsistencies

---

## Key Insights
- Real-world datasets often contain duplicates and inconsistent formatting
- Data cleaning is a critical step before any analysis
- Standardized data improves accuracy and reliability of results

---

## Business Value
- Ensures accurate reporting and analysis
- Improves data quality and consistency
- Reduces errors in decision-making
- Prepares datasets for downstream analytics and dashboards

---

## How to Use
1. Open SQL Server
2. Run the `cleaning.sql` script
3. Review the cleaned tables generated in the process

---

## Project Structure
- cleaning.sql → full data cleaning workflow
