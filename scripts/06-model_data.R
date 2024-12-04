#### Preamble ####
# Purpose: Testing and verify that the Clean data is not missing any value and it is ready to use.
# Author: Mandy He
# Date: 23 November 2024
# Contact: mandyxy.he@mail.utoronto.ca
# License: N/A
# Pre-requisites:
# - 02-analysis_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
Contract_data <- read_csv("data/02-analysis_data/analysis_data.csv")

### Model data ####

Final_model <- glm(Small_Business ~ RFx_Type + High_Level_Category + Awarded_Amount + Award_Date,
  data = Contract_data, family = binomial)


#### Save model ####
saveRDS(
  Final_model,
  file = "models/first_model.rds"
)
