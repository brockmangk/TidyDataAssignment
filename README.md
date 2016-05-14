# TidyDataAssignment
Coursera Assignment for Getting and Cleaning Data Course - Week 4

This explains the function of R script - "run_analysis.R"
The function reads in several data files (reference Code Book for details), integrates, cleans and summarizes into a simple table.
The function assumes that all files from "UCI HAR Dataset.zip" are extracted with working directory set to "UCI HAR Dataset"

=====================================================================
Reading in Data
=====================================================================
The script reads in and consolidates 3 data files of both test and training data as follows:
  test data files:        x_test, y_test, subject_test
  training data files:    x_train, y_train, subject_train
Descriptive column names are added for the variables with the test data in table "test_var" and training data in "train_var" 

=====================================================================
Combine and Clean Data
=====================================================================
"test_var" and "train_var" are combined into data table "all_data"
Activity identifiers are supplemented with descriptive activity labels and columns are re-ordered to position factor columns up front
Variable columns that involve mean or standard deviations are identfied via text search and a new table is created ("filtered_data")
with only these variable columns - others excluded.

=====================================================================
Summarize and Write Results to File
=====================================================================
Data from table "filtered_data" is aggregated for each combination of activity (6) and subject (30) -->  total of 180 rows and strored
in new table, "summary_data"
"summary_data" is written to the working directory as "summary_data.csv"
