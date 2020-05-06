#load basic libraries
library(data.table)
library(dplyr)

# create a workspace
if(!file.exists("./data1")){
   dir.create("./data1")
   }

# download and unpackage zip file

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./data1/getdata_projectfiles_UCI HAR Dataset.zip"
download.file(fileURL, destfile,method = "libcurl")

# going to workspace
setwd("./data1")

#list and unpackage zip file on destfile
unzip(list.files(pattern = "\\.zip$"))

#Step 1. Merges the training and the test sets to create one data set.
sourcefiles <- "./UCI HAR Dataset"

## test
test_X <- read.table(file.path(sourcefiles, "test", "X_test.txt"),header = FALSE)
test_Y <- read.table(file.path(sourcefiles, "test", "Y_test.txt"),header = FALSE)
test_SUBJ <- read.table(file.path(sourcefiles, "test", "subject_test.txt"),header = FALSE)

## training
sourcefiles <- "./UCI HAR Dataset"
## train
train_X <- read.table(file.path(sourcefiles, "train", "X_train.txt"),header = FALSE)
train_Y <- read.table(file.path(sourcefiles, "train", "Y_train.txt"),header = FALSE)
train_SUBJ <- read.table(file.path(sourcefiles, "train", "subject_train.txt"),header = FALSE)

## join test + training
join_X<- rbind(test_X,train_X)
join_Y <- rbind(test_Y,train_Y )
join_SUBJ <- rbind(test_SUBJ, train_SUBJ)
features <- read.table(file.path(sourcefiles, 'features.txt'))
activities <- read.table(file.path(sourcefiles,'activity_labels.txt'))
##assign Labels
colnames(join_X) = features$V2
colnames(join_Y) <- 'activity_code'
colnames(join_SUBJ) <- 'subject'
## creatye a data_table with all columns
data_features<- cbind(join_SUBJ,join_Y,join_X)
###solving a problem with duplicate column names
data_features <- data_features %>% setNames(make.names(names(.), unique = TRUE))

#Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

sifted_features <- data_features %>% select(subject, activity_code, contains("mean"), contains("std"))

#Step 3. Uses descriptive activity names to name the activities in the data set

sifted_features$activity <- activities[sifted_features$activity_code, 2]
sifted_features <- sifted_features %>% select(-activity_code)

#Step 4. Appropriately labels the data set with descriptive variable names.
names(sifted_features) <- gsub("^t", "Time", names(sifted_features)) 
names(sifted_features) <- gsub("^f", "Frequency", names(sifted_features)) 
names(sifted_features)  <- gsub("^angle", "Angle", names(sifted_features))
names(sifted_features)  <- sub("Acc", "Acelerometer", names(sifted_features))
names(sifted_features)  <- gsub("Gyro", "Gyroscope", names(sifted_features))
names(sifted_features) <- gsub("subject", "Subject", names(sifted_features))
names(sifted_features) <- gsub("activity", "Activity", names(sifted_features))
names(sifted_features)  <- gsub("Mag", "Magnitude", names(sifted_features))
names(sifted_features) <- gsub("gravity", "Gravity", names(sifted_features))
names(sifted_features) <- gsub("mean", "Mean", names(sifted_features))
names(sifted_features) <- gsub("std", "STD", names(sifted_features))
names(sifted_features) <- gsub("meanFreq", "MeanFreq", names(sifted_features))
names(sifted_features) <- gsub("\\.\\.\\.", "-", names(sifted_features))
names(sifted_features) <- gsub("\\.", "", names(sifted_features))

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Execute the average of each variable groupping by Subject and Activity
avg_features <- sifted_features %>%
    group_by(Subject, Activity) %>%
    summarise_all(list(mean))
##generate text file with results 
write.table(avg_features, "avg_features.txt", row.name=FALSE, quote=FALSE)


