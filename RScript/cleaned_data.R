#Data cleaning process
#rename and select predictors/variables for later usage.
library(tidyverse)
raw_data <- read_csv("life_expectancy.csv")
cleaned_data <- raw_data %>%
  rename(country = `Country`) %>%
  rename(status = `Status`) %>%
  rename(population = `Population`) %>%
  rename(life_expectancy = `Life expectancy`) %>%
  rename(total_expenditure = `Total expenditure`) %>%
  rename(Hepatitis_B = `Hepatitis B`) %>%
  rename(HIV_AIDS = `HIV/AIDS`) %>%
  rename(healthcoverage_percent = `percentage expenditure`) %>%
  rename(adult_mortality = `Adult Mortality`) %>%
  filter(Schooling != 0.0) %>%
  dplyr :: select(country, status, life_expectancy, adult_mortality, Alcohol, healthcoverage_percent, Hepatitis_B, BMI, Polio, total_expenditure, Diphtheria, GDP, Schooling)

cleaned_data <- na.omit(cleaned_data)

# Mutate a binary treatment immunization coverage
cleaned_data <- cleaned_data %>%
  mutate(vaccine_total = Polio+Diphtheria+Hepatitis_B) %>%
  mutate(vaccine_coverage_over_ave = ifelse(vaccine_total >= mean(vaccine_total), 1, 0))

write_csv(cleaned_data, "cleaned_data.csv")
