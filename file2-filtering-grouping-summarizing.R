####dplyr functions
#select() - select columns
#filter() - filter rows
#arrange() - re-order or arrange rows
#mutate() - create new columns
#summarise() - summarise values
#group_by() - allows for group operations in the "split-apply-combine concep 

#download the datafile
download.file("http://bit.ly/ecolidata", "ecoli_data.csv")
#load the csv as a dataframe into R
ecoli <- read.csv("ecoli_data.csv")
#view summary information about this dataset
summary(ecoli)

####Selecting columns
#this can help you quickly size down a large dataset
select(ecoli, sample, clade)
select(ecoli, -strain)
select(ecoli, c(1, 4))
#how would you select the first 3 columns?
select(ecoli, 1:3)

####Arranging rows
arrange(ecoli, genome_size)
arrange(ecoli, generation, genome_size)
arrange(ecoli, clade, generation)

####Filtering rows
filter(ecoli, cit == "plus")
filter(ecoli, cit == "plus" | run == "SRR098035")
filter(ecoli, cit == "plus" & genome_size >= 4.8)

#how many samples have a clade that is not equal to C2, a genome size less than 4.62 and a generation number les than 38000?
nrow(filter(ecoli, clade != "C2" & genome_size < 4.62 & generation < 38000))
#answer = 9

####Using pipes (magrittr package)
#what if you wanted to select and filter. You could do this by creating iterative dataframes or nested functions, or though pipes.

#Show cases where clade == C2, but only the sample and generation columns
ecoli %>%
  filter(clade == "C2") %>%
  select(sample, generation)

####Mutating
ecoli %>%
  mutate(genome_bp = genome_size * 1000000) 
# could also use 1e6

#make the read-out shorter using head
ecoli %>%
  mutate(genome_bp = genome_size * 1000000) %>%
  head

#filter out the NA value
ecoli %>%
  mutate(genome_bp = genome_size * 1000000) %>%
  filter(!is.na(clade)) %>%
  head

####Split-apply-combine data analysis through summarize()
ecoli %>% 
  group_by(cit) %>%
  summarize(n())

#add a better column header
ecoli %>% 
  group_by(cit) %>%
  summarize(count = n())

#add the average genome size for each cit
ecoli %>% 
  group_by(cit) %>%
  summarize(
    count = n(),
    mean_size = mean(genome_size)
    )

#group by multiple colums
ecoli %>%
  group_by(cit, clade) %>%
  filter(!is.na(clade)) %>%
  summarize(
    mean_size = mean(genome_size),
    sd = sd(genome_size, na.rm = TRUE))

            