## Code Book

Original CodeBook for the dataset used in this project can be found here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

Libraries used: "tidyverse" and "curl"
    
Step #1
        The training and test sets are mergred into one data set named "MergedData" 
        using the cbind and rbind functions

Step #2
        The measurements on the mean and standard deviatation for each measurement
        are extracted from "MergedData" and saved to the data set "MeasurementMeanSD" 
        using the select function.

Step #3
        "subjectID" is the ID number for each subject in the data set
        "activityID" is used to assign the descriptive name of each activity performed by the subjects.

Step #4
        Renaming variables with more descriptive names
                All instances Acc in column’s name replaced by Accelerometer
                All instances of Gyro in column’s name replaced by Gyroscope
                All instances of BodyBody in column’s name replaced by Body
                All instances of Mag in column’s name replaced by Magnitude
                All instances of tBody in column's name replaced by TimeDomainBody
                All vars that start with character f in column’s name replaced by FrequencyDomain
                All vars that start with character t in column’s name replaced by TimeDomain 

Step #5
        The average of each variable for each activity and subject is saved in a data set "SummaryData".
        This data set was created using the summarizing "MeasurementMeanData"
        Finally this data set is exported as "SummaryData.txt"
