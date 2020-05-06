# Getting and Cleaning Data Course Project 

This repository was built for the conclusion of the third module of Data Science Specialization ("Getting and Cleaning Data") from John Hopkins University at Coursera. 

## Project Summary

The objective is to prepare tidy data obtained from a experimental study using Samsung Galaxy S smartphone(S-II) on a public of 30 volunteers within an age bracket of 19-48 years executing specific exercises(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
Detail are available on (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
 
The program 'run_analysis.R' must meet the following requirements
 1. prepare the environment (laod libraries, create  work directory, donwnload zip file and unpackage it on work directory)
 2. read text files (test and training) and load them on tables.
 3. join tables on data frame and assign labels
 4. solving a problem with duplicate column names
 5. Extracts only the measurements on the mean and standard deviation for each measurement. 
 6. Uses descriptive activity names to name the activities in the data set
 7. Appropriately labels the data set with descriptive variable names. 
 8. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Repository Information

This repository contains 3 main files:

 - run_analysis.r    - The script will build up the analysis on the sample data.
 - avg_features.txt  - The final output from the "run_analysis.R" script
 - CodeBook.md       - It's a dictionary definition of each column on "tidy.txt" file.
 - ReadMe.md         - The descriptive file explain how works the script file run_analisys.r and informations about each file on repository.


