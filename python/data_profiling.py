import pandas as pd
import numpy as np

# -----------------------------
# Load Dataset
# -----------------------------

file_path = "../data/raw/global_superstore_2016.xlsx"

df = pd.read_excel(file_path, sheet_name="Orders")

print("=" * 60)
print("GLOBAL RETAIL DATA PROFILING")
print("=" * 60)

# -----------------------------
# Basic Information
# -----------------------------

print("\nDataset Shape:")
print(df.shape)

print("\nRows:", df.shape[0])
print("Columns:", df.shape[1])

print("\nColumn Names:")
print(df.columns.tolist())

# -----------------------------
# Data Types
# -----------------------------

print("\nData Types:")
print(df.dtypes)

# -----------------------------
# Missing Values
# -----------------------------

print("\nMissing Values:")
print(df.isnull().sum())

# -----------------------------
# Duplicate Rows
# -----------------------------

duplicates = df.duplicated().sum()

print("\nDuplicate Rows:", duplicates)

# -----------------------------
# Unique Values
# -----------------------------

print("\nUnique Values Per Column:")

for col in df.columns:
    print(f"{col}: {df[col].nunique()}")

# -----------------------------
# Summary Statistics
# -----------------------------

print("\nSummary Statistics:")

print(df.describe())

# -----------------------------
# Numeric Columns
# -----------------------------

numeric_cols = df.select_dtypes(include=np.number).columns

print("\nNumeric Columns:")

print(numeric_cols)

# -----------------------------
# Negative Values
# -----------------------------

print("\nNegative Profit Records:")

print((df["Profit"] < 0).sum())

# -----------------------------
# Zero Sales
# -----------------------------

print("\nZero Sales Records:")

print((df["Sales"] == 0).sum())

# -----------------------------
# Date Range
# -----------------------------

print("\nOrder Date Range:")

print(df["Order Date"].min())

print(df["Order Date"].max())

# -----------------------------
# Top Categories
# -----------------------------

print("\nCategory Counts:")

print(df["Category"].value_counts())

# -----------------------------
# Top Markets
# -----------------------------

print("\nMarket Counts:")

print(df["Market"].value_counts())

print("\nData Profiling Completed Successfully!")