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


# Load the styler package
library(styler)

# Define files to format
files_to_format <- c("scripts/00-simulate_data.R", "scripts/01-test_simulated_data.R", "scripts/02-download_data.R",
                     "scripts/03-clean_data.R", "scripts/04-test_analysis_data.R",
                     "scripts/05-exploratory_data_analysis.R", "scripts/06-model_data.R", 
                     "paper/paper.qmd")

# Loop through each file and format it
lapply(files_to_format, style_file)
