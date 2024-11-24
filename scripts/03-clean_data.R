#### Preamble ####
# Purpose: Cleans the raw data so variable is easier to call.
# Author: Mandy He
# Date: 23 November 2024
# Contact: mandyxy.he@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)
library(dplyr)       # For data manipulation
library(tidyr)       # For handling missing data
library(stringr)     # For string operations
library(readr)       # For reading CSV files


#### Clean Data ####

# Read the raw data
raw <- read_csv("data/01-raw_data/raw_data.csv")

# Clean column names by removing spaces and adjusting specific columns
colnames(raw) <- gsub(" ", "_", colnames(raw))
colnames(raw) <- gsub("RFx_\\(Solicitation\\)_Type", "RFx_Type", colnames(raw))


# Handle missing values by filtering out rows with critical missing data
contract_cleaned <- data %>%
  filter(!is.na(Awarded_Amount) & Awarded_Amount > 0) %>%         # Remove rows where Awarded_Amount is missing
  filter(!is.na(Successful_Supplier)) %>%    # Remove rows with missing supplier names
  filter(!is.na(Division)) %>%               # Remove rows with missing Division
  filter(!is.na(Award_Date))                 # Remove rows with missing Award Date


# Step 4: Standardize the supplier names by converting to Title Case
contract_cleaned <- contract_cleaned %>%
  mutate(Successful_Supplier = str_to_title(Successful_Supplier))  # Capitalize each word in supplier names

# Step 5: Remove exact duplicate rows
contract_cleaned <- contract_cleaned %>%
  distinct()  # Removes duplicate rows

# Step 6: Select relevant columns for analysis
contract_cleaned <- contract_cleaned %>%
  select(
    unique_id,
    Document_Number,
    RFx_Type,
    High_Level_Category,
    Successful_Supplier,
    Awarded_Amount,
    Award_Date,
    Division
  )

# Step 7: Optional - Classify small businesses based on Awarded_Amount (threshold example: 500,000)
small_business_threshold <- 500000  # Define the threshold for small business classification
contract_cleaned <- contract_cleaned %>%
  mutate(Small_Business = ifelse(Awarded_Amount <= small_business_threshold, TRUE, FALSE))

# Step 8: Check for any remaining missing values after the cleaning process
summary(contract_cleaned)  # Summary of cleaned data

# Step 9: Save the cleaned data to a new CSV file for analysis
write_csv(contract_cleaned, "data/02-analysis_data/analysis_data.csv")

# Preview the cleaned data
head(contract_cleaned)

median(contract_cleaned$Awarded_Amount)
