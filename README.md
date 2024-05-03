## Instructions for running the automated version of the containerized docker image
- Clone repository from GitHub & save in desired location
- Open the makefile & scroll to the bottom of page
- In the terminal, run the make rule for report/report.html to generate the 
the report in the containerized Docker image from Dockerhub. Output will be saved
to report folder

## Link to Docker Image on DockerHub

https://hub.docker.com/repository/docker/vfay3/final_p_image/general 

## Process of How I Built the Docker Image
First I created a dockerfile in final_project directory and started building my docker image
with an existing image from rock/r-ubuntu (which saves me having to install R). I then installed
all the R packages I used for my project. Originally I tried to sync it with Renv, but my computer hates this
and refuses to do it, so I had to manually add the packages as a work around. I then ran the apt-get update to make sure 
I had the most recent versions of the packages & installed pandoc since I will need that to generate the rmarkdown documents. 
I then made a directory called project, which I established as my working directory for docker. I then made all the files I would need to copy
over from my project on my desktop (code, output, raw_data, Final_project) & then copied these folders into the new ones I made in the
project directory. I also copied over my makefile & report.Rmd. After than I mounted the directory & added a entry point that would
automatically make & move the report.html to the report folder (see comments in dockerfile for code used in terminal).


# Note:
-Although the files associated with Renv are not used for the docker container
I am still including them on github since these files/ code were apart of the 
last final project submission. 

## Description of overall Project Folder (final_project)
- contains README.md
- contains raw_data folder
- contains code folder
- contains output folder
- contains report folder
- contains Final_project folder
- contains makefile
- contains report.Rmd
- contains report.md
- contains dockerfile
- contains renv folder
- contains renv.lock 
- contains .Rprofile
- contains .Rhistory

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
- creates final report that shows the table of top ten counties with the highest observed Ischaemic Mortality Rates and the three maps that display the overall observed Ischaemic mortality rate in California by county as well as the SMR maps for Ischaemic Mortality Rates stratified by sex. 

## Description of Makefile
- include rule to make output/clean_data_4_maps.rds
- include rule to make output/table.rds
- include rule to make output/Observed_MR_Map.png
- include rule to make report.md
- include rule to make install - which runs a Rscript that synchronizes user's R packages 
  to the versions that I used
- include rule to clean 
- include rule to build project image
- include rule to run container automatically

## Description of Renv Lock File
- Contains the versions of the R packages that I used to run my code/ create
  my maps, table, and report
  
## Description of renv/
- contains activate.R script (part of the process of making everything automatic-
  sourced in from the Rprofile for us to automatically start using project specific library)
- contains settings.dcf
  
## To Synchronize Package Repository
- Open make file & "make" the .PHONY rule install to synchronize R packages to version I used

