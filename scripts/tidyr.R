download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

library(tidyverse)

library(readxl)

raw_fert <- read_excel(path = "Data/indicator undata total_fertility.xlsx", sheet = "Data")

raw_infantMort <- read_exel(path = "Data/indicator gapminder infant_mortality.xlsx")


gapminder

# naming:
# variables in columns
# objects in rows
# values

#FORMATS ####

# wide vs long format

# wide; easily read by humans: each row is a case and multiple observation variables
# long; easily read by computers: has only one observation variable; one column for the observed variable and all other columns are id variables

# tidy format

# data frame in WIDE format
head(raw_fert)

# getting data in a tidy format

fert <- raw_fert %>%
    rename(country= `Total fertility rate`) %>%
    # gather all variables except from country
    gather(key=year,value=fert, -country)%>%
    mutate(year=as.integer(year))
fert
