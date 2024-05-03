FROM rocker/r-ubuntu

RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('knitr')"
RUN Rscript -e "install.packages('tmap')"
RUN Rscript -e "install.packages('tigris')"
RUN Rscript -e "install.packages('tidycensus')"
RUN Rscript -e "install.packages('tidyverse')"
RUN Rscript -e "install.packages('sf')"

RUN apt-get update && apt-get install -y pandoc

RUN mkdir /project
WORKDIR /project

RUN mkdir code
RUN mkdir output
RUN mkdir raw_data
RUN mkdir Final_project 

COPY code code
COPY output output
COPY raw_data raw_data
COPY Final_project Final_project
COPY makefile .
COPY report.Rmd .


# Mounting the directory
RUN mkdir report 

# code in terminal to mount, make, & move the report 

# docker run -it -v /$(pwd)/report:/project/report final_project_image_test bash
#  make
# mv report.html report 

CMD make && mv report.html report 

#to check run in terminal 
# docker run -v /$(pwd)/report:/project/report final_project_image_test











