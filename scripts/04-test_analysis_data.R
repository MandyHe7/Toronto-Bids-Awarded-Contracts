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
duplicates_document_number <- any(duplicated(data$unique_id,))

cat("\nAre there duplicates in 'Document_Number'?", duplicates_document_number, "\n")
cat("Are there duplicates in 'Unique_ID'?", duplicates_unique_id, "\n")


# Test 3: Check the range of 'Awarded_Amount'
cat("\nRange of 'Awarded_Amount':\n")
cat("Min:", min(data$Awarded_Amount), "\n")
cat("Max:", max(data$Awarded_Amount), "\n")

min(data$Awarded_Amount)

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

# Test 7:  Check the proportion of Small Business (TRUE/FALSE)
small_business_proportion <- table(data$Small_Business)
cat("\nProportion of Small Business (TRUE/FALSE):\n")
print(small_business_proportion)

# Test 8: Check for unique Document Numbers
unique_documents <- length(unique(data$Document_Number))
total_documents <- nrow(data)

cat("\nAre 'Document_Number' unique?", unique_documents == total_documents, "\n")
cat("Number of unique 'Document_Number':", unique_documents, "\n")
cat("Total number of rows:", total_documents, "\n")

