# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

0. Gets the data and loads them in memory.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Run ```source("run_analysis.R")```, it will download (if zip file or unzipped data not already there) and process the data and generate a new file ```tidy.txt``` in your working directory.

## Dependencies

```run_analysis.R``` file will help you to install the dependencies automatically. It requires ```data.table```. 
