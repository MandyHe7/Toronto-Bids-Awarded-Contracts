#### Preamble ####
# Purpose: Testing and verify that the Clean data is not missing any value and it is ready to use.
# Author: Mandy He
# Date: 23 November 2024
# Contact: mandyxy.he@mail.utoronto.ca
# License: N/A
# Pre-requisites:
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(dplyr)

data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####


# Test 1: Check for missing values in key columns
missing_values <- colSums(is.na(data))
cat("Missing Values:\n")
print(missing_values)

# Check if there are missing values in 'Awarded_Amount', 'RFx_Type', 'Award_Date', and 'Document_Number'
critical_columns <- c("Document_Number", "RFx_Type", "Awarded_Amount", "Award_Date")
missing_critical <- colSums(is.na(data[, critical_columns]))
cat("\nMissing values in critical columns:\n")
print(missing_critical)

# Test 2: Check for duplicates in 'Document_Number'
duplicates_document_number <- any(duplicated(data$Document_Number))
duplicates_document_number <- any(duplicated(data$unique_id, ))

cat("\nAre there duplicates in 'Document_Number'?", duplicates_document_number, "\n")
cat("Are there duplicates in 'Unique_ID'?", duplicates_unique_id, "\n")


# Test 3: Check the range of 'Awarded_Amount'
cat("\nRange of 'Awarded_Amount':\n")
cat("Min:", min(data$Awarded_Amount), "\n")
cat("Max:", max(data$Awarded_Amount), "\n")


# Check if any values in 'Awarded_Amount' are zero or negative
invalid_award_amount <- any(data$Awarded_Amount <= 0)
cat("\nAre there any zero or negative values in 'Awarded_Amount'?", invalid_award_amount, "\n")


# Test 4: Check data types of important columns
cat("\nData Types of Important Columns:\n")
cat("Award_Date is Date type:", is.Date(as.Date(data$Award_Date)), "\n")
cat("Awarded_Amount is numeric:", is.numeric(data$Awarded_Amount), "\n")
cat("RFx_Type is character:", is.character(data$RFx_Type), "\n")
cat("Successful_Supplier is character:", is.character(data$Successful_Supplier), "\n")
cat("Division is character:", is.character(data$Division), "\n")

# Test 5: Check if 'Award_Date' is within a valid range (e.g., between 2000 and the current date)
valid_award_date_range <- all(data$Award_Date >= as.Date("2000-01-01") & data$Award_Date <= Sys.Date())

cat("\nAre all 'Award_Date' values within the valid range?", valid_award_date_range, "\n")


# Test 6:Check the unique values for important categorical columns
cat("\nUnique Values in 'RFx_Type':\n")
print(unique(data$RFx_Type))

cat("\nUnique Values in 'High_Level_Category':\n")
print(unique(data$High_Level_Category))

cat("\nUnique Values in 'Division':\n")
print(unique(data$Division))

cat("\nUnique Values in 'Successful_Supplier':\n")
print(unique(data$Successful_Supplier))




# Test 7: check that all big vs small business is in correct
# Check if there are exactly 35 unique suppliers that are FALSE under Small_Business
unique_big_businesses_count <- data %>%
  filter(Small_Business == FALSE) %>%
  summarise(unique_suppliers = n_distinct(Successful_Supplier)) %>%
  pull(unique_suppliers)

# Test if the count of unique big businesses is 33
if (unique_big_businesses_count == 33) {
  cat("Test Passed: There are exactly 33 unique big businesses.\n")
} else {
  cat("Test Failed: There are not exactly 33 unique big businesses. Count: ", unique_big_businesses_count, "\n")
}

# List of big businesses
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

# Check if all big businesses are in the data (i.e., Successful_Supplier column)
missing_businesses <- setdiff(big_business_list, contract_cleaned$Successful_Supplier)

# Check the result
if (length(missing_businesses) == 0) {
  cat("All big businesses are present in the data.\n")
} else {
  cat("The following big businesses are missing from the data:\n")
  print(missing_businesses)
}
