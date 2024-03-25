## Description of overall Project Folder (final_project)
- contains README.md
- contains raw_data folder
- contains code folder
- contains output folder
- contains makefile
- contains report.Rmd
- contains report.md

## Description of Raw Data (Found in raw_data folder)

`raw_data/Ischaemic_total.txt`
  - contains Ischaemic Heart Disease Mortality Data for the total population of the state of California by county for the years
    2016 -2020.
  - text file contains the total number of deaths and the population for each California county  
  - will use this data to read into the data_prep.R script located in the Code Folder
  
`raw_data/Ischaemic_female.txt`
  - contains Ischaemic Heart Disease Mortality Data for females in the state of California by county
  - same mortality data as Ischaemic_total.txt, but stratified by sex (female) to show the number of sex-specific deaths and population for     each county
  - will use this data to read into the data_prep.R script located in the Code Folder
  
`raw_data/Ischaemic_male.txt`
  - contains Ischaemic Heart Disease Mortality Data for males in the state of California by county
  - same mortality data as Ischaemic_total.txt, but stratified by sex (male) to show the number of sex-specific deaths and population for       each county
  - will use this data to read into the data_prep.R script located in the Code Folder
  
## Description of Code Folder
`code/data_prep.R`
  - loads packages for project
  - reads in raw data
  - cleans / preps data for joining tables
  - joins mortality data sets and saves (saveRDS) output in output folder as clean_data_4_table.rds for table generation in the make_table.R     file
  - accesses geography data from Tigris
  - joins mortality data to geographic data and saves (saveRDS) output in output folder as clean_data_4_maps.rds for map generation in the      make_maps.R file
  
`code/make_table.R`
  - loads packages for project
  - reads in clean_data_4_table.rds from output folder
  - creates top_counties object to select the desired variables form the .rds & arrange them to show the top ten counties with the highest 
    observed mortality rates
  - knit table 
  - saveRDS output of table as table.rds in the output folder
  
`code/make_maps.R`
  - loads packages for project
  - reads in clean_data_4_maps.rds from output folder
  - creates a map displaying the Observed Ischemic Heart Disease Mortality Rates in tmap & tmap_saves the output as Observered_MR_Map.png in     the output folder
  - performs calculations to generate gender specific SMR
  - creates SMR map for females
  - creates SMR map for males
  - tmap_saves both SMR maps as SMR_Gender_Stratified_Maps.png in the output folder
  
`code/render_report.R`
  - renders report.Rmd into the overall project folder, final_project
  
  
## Description of Output Folder
`output/clean_data_4_table.rds`
  - .rds generated from code/data_prep.R
  
`output/clean_data_4_maps.rds`
  - .rds generated from code/data_prep.R
  
`output/table.rds`
  - .rds generated from code/make_table.R
  -
`output/Observerd_MR_Map.png`
  - .png generated from code/make_maps.R
  
`output/SMR_Gender_Stratified_Maps.png`  
  - .png generated from code/make_maps.R
  

## Description of Report.Rmd
- output in YAML set to github_document
- global chunk options set
- read in table.rds from output folder to display table in report
- include knitr graphics to display the Observed Mortality Rate Map and the Sex Stratified SMR Maps. pngs from the output folder
- creates final report that shows the table of top ten counties with the highest observed Ischaemic Mortality Rates and the three maps that display the overall        observed Ischaemic mortality rate in California by county as well as the SMR maps for Ischaemic Mortality Rates stratified by sex. 

## Description of Makefile
- include rule to make output/clean_data_4_maps.rds
- include rule to make output/table.rds
- include rule to make output/Observed_MR_Map.png
- include rule to make report.md
- include rule to clean 

