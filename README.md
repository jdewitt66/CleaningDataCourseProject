CleaningDataCourseProject
=========================

Data files for the Coursera Getting and Cleaning Data Course Project

In this repository are the following files:  

run_analysis.R - R script to read in UCI HAR dataset and to perform the reuirements of the assignement, including  
  1) reading in training and test datasets  
  2) adding subject IDs and specific activity names  
  3) removing any columns that do not include a mean or standard deviation measure  
  4) modufying variable names to exclude periods and parentheses  
  5) merging of test and training datasets into a single data set  
  6) creation of an aggregate data set that includes the means of each variable by activyt type and subject  
  7) output of a data file with the summary data (tidySum.txt)  
  
codebook.md - file with variable names and defitions for the tidySum.txt dataset
