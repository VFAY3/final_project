# Load Packages

library(tidyverse)
library(sf)
library(tmap)
library(tigris)
library(tidycensus)
library(knitr)
library(here) 


here::i_am("code/make_maps.R")
here::here("output/clean_data_4_maps.rds")


clean_data_4_maps <- readRDS(
  file = here::here("output", "clean_data_4_maps.rds")
)


# Make Map for Observed Ischemic Heart Disease Mortality Rates

Observed <- tm_shape(clean_data_4_maps) +
  tm_fill(c('total_observed_rate'),
          style = 'quantile',
          palette = 'BuPu',
          title = 'Mortality Rate per 100,000 people') +
  tm_borders() +
  tm_layout(main.title = "California's Observed Ischaemic Mortality Rate")+
  tm_compass(type = 'arrow',
             size = 1,
             position = c('left', 'top')) +
  tm_scale_bar(position =c('left', 'bottom'),
               breaks = c(0, 50, 100, 150, 200, 250, 300))+
  tm_credits('Source: CDC Wonder',
             position = c('left', 'bottom'))

Observed_MR_Map <- tmap_arrange(Observed)

tmap_save(Observed_MR_Map, filename = here::here("output", "Observed_MR_Map.png"))


# Perform Calculations to generate Gender Specific SMR

r_female <- sum(clean_data_4_maps$female_deaths, na.rm = T) / sum(clean_data_4_maps$female_population, na.rm = T)
clean_data_4_maps$female_expected <- clean_data_4_maps$female_population * r_female
clean_data_4_maps$female_SMR <- clean_data_4_maps$female_deaths / clean_data_4_maps$female_expected

r_male <- sum(clean_data_4_maps$male_deaths, na.rm =T) / sum(clean_data_4_maps$male_population, na.rm =T)
clean_data_4_maps$male_expected <- clean_data_4_maps$male_population * r_male
clean_data_4_maps$male_SMR <- clean_data_4_maps$male_deaths / clean_data_4_maps$male_expected 

# Map SMR for Females

SMR_F <- tm_shape(clean_data_4_maps) +
  tm_fill(c('female_SMR'),
          style = 'quantile',
          palette = '-RdYlBu',
          title = 'Female SMR') +
  tm_borders() +
  tm_layout(main.title = 'Female Ischaemic SMR') +
  tm_compass(type = 'arrow',
             size = 1,
             position = c('left', 'top')) +
  tm_scale_bar(position =c('left', 'bottom'),
               breaks = c(0, 50, 100, 150, 200, 250, 300)) +
  tm_credits('Source: CDC Wonder',
             position = c('left', 'bottom'))



# Map SMR for Males

SMR_M <- tm_shape(clean_data_4_maps) +
  tm_fill(c('male_SMR'),
          style = 'quantile',
          palette = '-RdYlBu',
          title = 'Male SMR') +
  tm_borders()+
  tm_layout(main.title = 'Male Ischameic SMR') +
  tm_compass(type = 'arrow',
             size = 1,
             position = c('left', 'top')) +
  tm_scale_bar(position =c('left', 'bottom'),
               breaks = c(0, 50, 100, 150, 200, 250, 300))+
  tm_credits('Source: CDC Wonder',
             position = c('left', 'bottom'))



SMR_Gender_Stratified_Maps <- tmap_arrange(SMR_F, SMR_M)

tmap_save(
  SMR_Gender_Stratified_Maps,
  file = here::here ("output", "SMR_Gender_Stratified_Maps.png")
)



