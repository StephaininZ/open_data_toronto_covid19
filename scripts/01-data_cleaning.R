#### Preamble ####
# Purpose: Clean the Toronto COVID-19 cases data downloaded from https://open.toronto.ca/dataset/covid-19-cases-in-toronto/
# Author: Yingying Zhou
# Data: 25 January 2021
# Contact: yingying.zhou@utoronto.ca 
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)

library(opendatatoronto)
library(dplyr)
library(tidyverse)

all_data <- 
  opendatatoronto::search_packages("COVID-19 Cases in Toronto") %>% 
  opendatatoronto::list_package_resources() %>% 
  dplyr::filter(name %in% c("COVID19 cases")) %>% 
  group_split(name) %>% # Don't totally understand how this works
  map_dfr(get_resource, .id = "file")
write_csv(all_data, "inputs/data/raw_data.csv")
# Read in the raw data. 
all_data <- readr::read_csv("inputs/data/raw_data.csv"
                     )
# Keep variables that may be of interest 
names(all_data)

covid_toronto <- 
  all_data %>%
  janitor::clean_names() %>%
  select(age_group, source_of_infection, reported_date, client_gender, outcome)
         

#### What's next? ####



         