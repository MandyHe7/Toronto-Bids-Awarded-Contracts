#### Preamble ####
# Purpose: Testing and verify that the Clean data is not missing any value and it is ready to use.
# Author: Mandy He
# Date: 23 November 2024
# Contact: mandyxy.he@mail.utoronto.ca
# License: N/A
# Pre-requisites:
# - The `dplyr` package must be installed and loaded
# - 02-analysis_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj



#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Read data ####
Contract_data <- read_csv("data/02-analysis_data/analysis_data.csv")

### Model data ####


# Prepare the data: Ensure predictors are formatted correctly
Contract_data <- Contract_data %>%
  mutate(across(where(is.character), as.factor))

# Define the base model (starting with the three specified variables)
base_model <- glm(Small_Business ~ RFx_Type + High_Level_Category + Awarded_Amount,
  data = Contract_data, family = binomial
)

# Define the full model (including all variables as predictors)
full_model <- glm(Small_Business ~ .,
  data = Contract_data, family = binomial
)

# Perform forward selection
final_model <- step(base_model,
  scope = list(lower = base_model, upper = full_model),
  direction = "forward"
)

# Display the summary of the final model
summary(final_model)

