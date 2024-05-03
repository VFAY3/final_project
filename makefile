## Report-Associated Rules 
report.md: report.Rmd code/render_report.R output/Observed_MR_Map.png output/table.rds output/clean_data_4_maps.rds
	Rscript code/render_report.R 
	
output/Observed_MR_Map.png: code/make_maps.R output/clean_data_4_maps.rds
	Rscript code/make_maps.R

output/table.rds: code/make_table.R output/clean_data_4_maps.rds
	Rscript code/make_table.R
	
output/clean_data_4_maps.rds: code/data_prep.R
	Rscript code/data_prep.R
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
.PHONY: clean
clean:
	rm output/*
	
## Docker-Associated Rules 
PROJECTFILES = report.Rmd code/* output/* makefile raw_data/* Final_project/*

RENVFILES = renv.lock renv/activate.R renv/settings.json

# Rule to Build an Image
final_project_image_test: dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t vfay3/final_p_image . 
	touch $@

# Rule to Build the Report Automatically in our Container
report/report.html: final_project_image_test
	docker run -v "/$$(pwd)/report":/project/report vfay3/final_p_image 
	
# Note: code is written for windows machines 