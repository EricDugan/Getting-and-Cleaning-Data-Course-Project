library(tidyverse)
library(curl)


##Download data and create data.frames

filename = "fitnessdata.zip"
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, filename, method="curl")
unzip(filename)

features = read.table("UCI HAR Dataset/features.txt", col.names = c("position","functions"))
activities = read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activity"))
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectID")
x_test = read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityID")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectID")
x_train = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityID")


## Step 1: Merge the training and the test sets to create one data set----------------------------------------
XData = rbind(x_train, x_test)
YData = rbind(y_train, y_test)
SubjectData = rbind(subject_train, subject_test)
MergedData = cbind(SubjectData, YData, XData)

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement -------------
MeasurementMeanSD = MergedData %>% 
        select(subjectID, activityID, contains("mean"), contains("std"))

## Step 3: Uses descriptive activity names to name the activities in the data set----------------------------- 
MeasurementMeanSD$activityID = activities[MeasurementMeanSD$activityID,2]

## Step 4: Appropriately labels the data set with descriptive variable names----------------------------------

# from the features_info.txt, the prefix 't' denotes variables in the time domain
# the prefix 'f' denotes variables in the frequency domain
# other abbreviated variable names have been expanded

names(MeasurementMeanSD) = gsub("Acc", "Accelerometer", names(MeasurementMeanSD))
names(MeasurementMeanSD) = gsub("Gyro", "Gyroscope", names(MeasurementMeanSD))
names(MeasurementMeanSD) = gsub("BodyBody", "Body", names(MeasurementMeanSD))
names(MeasurementMeanSD) = gsub("Mag", "Magnitude", names(MeasurementMeanSD))
names(MeasurementMeanSD) = gsub("^t", "TimeDomain", names(MeasurementMeanSD))
names(MeasurementMeanSD) = gsub("^f", "FrequencyDomain", names(MeasurementMeanSD))
names(MeasurementMeanSD) = gsub("tBody", "TimeDomainBody", names(MeasurementMeanSD))


## Step 5: From the data set in step 4, creates a second, independent tidy data set --------------------------
## with the average of each variable for each activity and each subject

SummaryData = MeasurementMeanSD %>%
        group_by(subjectID, activityID) %>%
        summarise_all(funs(mean))

#Save summary data as a text file
write.table(SummaryData, "SummaryData.txt", row.name=FALSE)

