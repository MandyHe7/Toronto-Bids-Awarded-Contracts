#### Preamble ####
# Purpose: Cleans the raw data so variable is easier to call.
# Author: Mandy He
# Date: 23 November 2024
# Contact: mandyxy.he@mail.utoronto.ca
# License: N/A
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)

# Example data for simulation
document_numbers <- unique(raw_data$Document_Number) # Use unique document numbers from your dataset
rfx_types <- c("RFQ", "RFP", "RFSQ") # Common RFx Types
high_level_categories <- unique(raw_data$High_Level_Category) # Use categories from original data
suppliers <- unique(raw_data$Successful_Supplier) # List of suppliers
divisions <- unique(raw_data$Division) # Divisions from the original data
small_business_options <- c(TRUE, FALSE) # Small Business status

# Simulating Awarded Amounts (random values within a specified range)
award_amount_range <- c(500000, 50000000) # Example range for Awarded Amount (e.g., between 500k and 50M)

# Randomly simulate Award Dates (e.g., within the last 2 years)
award_dates <- seq.Date(from = as.Date("2022-01-01"), to = Sys.Date(), by = "day")

# Simulate new data
n_simulations <- 100 # Number of observations to simulate

simulated_data <- data.frame(
  Document_Number = sample(document_numbers, n_simulations, replace = TRUE),
  RFx_Type = sample(rfx_types, n_simulations, replace = TRUE),
  High_Level_Category = sample(high_level_categories, n_simulations, replace = TRUE),
  Successful_Supplier = sample(suppliers, n_simulations, replace = TRUE),
  Awarded_Amount = runif(n_simulations, min = award_amount_range[1], max = award_amount_range[2]),
  Award_Date = sample(award_dates, n_simulations, replace = TRUE),
  Division = sample(divisions, n_simulations, replace = TRUE),
  Small_Business = sample(small_business_options, n_simulations, replace = TRUE)
)

# View a sample of the simulated data
head(simulated_data)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
