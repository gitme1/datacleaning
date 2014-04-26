datacleaning
============

This repo(datacleaning) presents a project of datacleaning (a coursera class)

The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis
       
This repo (datacleaning) contains 4 files: README.MD, CodeBook.MD, run_analysis.R and tidy_data.txt 

README.MD: a markdown file contains general information

CodeBook.MD: a markdown file describes variables used in tidy_data.txt

run_analysis.R: a R script performs the project and generates the final result (tidy_data.txt)

tidy_data.txt: a text file contains independent tidy data set with the average of each variarbles for each activity and each subject 


### Assumptions and Conditions
* 1. all Samsung data files have been downloaded and extract into local working directory before running run_analysis.R
* 2. Inertial Signals data in both test and train data sets are ignored
* 3. only 1 script(run_analysis) handles all, including data cleaning and generating a new tidy data set


### About run_analysis.R (see script for code details)
The script performs the following:
* 1.read in several text files(training and test sets), merge them to create one dataset                                 
* 2. extract only the measurements on the mean and standard deviation for each measurement                              
* 3. create a second, independent tidy data set with the average of each variables for each activity and each subject   
* 4. write that tidy data set as a text file

procedures:
*1. set working directory
*2. read in test group files: subject_test.txt, y_test.txt and x_test.txt 
*3. check any na there
*4. combine into 1 dataset(test:2947x563)
*5. read in train group files: subject_train.txt, y_train.txt and x_train.txt 
*6. check any na there
*7. combine into 1 dataset(train:7352x563)
*8. combine train and test into 1 dataset(dataset:10299x563)
*9. read in features.txt, make a column name list(col_name), change column names   based on features.txt of dataset(dataset)
*10. read in activity_lables.txt, make activity based on activity_lables.txt
*11. select variables with mean() and std() from column names of dataset(dataset)
*12. create a data set(data:10299x68): subject, activity, all mean var.go first, followed by all std var.
*13. create 2 column list: 1 for mean, 1 for std, both with subject & activity
*14. subset data to 2 data sets: 1 for mean(data_mean:10299x35), 1 for std(data_std:10299x35) 
*15. calculate ave. of mean & ave. of std based on the combination of subject & activity from data_mean and data_std, generate 2 results(ave_mean:180x68,ave_std:180x68)
*16. merge those 2 results: ave_mean and ave_std into 1 data set(tidy_data:180x68) with ordered by subject
*17. write tidy_data to a text file: tidy_data.txt with column names but no row names
*18.(optional) read tidy_data.txt file back for checking


### About tidy_data.txt (see contents for details)
It is a tidy data set with the average of each variables for each activity and each subject in text format, has 68 variables and 180 observations



