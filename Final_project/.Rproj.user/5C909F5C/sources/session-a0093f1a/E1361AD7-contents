# Load Packages

library(tidyverse)
library(sf)
library(tmap)
library(tigris)
library(tidycensus)
library(knitr)
library(here) 


here::i_am("code/make_table.R")
here::here("output/clean_data_4_table.rds")

cleaned_data_4_table <- readRDS(
  file = here::here("output", "clean_data_4_table.rds")
)

top_counties <- separate(cleaned_data_4_table,
                         County,
                         into = c("County", "State"),
                         sep = ",") %>% 
  select('County', 'total_deaths', 'total_population', 'total_observed_rate') %>% 
  arrange(desc(total_observed_rate)) %>% 
  head(10) 

table <- knitr::kable(top_counties, col.names = c("County", "Deaths", "Population", "Mortality Prevalence"),
                      align = "cccc", caption = "Table 1: Top 10 Counties with Highest Observed Ischaemic Mortality Prevalence",
                      "simple")
saveRDS(
  table,
  file = here::here("output", "table.rds")
)

