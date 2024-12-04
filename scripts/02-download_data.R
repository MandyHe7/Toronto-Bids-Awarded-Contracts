#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto.
# Author: Mandy He
# Date: 23 November 2024
# Contact: mandyxy.he@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)


#### Download data ####
# get package
package <- show_package("tobids-awarded-contracts")
package

# get all resources for this package
resources <- list_package_resources("tobids-awarded-contracts")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c("csv", "geojson"))

# load the first datastore resource as a sample
the_raw_contract_data <- filter(datastore_resources, row_number() == 1) %>% get_resource()


#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_contract_data, "data/01-raw_data/raw_data.csv")
