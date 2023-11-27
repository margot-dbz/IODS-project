# Question 1: Create a new R script called create_human.R
library(readr)
library(dplyr)

# Question 2: Read in the “Human development” and “Gender inequality” data sets as follows:
library("readr")
library(tidyverse)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Question 3: Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables. (1 point)
dim(hd)
summary(hd)
str(hd)
dim(gii)
summary(gii)
str(gii)

# Question 4: Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
new_hd <- hd %>% rename("GNI"= "Gross National Income (GNI) per Capita", "Life.Exp"= "Life Expectancy at Birth", "Edu.Exp" = "Expected Years of Education", "HDI" = "Human Development Index (HDI)")
new_gii <- gii %>% rename("Mat.Mor" = "Maternal Mortality Ratio" , "Ado.Birth"="Adolescent Birth Rate","Parli.F" = "Percent Representation in Parliament","Edu2.F" = "Population with Secondary Education (Female)","Edu2.M" = "Population with Secondary Education (Male)", "Labo.F" = "Labour Force Participation Rate (Female)","Labo.M" = "Labour Force Participation Rate (Male)")

# Question 5: Mutate the “Gender inequality” data and create two new variables. 
# The first new variable should be the ratio of female and male populations with secondary education in each country (i.e., Edu2.F / Edu2.M). The second new variable should be the ratio of labor force participation of females and males in each country (i.e., Labo.F / Labo.M). (1 point)
new_gii <- new_gii %>% 
  mutate(Edu2.FM = Edu2.F / Edu2.M,
         Labor.FM = Labo.F / Labo.M)

# Question 6: Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). The joined data should have 195 observations and 19 variables. Call the new joined data "human" and save it in your data folder (use write_csv() function from the readr package). (1 point)
human <- inner_join(new_gii, new_hd,by = c("Country"))

# It has 19 variables and 195 rows
dim(human)

# Save the data human in my folder
write_csv(human, "/Users/margot/Desktop/Desktop - MacBook Pro de MARGOT/Open data with R 2023/IODS-project/human.csv")





