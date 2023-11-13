# owner: Margot de Bazillac
# date: 7th Nov 
# file descriptiotn: Data wrangling exercise

library(tidyverse)

# Save the url in a object
url_data <- "https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt"

# read the data and save it i a object
table_data <- read.table(url_data, sep = "\t", header = TRUE)

# View to verify the table is as it should
view(table_data)

str(table_data)
dim(table_data)

# Add sum up columns for the 3 types of learning: DP, ST, TU
# I used a different method than the one used in the exercises2.rmd file.
new_columns_dataset <- table_data %>% 
  mutate(Attitude = Attitude/10) %>% 
  mutate(Strategic = rowSums(select(., starts_with("ST"))) / 8) %>% 
  mutate(Deep = rowSums(select(., starts_with("D"))) / 12) %>% 
  mutate(Surface = rowSums(select(., starts_with("SU"))) / 12)

#Deep_adjusted       Deep/12 (min = 1, max = 5) - previous Deep score divided by the number of the items of the scale
#Surface_adjusted    Surface/12 (min = 1, max = 5) - previous Surface score divided by the number of the items of the scale
#Strategic_adjusted  Strategic/8 (min = 1, max = 5) - previous Strategic score divided by the number of the items of the scale
new_columns_dataset

# Keep only the reauested variables gender, Age, Attitude, Strategic, Deep, Surface, Points)
# Filter out "0 point" rows
smaller_dataset <- new_columns_dataset %>% 
  select(gender,Age, Attitude,Strategic,Deep,Surface,Points) %>% 
  filter(Points > 0)

# Verify we have 166 entries for 7 variables
dim(smaller_dataset)
view(smaller_dataset)

# set the Directory: 
dir()
setwd("~/Desktop/Open data with R 2023/IODS-project")

# Save it as a csv in the Directory
csv_table_write <- write_csv(smaller_dataset,"~/Desktop/Open data with R 2023/IODS-project/learning2014.csv")
csv_table_write
str(csv_table_write)
head(csv_table_write)

# Test if I can read it
csv_table_read <- read_csv("~/Desktop/Open data with R 2023/IODS-project/learning2014.csv")
csv_table_read
str(csv_table)
head(csv_table_read)
