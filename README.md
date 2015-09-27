#Getting-and-Cleaning-Data-Course-Project
Course Project for Gettting and Cleaning Data based on Human Activity Recognition Using Smartphones Dataset

This README file explains details around what files are included and what are their features:

##Original Data Source
Data for analysis is downloaded from the below URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
_______________________________________________________________________________________
##Files Included in Repository
* run_analysis.R
* CodeBook.md
* tidy.txt

##Details of run_analysis.R script
This is the script used to perform analysis on raw data to create a tidy datafile called tidy.txt

##Functions of run_analysis.R Script:

* Downloads the dataset from the URL mentioned above and unzip it to create data folder
* Imports test and train datsets and creates data frames and then merges the training and the test sets in one data             frame.
* Extracts a subset of data with only the measurements on the mean and standard deviation for each measurement. 
* Updates the variable names in dataframe variable names for data frame to improve readibility
* Appropriately labels the data set with descriptive activity names in place of activity Ids
* Reshapes dataset to create a data frame with average of each measurement variable for each activity and each subject
* Writes new tidy data frame to a text file to create the required tidy data set file of 180 observations and 68 columns(2     columns for activityName and subjectID and 66 columns for measurement variables)

##Running the script

To run the script, just have to download the script and source the script from your working directory in R source(run_analysis.R)

##Details of CodeBook.md

The code book file describes the variables, the data, and any transformations and work performed to clean up the data.

##Details of tidy Dataset file tidy.txt
This is the tidy data file created after running run_analysis.R script on the original data downloaded from above URL 
This tidy dataset contains following
* 180 observations and 68 columns(2 columns for activityName and subjectID and 66 columns for measurement variables)
* Each measurement variable column is average value for each combination of subjectId and activityName


