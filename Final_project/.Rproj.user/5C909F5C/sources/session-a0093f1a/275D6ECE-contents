report.md: report.Rmd code/render_report.R output/Observed_MR_Map.png output/table.rds output/clean_data_4_maps.rds
	Rscript code/render_report.R 
	
output/Observed_MR_Map.png: code/make_maps.R output/clean_data_4_maps.rds
	Rscript code/make_maps.R

output/table.rds: code/make_table.R output/clean_data_4_maps.rds
	Rscript code/make_table.R
	
output/clean_data_4_maps.rds: code/data_prep.R
	Rscript code/data_prep.R
	
.PHONY: clean
clean:
	rm output/*
