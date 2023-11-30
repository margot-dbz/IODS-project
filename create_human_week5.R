# Question1: Explore the structure and the dimensions of the 'human' data and describe the dataset briefly, assuming the reader has no previous knowledge of it (this is now close to the reality, since you have named the variables yourself). (1 point)

library(readr)
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")

dim(human)
str(human)
summary(human)
glimpse(human)

# The data has 195 rows and 19 variables. Variables are all numerical, except the country variable. 
# It shows some metrics per country to understand the development of a country based on different criteria such as life expediencies, education, information related to gender and development (education, work etc).

# Question 2: Exclude unneeded variables: 
# keep only the columns matching the following variable names:  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(,one_of(keep))

# Question 3: remove Rows with missing values
complete.cases(human)
# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# keep only the rows with the True in the last column of the data frame added with complete.cases
human_ <- filter(human,complete.cases(human))

# Question 4: Remove the observations which relate to regions instead of countries.
# define the last indice we want to keep
last <- nrow(human) - 7
# choose everything until the last 7 observations which has NA in the first column
human_only_countries <- human[1:last, ]
nrow(human)
nrow(human_)

# Question 5: Save the data human in my folder
write_csv(human_, "/Users/margot/Desktop/Desktop - MacBook Pro de MARGOT/Open data with R 2023/IODS-project/human.csv")


