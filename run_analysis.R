# check if the dataset file exists.  if it does not, download and unzip it.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "Dataset.zip"

if (!file.exists(file)) {
  download.file(fileUrl,destfile=file,method="curl")
  unzip(file, exdir = dir)  
}

parent_dir <- "UCI HAR Dataset"
test_dir <- "UCI HAR Dataset/test"
train_dir <- "UCI HAR Dataset/train"

# read in measurment names
file <- c(parent_dir, "/", "features.txt")
file <- paste(file, collapse="")
features <- read.table(file)
measurement_names <- as.vector(features$V2)

# read in test dataset
file <- c(test_dir, "/", "X_test.txt")
file <- paste(file, collapse="")
x_test <- read.table(file)
colnames(x_test) <- measurement_names

# read in activity IDs for test set
file <- c(test_dir, "/", "Y_test.txt")
file <- paste(file, collapse="")
y_test <- read.table(file)
colnames(y_test) <- "activity"

# read in subject IDs for test set
file <- c(test_dir, "/", "subject_test.txt")
file <- paste(file, collapse="")
subject_test <- read.table(file)
colnames(subject_test) <- "subject"

# read in training dataset
file <- c(train_dir, "/", "X_train.txt")
file <- paste(file, collapse="")
x_train <- read.table(file)
colnames(x_train) <- measurement_names

# read in activity IDs for training set
file <- c(train_dir, "/", "Y_train.txt")
file <- paste(file, collapse="")
y_train <- read.table(file)
colnames(y_train) <- "activity"

# read in subject IDs for training set
file <- c(train_dir, "/", "subject_train.txt")
file <- paste(file, collapse="")
subject_train <- read.table(file)
colnames(subject_train) <- "subject"


x_test <- cbind(y_test, x_test)
x_test <- cbind(subject_test, x_test)

x_train <- cbind(y_train, x_train)
x_train <- cbind(subject_train, x_train)

# keep only columns that contain mean, std, subject and activity info
m <- grep("-mean()", colnames(x_test), ignore.case = FALSE, fixed=TRUE)
s <- grep("-std()", colnames(x_test), ignore.case = FALSE, fixed=TRUE)

# add the subject and activity columns to extracted set
keep_cols <- c(1, 2, m, s)
keep_test <- x_test[keep_cols]
keep_train <- x_train[keep_cols]

# merge test and train sets
start_row <- nrow(keep_test) + 1
end_row <- start_row + nrow(keep_train) - 1
row_names <- c(start_row:end_row)
rownames(keep_train) <- as.character(row_names)
merged_set <- rbind(keep_test, keep_train)

#check that the merged data set is as big as a sum of train and test sets
merge_succesful <- (nrow(x_test) + nrow(x_train) == nrow(merged_set))

# change activity to actual activity name
file <- c(parent_dir, "/", "activity_labels.txt")
file <- paste(file, collapse="")
activity_labels <- read.table(file)
colnames(activity_labels) <- c("activity", "activity_type")

# assign activity names based on activity number
# work with the set that has activity names but not numbers
# discard the activity number column and keep the activity name one
merged_set <- merge(merged_set, activity_labels, sort=FALSE)
merged_data <- merged_set[,2:length(merged_set)]

# melt the frame into variable subject, activity type and variables displaying
# means and standard deviations
# columns are: subject, activity_type, measurement1 .... measurementN
ms_melt <- melt(merged_data, subject=colnames(merged_data)[1], activity_type=colnames(merged_data)[ncol(merged_data)], measure.vars=colnames(merged_data)[2:(ncol(merged_data)-1)])

# cast the molten frame to display average of each variable
# for each activity and each subject
tidy_data <- dcast(ms_melt, subject + activity_type ~ variable,mean)

# write out the tidy data frame
write.table(tidy_data, file="tidy_data.txt", col.names=TRUE)                
  