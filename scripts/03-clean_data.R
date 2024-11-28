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
colnames(raw)[colnames(raw) == "_id"] <- "id"
raw$High_Level_Category <- gsub("Goods & Services", "Goods and Services", raw$High_Level_Category)
raw$Awarded_Amount <- as.numeric(raw$Awarded_Amount)



# Handle missing values by filtering out rows with critical missing data
contract_cleaned <- raw %>%
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
    id,
    unique_id,
    Document_Number,
    RFx_Type,
    High_Level_Category,
    Successful_Supplier,
    Awarded_Amount,
    Award_Date,
    Division
  )

#### Step 7: Classify small businesses ####
# List of big businesses (your provided list)
big_business_list <- c(
  "Guillevin International Co.",
  "Sysco",
  "Sysco Toronto, A Division Of Sysco Canada Inc.",
  "Stantec Consulting Ltd",
  "Kpmg Llp",
  "Kpmg",
  "Bennett Mechanical Installations",
  "Fer-Pal Construction Ltd.",
  "Wsp Canada Inc",
  "Black And Mcdonald Limited",
  "Thermo Fisher Scientific",
  "Sutherland Schultz Ltd",
  "Morrison Hershfield Limited",
  "Morrison Hershfield",
  "Metro Freightliner Hamilton Inc",
  "Ricoh Canada Inc",
  "Altus Group Limited",
  "Kroll Consulting Canada Co.",
  "Suncorp Valuations",
  "Logixx Security Inc",
  "Garda Canada Security Corporation",
  "Drake International Inc",
  "Bevertec Cst Inc",
  "Aecom Canada Ltd",
  "Stericycle Ulc",
  "Schindler Elevator Corporation",
  "Graham Bros Construction Ltd.",
  "Morrison Hershfield Limited",
  "Softchoice Lp",
  "Damen Shipbuilding 5 B.v.",
  "Graham Bros Construction Ltd.",
  "Gartner Canada",
  "Parsons Inc",
  "Jacobs Consultancy Canada Inc",
  "Stericycle, Ulc"
)

# Ensure the Successful_Supplier column is character type and remove extra spaces
contract_cleaned$Successful_Supplier <- str_trim(as.character(contract_cleaned$Successful_Supplier))

# Create a new column for the lowercase version of the Successful_Supplier
contract_cleaned$Lowercase_Supplier <- tolower(contract_cleaned$Successful_Supplier)

# Perform the comparison to classify as Small_Business
contract_cleaned$Small_Business <- ifelse(
  contract_cleaned$Lowercase_Supplier %in% tolower(big_business_list), 
  FALSE,  # If the supplier (in lowercase) is in the big business list, it's not a small business
  TRUE    # Otherwise, it's considered a small business
)

# Optionally, remove the Lowercase_Supplier column after classification
contract_cleaned <- contract_cleaned %>%
  select(-Lowercase_Supplier)

# Step 8: Check for any remaining missing values after the cleaning process
summary(contract_cleaned)  # Summary of cleaned data

# Step 9: Save the cleaned data to a new CSV file for analysis
write_csv(contract_cleaned, "data/02-analysis_data/analysis_data.csv")

# Preview the cleaned data
head(contract_cleaned)


