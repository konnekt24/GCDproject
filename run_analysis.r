####################
# Coursera Course Project - "Getting and Cleaning Data"
# By Joonsuk Hong
####################

# Requirements:

# 1. download file from the following address:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 2. Merges the training and the test sets to create one data set.
# 3. Extracts only the measurements on the mean and standard deviation for each measurement.
# 4. Use descriptive activityy names to name the activities in the data set.
# 5. Apporpriately labels the data set with descriptive variable names.
# 6. From the data set in step 5, creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
################

# How to achieve:
# 1. Reading the data from the downloaded files.
# 2. Merging the data with the verb rbind().
# 3. Extract the mean and SD for each measurement by grep().
# 4. Using descriptive activity names to name the activities by names().
# 5. Create a second and independent tidy data set with avg of each variable by the verb ddply and the argument colMeans.

### The working directory "~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/"

setwd("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/")

# Required library to load: plyr
library(plyr)

# files are given have no header. 
features <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/features.txt", header = FALSE)
activity.labels <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/activity_labels.txt", 
                              header =  FALSE)

# Read the training set.
subject.train <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/train/subject_train.txt", 
                            header = FALSE)
x.train <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/train/x_train.txt", 
                      header = FALSE)
y.train <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/train/y_train.txt", 
                      header = FALSE)

# Read the test set.
subject.test <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/test/subject_test.txt", 
                           header = FALSE)
x.test <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/test/x_test.txt", 
                     header = FALSE)
y.test <- read.table("~/Desktop/Coursera/assignment/Projects/GCD/UCIHARDataset/test/y_test.txt", 
                     header = FALSE)

# Define variable names for tables.

colnames(activity.labels) <- c("activity.ID", "activity.Type")
colnames(subject.train) <- "subject.ID"
colnames(subject.test) <- "subject.ID"
colnames(x.train) <- features[,2]
colnames(y.train) <- "activity.ID"
colnames(x.test) <- features[,2]
colnames(y.test) <- "activity.ID"

# The first step to merge into training and test.

training.set <- cbind(y.train, subject.train, x.train)
test.set <- cbind(y.test, subject.test, x.test)

# Monitoring the first step.

View(training.set)
View(test.set)

# The second step to merge into one tbl.

merged.tbl <- rbind(training.set, test.set)

# Monitoring the second step

View(merged.tbl)

# Extract the only variables interested.

all.variables <- colnames(merged.tbl)
intertested.variables <- grepl("activity", all.variables) |
                        grepl("subject", all.variables) |
                        grepl("mean\\(\\)", all.variables) |
                        grepl("std\\(\\)", all.variables)
selected.tbl <- merged.tbl[intertested.variables == TRUE]

# Monitoring the selected table.
View(selected.tbl)

# Change the value of activity ID with activity labels.

selected2.tbl <- merge(selected.tbl, activity.labels, by = "activity.ID", all.x = TRUE)

# Monitoring the result.
View(selected2.tbl)

# Changing the labels with descriptive variable names.

names(selected2.tbl) <- gsub("^t", "time", names(selected2.tbl))
names(selected2.tbl) <- gsub("^f", "frequency", names(selected2.tbl))
names(selected2.tbl) <- gsub("Acc", "Accelerometer", names(selected2.tbl))
names(selected2.tbl) <- gsub("Gyro", "Gyroscope", names(selected2.tbl))
names(selected2.tbl) <- gsub("Mag", "Magnitude", names(selected2.tbl))
names(selected2.tbl) <- gsub("BodyBody", "Body", names(selected2.tbl))

# Monitoring the result.
View(selected2.tbl)

# New tidy data set of every variable from selected2.tbl

tidy.tbl <- aggregate(. ~subject.ID + activity.ID, selected2.tbl, mean)
tidy.tbl <- tidy.tbl[order(tidy.tbl$subject.ID, tidy.tbl$activity.ID),]
write.table(tidy.tbl, file = "tidydata.txt", row.names = FALSE)

View(tidy.tbl)