####Untidy vs tidy data sets (at the spreadsheet level)
##Tidy spreadsheets should follow these principles:
  #each column should be a variable
  #each row should be an ovservation
  #each cell should contain one unit of data

#Install and load needed packages
#install.packages("tidyverse", dependencies=TRUE)
library(tidyr)
library(dplyr)
#library(reshape2)

#Create (and assign) an example "messy" dataframe for use in the following example functions 
messy_data <- data.frame(
  name = c("Tilda, J", "Delta, B", "Neo, S", "Dinger, S", "Matter, D", "Vanta, B"),
  a = c(67, 80, 64, 39, 78, 32),
  b = c(52, 84, 96, 74, 36, 35),
  completed = c(TRUE, FALSE, FALSE, TRUE, TRUE, TRUE),
  group = c("control", "protocol 1", "protocol 2", "control", "protocol 1", "protocol 2")
)

##Identify the untidyness of this data
  #name column contains two units of data in each cell of this column
  #results a and b are stored in seperate columns

##Seperate the name column
seperated_data <- messy_data %>%
  separate(name, into = c("last_name", "first_initial"), sep = ", ")

##Combine results a and b into one column (reshape2)
gathered_data <- seperated_data %>%
  gather(test, results, c("a", "b"))

##Seperate control, cycle 1 and cycle 2 data
seperate_group_data <- spread(gathered_data, group, results)

