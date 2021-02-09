#####what does input and output look like in R?
1 + 2
299 / 7362
mean(c(1,2,65,100))
log10(100)

#####creating variables in r
#recommendations for creating variable names:
#variable names should be descriptive
#varible names cannot start with numbers
#the only form of punctuation allowed in variable names is an underscore

weight_kg <- 57.4
weight_kg

weight_lb <- 2.2 * weight_kg
weight_lb

#******exercise:
#create a variable called "test" and allocate any equation to it 
#note: here are details on R's order of operations: http://www.math.wm.edu/~leemis/Rsamples/4-5.pdf

#####data structures in r
#vectors (i.e., lists)
targetted_subject_ids <- c(10006, 10032, 10038, 10040)
heights <- c(1.5, 1.75, 1.34, 1.52)
pet_name <- c("Elo", "Captain", "Jack", "Mario")
pet_type <- c("Dog", "Cat", "Cat", "Cat")

#dataframes (i.e., spreadsheets or tabular data structures)
small_dataframe <- data.frame(targetted_subject_ids, heights, pet_name, pet_type)

#view the dataframe
small_dataframe

#summarize the dataframe
summary(small_dataframe)

#display a column from the dataframe
small_dataframe$pet_name

#view the structure of the dataframe
str(small_dataframe)

#data type conversion (from character to factor data (i.e., from text to categorical data))
small_dataframe$pet_type <- as.factor(small_dataframe$pet_type)
summary(small_dataframe)

#******exercise:
#convert the targetted_subject_ids column from a numeric column into a factor based column
