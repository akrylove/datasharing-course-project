Summary:
This dataset describes the average of each variable for each activity and each subject.  The set includes averages of mean and standard deviations measurements.  Mean and STD values for each measurement were obtained in the original dataset.  Please see the original dataset (URLs referenced below) for explanation of how raw data was obtained and how those values were calculated.

The set contains calculations per subject per activity type independent of the subject’s classification.  The set does not differentiate whether the subject or the activity performed was part of the test or training set.  Rather, the measurements are merged from both test and training sets and mean of mean and std is calculated from the merged set.
Original dataset - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A full description of the original data set and raw data -http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Dictionary:
Each record contains the following 68 fields:
subject - ID of a person/subject
activity_type - type of activity the subject performed

33 columns with -mean() in the column name contain a calculated mean of each measurement’s mean per activity type per subject:
- tBodyAcc-XYZ - 3 columns
- tGravityAcc-XYZ - 3 columns
- tBodyAccJerk-XYZ - 3 columns
- tBodyGyro-XYZ - 3 columns
- tBodyGyroJerk-XYZ - 3 columns
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ - 3 columns
- fBodyAccJerk-XYZ - 3 columns
- fBodyGyro-XYZ - 3 columns
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

33 columns with -std() in the column name contain a calculated mean of each measurement’s standard deviation per activity type per subject:
- tBodyAcc-XYZ - 3 columns
- tGravityAcc-XYZ - 3 columns
- tBodyAccJerk-XYZ - 3 columns
- tBodyGyro-XYZ - 3 columns
- tBodyGyroJerk-XYZ - 3 columns
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ - 3 columns
- fBodyAccJerk-XYZ - 3 columns
- fBodyGyro-XYZ - 3 columns
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag


Transformations:
The following steps were performed to produce the dataset.
- obtain the “Human Activity Recognition Using Smartphones” dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
- unzip the files
- read in test data set from “test/X_test.txt” file
- update column names of the test data set with measurement names read from “features.txt” file
- read in activity IDs from “test/Y_test.txt” file and add them as a new column “activity” to the test data set
- read in subject IDs from “test/subject_test.txt” file and add them as a new column “subject” to the test data set
- read in train data set from “train/X_train.txt” file
- update column names of the train data set with measurement names read from “features.txt” file
- read in activity IDs from “train/Y_train.txt” file and add them as a new column “activity” to the train data set
- read in subject IDs from “train/subject_train.txt” file and add them as a new column “subject” to the train data set
- eliminate unneeded columns in test and train sets, only keep subject, activity, mean and std measurement columns.
- merge the test and train data sets - append train to test
- add a column “activity_type” and populate it with activity names from the “activity_labels.txt” file.  each activity number in the “activity” field of the data set has a corresponding activity type.  for example, activity with number 5 maps to “STANDING.”
- remove “activity” column as we now have “activity_type” column that describes the activity name rather than it’s number/ID
- melt the data frame into a 4-column table that has “subject” and “activity_type” id variables and all measured means/standard deviations as measure variables.  measure variables consume two columns - variable name and variable value.
- cast the molten frame into a frame that displays mean for each measured variable for each activity and each subject
- write out the data frame to the “tidy_data.txt” file

