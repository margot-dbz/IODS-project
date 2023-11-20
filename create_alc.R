# owner: Margot de Bazillac
# Data wrangling task
# Data source: http://www.archive.ics.uci.edu/dataset/320/student+performance

# Read both student-mat.csv and student-por.csv into R (from the data folder) 
# explore the structure and dimensions of the data

library("tidyverse")
library("finalfit")
library("broom")

# set directory
setwd("~/Desktop/Desktop - MacBook Pro de MARGOT/Open data with R 2023/IODS-project")

# Reading student-por.csv file
por_data <- read.csv("student-por.csv",sep = ";", header = T)

# Reading student-mat.csv file
mat_data <- read.csv("student-mat.csv",sep = ";", header = T)

# dimension and structure por_data: 649 x 33
dim(por_data)
summary(por_data)
str(por_data)

# dimension and structure mat_data: 395 x 33
dim(mat_data)
summary(mat_data)
str(mat_data)

# summary statistics for each variable
missing_glimpse(por_data)
missing_glimpse(mat_data)

# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" 
# as (students) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data.
identifiers <- setdiff(names(por_data), c("failures", "paid", "absences", "G1", "G2", "G3"))
# method 1
merged_data1 <- merge(por_data, mat_data, by = identifiers)
dim(merged_data1)
# method 2:
merged_data2 <- inner_join(por_data, mat_data, by = identifiers)
dim(merged_data2)

# remove duplicates: I did not understand well how to combine these columns: failures, paid, absences, G1, G2, G3
# here is what i tried to do, add the columns and calculate the average: 
merged_data_corrected <- merged_data2 %>% 
  mutate(G1=(G1.x+G1.y)/2) %>% 
  mutate(G2=(G2.x+G2.y)/2) %>% 
  mutate(G3=(G3.x+G3.y)/2) %>% 
  mutate(failures = (failures.x + failures.y)/2) %>% 
  mutate(absences = (absences.x + absences.y)/2)

# remove the duplicated columns. 
data <- merged_data_corrected[, !(names(merged_data_corrected) %in% c("G1.y", "G1.x","G2.x","G2.y","G3.x","G3.y","failures.x","failures.y","absences.x","absences.y"))]
dim(data)
# what to do with the paid?

# To take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use'
# Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise).
# Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
data_alc_use <- data %>% 
  mutate(alc_use = (Dalc + Walc)/2) %>% 
  mutate(high_use = alc_use >2)

glimpse(data_alc_use)
dim(data_alc_use)

# is my data correct? I did not manage to remove the duplicates.
downloaded_data <- read.csv("alc.csv",sep = ",", header = T)
dim(downloaded_data) # 1 more in my table - "paid"

library(readr)

# save the dataset in my folder "data"
write_csv(data_alc_use, "/Users/margot/Desktop/Desktop - MacBook Pro de MARGOT/Open data with R 2023/IODS-project/data/data_alc_use.csv")

