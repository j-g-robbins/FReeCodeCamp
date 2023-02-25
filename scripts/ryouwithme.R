library(tidyverse)
library(here)
library(readr)
library(skimr)
library(dplyr)
library(janitor)

beaches <- read_csv(here("data","sydneybeaches.csv"))

# Shortcuts ####

## shortcuts

# Alt up/down      = move line up/down
# Alt shift up     = duplicate line
# Alt -            = <- 
# Ctrl shift M     = %>%


# Ctrl shift alt M = change all occurrences
# Ctrl alt X       = wrap code in function
# Ctrl alt V       = wrap as variable assignment

# Ctrl Shift R  = foldable comment section
# Alt L         = collapse active section
# Alt O         = collapse all sections
# Alt shift L   = open active section
# Alt shift O   = open all sections

## code snippets

# type in and then press shift+tab to autocomplete
# can add custom

# lib, req, fun, ret, mat, for, while, switch, if, el, ei, apply, shinyapp

# Data Loading ####

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
  rename(beachbugs = enterococci_cfu_100ml)

write_csv(clean_beaches, "cleanbeaches.csv")

# which beach has most extreme levels of bugs

# arrange (--> sort
# desc(beachbugs) OR (-beachbugs)
worstbugs <- clean_beaches %>% arrange(desc(beachbugs))

# filter by value
cleanbeaches %>% 
  filter(site == "Coogee Beach") %>%
  arrange(-beachbugs)

# compare max bug values across different beaches
# c() creates a vector
cleanbeaches %>%
  filter(site %in% c("Coogee Beach", "Bondi Beach")) %>%
  arrange(-beachbugs)

# summarise & group by
# summarise doesn't work with missing data - need to explicitly say na.rm = TRUE
# group_by gives us the values for the two separate sites rather than total
cleanbeaches %>%
  group_by(site) %>%
  summarise(maxbug = max(beachbugs, na.rm = TRUE),
            meanbugs = mean(beachbugs, na.rm = TRUE),
            median = median(beachbugs, na.rm = TRUE),
            sdbugs = sd(beachbugs, na.rm = TRUE))

# compare councils
cleanbeaches %>% distinct(council)

councilbysite <- cleanbeaches %>% 
  group_by(council, site) %>% 
  summarise(meanbugs = mean(beachbugs, na.rm = TRUE),
            median = median(beachbugs, na.rm = TRUE))

# Plotting ####

# https://rladiessydney.org/courses/ryouwithme/02-cleanitup-3/




