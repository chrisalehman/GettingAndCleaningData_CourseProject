# GettingAndCleaningData_CourseProject
This README documents the course project for the Coursera course "Getting and Cleaning Data". The goal of the assignment is to prepare a tidy data set based on data collected from the accelerometers of the Samsung Galaxy S smartphone.

## Assignment instructions
Create one R script called run_analysis.R that does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The raw data set used in this assignment is avaialble here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Executing the code
The code for creating a tidy data set is contained in the "run_analysis.R" script. Please follow these steps to execute this script successfully: 
* Download the raw data set indicated above and unzip in the working directory. The unzipped file will create a directory called "UCI HAR Dataset". 
* Source the run_analysis.R script
* Execute the function "createTidyDataSet()". When this completes, the tidy data set written to a file in the working directory called "tidy_data_set.txt". 



