library(tidyverse)

#####tidyverse basics

##filtering
#data cleaning step
microbiology_events$spec_type_desc <- tolower(microbiology_events$spec_type_desc)
only_swabs <- filter(microbiology_events, spec_type_desc == "swab")
all_blood <- filter(microbiology_events, grepl('blood', spec_type_desc))
swabs_OR_all_blood <- filter(microbiology_events, spec_type_desc == "swab" | grepl('blood', spec_type_desc))
blood_culture_AND_strep <- filter(microbiology_events, spec_type_desc =="blood culture" & org_name == "STREPTOCOCCUS PNEUMONIAE")

#******exercise: filter the admissions dataframe to show those admissions that are elective

#******exercise: filter the admissions dataframe to show admissions that are emergency, and the insurance type is medicare

##summarizing

#group by and summarize to see occurances
admissions_types <- admissions %>%
  group_by(admission_type) %>%
  summarise(count = n())

#group by and summarize by multiple values
admissions %>%
  group_by(admission_location, admission_type) %>%
  summarise(count = n())

#group by and summarize numerical values, in this case, find the averate diluation value per org_name
microbiology_events %>%
  filter(!is.na(dilution_value)) %>%
  group_by(org_name) %>%
  summarise(mean(dilution_value))

microbiology_events %>%
  group_by(subject_id) %>%
  summarise(count = n())

#******exercise: find counts of insurance types for single patients

##joining (merging tables based on common identifiers) 
#subject ids appear in all of our original tables, so we can use this id to link across these tables
#read more about joins here: https://dplyr.tidyverse.org/reference/join.html

#create a dataset that contains only male patients (from the patients table) who had elective admission types (admissions table) 
elective_male <- left_join(admissions, patients, by = "subject_id")
elective_male <- elective_male %>%
  filter(gender == "M" & admission_type == "ELECTIVE")

#******exercise: left join microbiology_events to admissions and show only rows with private insurance types
#who are single or divorsed, who have had a blood culture