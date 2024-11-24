#### Preamble ####
# Purpose: Testing and verify that the simulated data is generated correctly and adheres to the expected structure and constraints.
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

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Check for missing values (NA) in the dataset
missing_values <- colSums(is.na(simulated_data))
cat("Missing Values:\n")
print(missing_values)

# Check the range of Awarded_Amount (should be between the specified range)
cat("\nRange of Awarded_Amount:\n")
cat("Min:", min(simulated_data$Awarded_Amount), "\n")
cat("Max:", max(simulated_data$Awarded_Amount), "\n")

# Check if the 'Awarded_Amount' is within the expected range (500,000 - 50,000,000)
award_range_check <- all(simulated_data$Awarded_Amount >= 500000 & simulated_data$Awarded_Amount <= 50000000)
cat("\nAwarded_Amount is within the expected range (500,000 - 50,000,000):", award_range_check, "\n")

# Check the distribution of 'RFx_Type' values
cat("\nDistribution of RFx_Type:\n")
print(table(simulated_data$RFx_Type))

# Check the distribution of 'Small_Business' values
cat("\nDistribution of Small_Business (TRUE/FALSE):\n")
print(table(simulated_data$Small_Business))

# Check if 'Award_Date' is of Date type and within a reasonable range (last two years)
cat("\nCheck 'Award_Date' type and range:\n")
cat("Is Award_Date of Date type? ", is.Date(as.Date(simulated_data$Award_Date)), "\n")
cat("Earliest Award Date:", min(as.Date(simulated_data$Award_Date)), "\n")
cat("Latest Award Date:", max(as.Date(simulated_data$Award_Date)), "\n")

# Check for duplicates in 'Document_Number'
duplicates <- any(duplicated(simulated_data$Document_Number))
cat("\nAre there duplicates in Document_Number?", duplicates, "\n")

# Check for expected number of unique values in key categorical columns
cat("\nNumber of unique 'RFx_Type' categories:", length(unique(simulated_data$RFx_Type)), "\n")
cat("Number of unique 'High_Level_Category' categories:", length(unique(simulated_data$High_Level_Category)), "\n")
cat("Number of unique 'Division' categories:", length(unique(simulated_data$Division)), "\n")
cat("Number of unique 'Successful_Supplier' categories:", length(unique(simulated_data$Successful_Supplier)), "\n")
