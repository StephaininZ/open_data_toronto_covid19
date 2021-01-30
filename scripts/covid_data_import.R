#### Preamble ####
# Purpose: Download the Toronto COVID-19 cases data using opendatatoronto
# Author: Yingying Zhou
# Data: 25 January 2021
# Contact: yingying.zhou@utoronto.ca 
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Get data ####
all_data <- 
  opendatatoronto::search_packages("COVID-19 Cases in Toronto") %>% 
  opendatatoronto::list_package_resources() %>% 
  dplyr::filter(name %in% c("COVID19 cases")) %>% 
  group_split(name) %>% 
  map_dfr(get_resource, .id = "file")


#### Save data ####
write_csv(all_data, "inputs/data/raw_data.csv")
