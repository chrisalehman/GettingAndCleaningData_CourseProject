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
The code for creating a tidy data set is contained in a script called "run_analysis.R" in the base directory of the repo. Follow these steps to execute this script: 
* Download the raw data set indicated above and unzip it in your working directory. The unzipped file will create a directory called "UCI HAR Dataset". 
* Source the run_analysis.R script.
* Execute the function "createTidyDataSet()". When it completes a tidy data set will be written to a file in the working directory called "tidy_data_set.txt". 

## Code book
A code book is included in the base directory of this repo describing the methodology for obtaining the final data set and a description of the data set's variables. The file is called "code_book.txt". 

## Methodology

At a high level, the following steps were performed to process this data:

1. Load the training and test measurement data sets and merge them with rbind. This was possible because each data set contained 
precisely the same number of columns. 

2. Load the associated training and test headers and merge them with the measurements data set. NOTE: This process was complicated by the fact that several headers were duplicates. These duplciates made it difficult to select
the mean and standard deviation data because the select() function in the dplyr package expects all columns to be unique. 
Furthermore, it raised questions about the integrity of the data as one might expect the measurements to contain duplicates as 
well. However, as none of the mean and standard deviation headers or measurement data contained duplicates, this problem was not fatal to the project. The make.names() function was used to force the creation of unique headers. Later these headers were 
cleaned with regex to product more meaningful names. 

3. Merge the activity names into the data set. The process involved a few steps. The activities were contained in separate test 
and training dataset files. These files contained numbers representing various activities. A separate file called 
activity_labels.txt contained a mapping of the activity names to the numbers contained in the files. Thus, it was necessary 
first to load and merge the activity files containing only numbers, and then apply a function to generate a secondary column 
containing all the activity names. Both columns were inserted into the measurements dataset. 

4. Load and then merge the subjects into to measurements dataset. Several subjects were used in this study, indcated by numbers 
1-30. The subject data was again contained in a test file and a training file that needed to be merged. 

5. Once a complete dataset was formed, the subject, activity and measurement data for mean and standard deviation was extracted 
via the dplyr select() function. This produced 66 measurement columns. 

6. The aggregate() function was used to take a mean of all measurements data for each subject and activity combination. The same 
column names were used in the final tidy data set. 

7. Finally, the resulting data was exported to a file called "tidy_data_set.txt".



