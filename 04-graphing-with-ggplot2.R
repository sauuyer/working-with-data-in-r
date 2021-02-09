#basic use of ggplot2

#barplot
barplot <- ggplot(data= admissions_types, aes(x=admission_type, y=count)) +
  geom_bar(stat="identity", fill = "steel blue") +
  theme_minimal()

barplot


#box plot
dilution_data <- microbiology_events %>%
  filter(!is.na(dilution_value)) %>%
  filter(spec_type_desc == "mini-bal" | spec_type_desc == "swab" | spec_type_desc == "sputum")
boxplot <- ggplot(dilution_data, aes(x=as.factor(spec_type_desc), y=dilution_value)) +
  geom_boxplot() +
  xlab("Sample Type") +
  ylab("Dilution Value") +
  ggtitle("Distribution of Dilution Per Sample Type")

boxplot
