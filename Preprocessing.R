# Data Preprocessing
# Load the necessary packages
library(dplyr)
library(ggplot2)

# Load and combine Enrolments,Leaving Survey, and Step Activity data across all batches
enrolments <- bind_rows(
    read.csv("data/cyber-security-1_enrolments.csv"),
    read.csv("data/cyber-security-2_enrolments.csv"),
    read.csv("data/cyber-security-3_enrolments.csv"),
    read.csv("data/cyber-security-4_enrolments.csv"),
    read.csv("data/cyber-security-5_enrolments.csv"),
    read.csv("data/cyber-security-6_enrolments.csv"),
    read.csv("data/cyber-security-7_enrolments.csv")
)

leaving_survey <- bind_rows(
    read.csv("data/cyber-security-4_leaving-survey-responses.csv"),
    read.csv("data/cyber-security-5_leaving-survey-responses.csv"),
    read.csv("data/cyber-security-6_leaving-survey-responses.csv"),
    read.csv("data/cyber-security-7_leaving-survey-responses.csv")
)

step_activity <- bind_rows(
    read.csv("data/cyber-security-1_step-activity.csv"),
    read.csv("data/cyber-security-2_step-activity.csv"),
    read.csv("data/cyber-security-3_step-activity.csv"),
    read.csv("data/cyber-security-4_step-activity.csv"),
    read.csv("data/cyber-security-5_step-activity.csv"),
    read.csv("data/cyber-security-6_step-activity.csv"),
    read.csv("data/cyber-security-7_step-activity.csv")
)
combined_data <- enrolments %>%
    left_join(leaving_survey, by = "learner_id") %>%
    left_join(step_activity, by = "learner_id")

# Handling missing values
data_clean <- combined_data %>%
    filter(!is.na(age_range) & !is.na(gender) & !is.na(country)) %>%
    mutate(is_dropout = ifelse(!is.na(left_at), 1, 0))
