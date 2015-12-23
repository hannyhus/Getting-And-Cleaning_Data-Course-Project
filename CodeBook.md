#Data Source 

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#Data Set Information 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#Dataset files used in run_analysis.R

"./UCI HAR Dataset/activity_labels.txt" -> activity_labels -> WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, & LAYING

"./UCI HAR Dataset/features.txt" -> features -> A 561-feature vector with time and frequency domain variables.

"./UCI HAR Dataset/test/X_test.txt" -> x_test -> test set

"./UCI HAR Dataset/test/y_test.txt" -> y_test -> test labels 

"./UCI HAR Dataset/test/subject_test.txt" -> subject_test -> list of subjects used 

"./UCI HAR Dataset/train/X_train.txt" -> x_train -> training set

"./UCI HAR Dataset/train/y_train.txt" -> y_train -> training labels

"./UCI HAR Dataset/train/subject_train.txt" -> subject_train -> list of subjects used

#Variables used in run_analysis.R

* x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
* test_data and train_data merge the above datasets for further analysis using the cbind and as.data.table()
* features contains the correct names for the x_test dataset, which are applied to the column names stored in extracted_features, a numeric vector used to extract the desired data.
* activity_labels contains the correct names for the y_train dataset
* data merges test_data and train_data into a big data set using the rbing()
* tidy_data contains the relevant averages which will be later stored in a .txt file. by using the melt()

#Packages used in run_analysis.R

library(plyr)

library(reshape2)

library(data.table)
