#load libraries 
library(dplyr)
library(tidyr)
library(readxl)

#Load data
dual <- read.csv("Report_Card_Dual_Language.csv")
demo <- read.csv("Report_Card_Enrollment_from_2014-15_to_Current_Year.csv")
local <- read_xlsx("Washington_Education_School_Directory_07_17_2020.xlsx")


#Update variable type
dual$SchoolCode <- as.integer(dual$SchoolCode)
local$SchoolCode <- as.integer(local$SchoolCode)

#Remove several incorrect rows in Dual
dual <- dual %>% filter(RowId != 1561 & 
                          RowId != 4651 &
                          RowId != 7771 &
                          RowId != 10920)

#Join Datasets
main <- (dual %>% filter(OrganizationLevel == "School")) %>% 
           left_join((demo %>% filter(Gradelevel == "AllGrades" & !is.na(SchoolCode))), 
                     by = c("SchoolYear", "SchoolCode"))

main <- main %>% left_join(local, by = c("SchoolCode"))

write.csv(main, "WA_Dual_Language.csv")






