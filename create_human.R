# Create a new R script called create_human.R

install.packages("readr")
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Explore the datasets: see the structure and dimensions of the data. 
# Create summaries of the variables. (1 point)
# Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
# Mutate the “Gender inequality” data and create two new variables. 
# The first new variable should be the ratio of female and male populations with secondary education in each country (i.e., Edu2.F / Edu2.M). 
# The second new variable should be the ratio of labor force participation of females and males in each country (i.e., Labo.F / Labo.M). (1 point)
# Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). 
# The joined data should have 195 observations and 19 variables. 
# Call the new joined data "human" and save it in your data folder (use write_csv() function from the readr package). (1 point)

summary(hd)
