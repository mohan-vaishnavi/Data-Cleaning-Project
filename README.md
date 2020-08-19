# Data Cleaning Project
Getting and Cleaning Data using R

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Input:
Data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Script:

run_analysis.R - This script in responsible for downloading the original data set, processing it as per instructions and produce the output in the desired format.

How it works:

The script first downloads and unzips the dataset from the given url. The script then reads and merges the test and training sets. It extracts the mean and standard deviation values for each measurement. It replaces the numerical values used to denote various activites with descritpive names. It labels the columns with self explanatory names. It calculates the average of each variable and writes out this data set to another file called tidyData.txt

### Output: 
Data set - tidyData.txt

There is a codebook that gives a description of all variables and transformations used to clean the data.
