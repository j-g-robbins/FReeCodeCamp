library(tidyverse)
library(here)
library(readr)
library(skimr)
library(dplyr)
library(janitor)

beaches <- read_csv(here("data","sydneybeaches.csv"))

# bring up view
View(beaches)
# dimensions
dim(beaches)
# structure (data types)
str(beaches)
# same as structure but in a table
glimpse(beaches)
# top x rows, bottom x rows
head(beaches)
tail(beaches)
# descriptive stats
summary(beaches)
# better descriptive stats mini histogram
skim(beaches)

# tidying columns

# dplyr
select_all(beaches, tolower)
# janitor ^ does not change raw data. need assignment.
clean_names(beaches)

# assignment 
clean_beaches = clean_names(beaches)

# rename column
clean_beaches = rename(clean_beaches, beachbugs = enterococci_cfu_100ml)

# select certain columns
select(clean_beaches, council, site, beachbugs)

# reorder columns
select(clean_beaches, council, site, beachbugs, everything())

# pipe %>%

cleanbeaches <- beaches %>% 
  clean_names() %>%
  rename(beachbugs = enterococci_cfu_100ml) %>%
  select(council, site, beachbugs)

write_csv(clean_beaches, "cleanbeaches.csv")
# https://rladiessydney.org/courses/ryouwithme/02-cleanitup-2/
# https://learningstatisticswithr.com/lsr-0.6.pdf


