#reading csvs into r
patients <- read.csv("mimic-iii-clinical-database-demo-1.4/PATIENTS.csv")
admissions <- read.csv("mimic-iii-clinical-database-demo-1.4/ADMISSIONS.csv")
microbiology_events <- read.csv("mimic-iii-clinical-database-demo-1.4/MICROBIOLOGYEVENTS.csv")

#dataframe exploration
summary(admissions)
str(admissions)
#display the first 6 rows of the dataframe
head(admissions)
#display the column names
colnames(microbiology_events)
#view the number of rows
nrow(patients)

#******exercise: read in any of the other csvs from the mimic iii folder as a new variable
#and use one of the exploratory functions above