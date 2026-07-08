import pandas as pd
import numpy as np
import csv
import os

print("="*60)
print("GLOBAL RETAIL DATA CLEANING & FEATURE ENGINEERING")
print("="*60)

# ---------------------------------------------------
# Load Dataset
# ---------------------------------------------------

file_path = "../data/raw/global_superstore_2016.xlsx"

df = pd.read_excel(file_path, sheet_name="Orders")

print("\nDataset Loaded Successfully!")

# ---------------------------------------------------
# Remove Leading & Trailing Spaces
# ---------------------------------------------------

text_columns = df.select_dtypes(include=["object", "string"]).columns

for col in text_columns:
    df[col] = df[col].str.strip()

print("✓ Text cleaned")

# ---------------------------------------------------
# Handle Missing Postal Code
# ---------------------------------------------------

df["Postal Code"] = df["Postal Code"].fillna(0)

print("✓ Missing Postal Codes handled")

# ---------------------------------------------------
# Feature Engineering
# ---------------------------------------------------

# Delivery Days
df["Delivery Days"] = (
    df["Ship Date"] - df["Order Date"]
).dt.days

# Order Year
df["Order Year"] = df["Order Date"].dt.year

# Order Month Number
df["Order Month"] = df["Order Date"].dt.month

# Month Name
df["Month Name"] = df["Order Date"].dt.strftime("%B")

# Quarter
df["Quarter"] = df["Order Date"].dt.quarter

# Weekday
df["Weekday"] = df["Order Date"].dt.day_name()

print("✓ Date features created")

# ---------------------------------------------------
# Profit Margin
# ---------------------------------------------------

df["Profit Margin %"] = np.where(
    df["Sales"] != 0,
    (df["Profit"] / df["Sales"]) * 100,
    0
)

print("✓ Profit Margin calculated")

# ---------------------------------------------------
# Loss Flag
# ---------------------------------------------------

df["Is Loss Order"] = np.where(
    df["Profit"] < 0,
    "Yes",
    "No"
)

print("✓ Loss Flag created")

# ---------------------------------------------------
# Discount Category
# ---------------------------------------------------

def discount_category(x):

    if x == 0:
        return "No Discount"

    elif x <= 0.2:
        return "Low"

    elif x <= 0.5:
        return "Medium"

    else:
        return "High"

df["Discount Category"] = df["Discount"].apply(discount_category)

print("✓ Discount Category created")

# ---------------------------------------------------
# Data Quality Check
# ---------------------------------------------------

print("\nFinal Shape:")

print(df.shape)

print("\nMissing Values:")

print(df.isnull().sum().sum())

print("\nDuplicate Rows:")

print(df.duplicated().sum())

# ---------------------------------------------------
# Save Clean Dataset
# ---------------------------------------------------



output_dir = "../data/cleaned"
os.makedirs(output_dir, exist_ok=True)

output_file = os.path.join(output_dir, "global_superstore_cleaned.csv")

df.to_csv(
    output_file,
    index=False,
    encoding="utf-8",
    quoting=csv.QUOTE_MINIMAL,
    escapechar="\\"
)

print("Saved successfully!")
print(os.path.abspath(output_file))