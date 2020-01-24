library(lubridate)

mimic_admissions <- read.csv("mimic-iii-clinical-database-demo-1.4/admissions.csv")
mimic_patients <- read.csv("mimic-iii-clinical-database-demo-1.4/patients.csv")

summary(mimic_admissions)
summary(mimic_patients)

names(mimic_admissions)
names(mimic_patients)

mimic_patients_and_admissions <- merge(mimic_admissions, mimic_patients, by = "subject_id")

names(mimic_patients_and_admissions)

mimic_patient_summary <- mimic_patients_and_admissions %>%
  filter(expire_flag == 1) %>%
  mutate(duration = ymd_hms(deathtime) - ymd_hms(admittime)) %>%
  filter(!is.na(duration)) %>%
  group_by(marital_status) %>%
  summarise(
    average = mean(duration),
    sd = sd(duration),
    min_time = min(duration),
    max_time = max(duration)
  )
