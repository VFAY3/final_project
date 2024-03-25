# Load Packages

library(tidyverse)
library(sf)
library(tmap)
library(tigris)
library(tidycensus)
library(knitr)
library(here) 

# Read in Raw Data

here::i_am("code/data_prep.R")
here::here("raw_data/Ischaemic_total.txt")


absolute_file_p1 <- here::here("raw_data/Ischaemic_total.txt")
ischaemic_ca_total <- read.table(absolute_file_p1,
                                 sep = '\t',
                                 header = T,
                                 na.strings = c( 'Missing', 'Suppressed'),
                                 stringsAsFactors = F)


absolute_file_p2 <- here::here("raw_data/Ischaemic_female.txt")
ischaemic_ca_female <-  read.table(absolute_file_p2,
                                   sep = '\t',
                                   header = T,
                                   na.strings = c( 'Missing', 'Suppressed'),
                                   stringsAsFactors = F)

absolute_file_p3 <- here::here("raw_data/Ischaemic_male.txt")
ischaemic_ca_male<- read.table(absolute_file_p3,
                               sep = '\t',
                               header = T,
                               na.strings = c( 'Missing', 'Suppressed'),
                               stringsAsFactors = F)


# Cleaning/ Prepping Data to Join Mortality Data Sets in Following Step
  

total_death <- ischaemic_ca_total %>% 
  mutate(observed_rate = Deaths / Population *100000,
         FIPS = sprintf('%05d', County.Code)) %>%
  select(County, FIPS, Deaths, Population, observed_rate) %>% 
  rename(total_population = Population, total_deaths = Deaths, total_observed_rate = observed_rate)


female_death <- ischaemic_ca_female %>% 
  mutate(FIPS = sprintf('%05d', County.Code)) %>% 
  select(County, FIPS, Deaths, Population) %>% 
  rename(female_population = Population, female_deaths = Deaths)


male_death <- ischaemic_ca_male %>% 
  mutate(FIPS = sprintf('%05d', County.Code)) %>% 
  select(County, FIPS, Deaths, Population) %>% 
  rename(male_population = Population, male_deaths = Deaths)


# Joining Mortality Data sets & saving cleaned data for table generation

merge_deaths <- female_death %>% 
  left_join(male_death, by = 'FIPS')

ischaemic_deaths <- total_death %>% 
  left_join(merge_deaths, by = 'FIPS') %>% 
  select(-County.x, -County.y)

saveRDS(
  ischaemic_deaths,
  file = here::here ("output", "clean_data_4_table.rds")
)

# Accessing Geography Data from Tigris

options(tigris_use_cache = T)
US <- counties(cb =TRUE, resolution = '5m',
               class = 'sf',
               year = 2020) %>% 
  st_transform (5070)

CA <- US %>% 
  filter(STATEFP %in% c('06')) %>% 
  select(GEOID, STATEFP, COUNTYFP, NAME)
plot(st_geometry(CA))

# Joining Mortality Data to Geographic Data & saving cleaned data for map generation

isch_deaths <- CA %>% 
  left_join(ischaemic_deaths, by = c('GEOID' = 'FIPS'))

saveRDS(
  isch_deaths,
  file = here::here ("output", "clean_data_4_maps.rds")
)

