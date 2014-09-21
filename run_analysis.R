

#setwd("C://DISCO_D//ORGANIZADO//Coursera//__Coursera//08_Data Science Specialization//03_Getting and Cleaning Data//Project//solution")

## Get Data


fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "project.zip")
unzip("project.zip")

## Load data

setwd(".//UCI HAR dataset")

features = read.table("features.txt")
activity_labels = read.table("activity_labels.txt")

setwd(".//train")

train = read.table("X_train.txt")
subject_train = read.table("subject_train.txt")
y_train = read.table("y_train.txt")

setwd("..//test")

test = read.table("X_test.txt")
subject_test = read.table("subject_test.txt")
y_test = read.table("y_test.txt")



# (4) Appropriately labels the data set with descriptive variable names. 

features$V2 = sub("\\(\\)","", features$V2)

colnames(train) = features$V2
train$subject = subject_train$V1
train$activity = y_train$V1

colnames(test) = features$V2
test$subject = subject_test$V1
test$activity = y_test$V1

# (3) Uses descriptive activity names to name the activities in the data set

train$activity = factor(train$activity, labels=activity_labels$V2) 
train$activity = as.character(train$activity)

test$activity = factor(test$activity, labels=activity_labels$V2) 
test$activity = as.character(test$activity)

# (1) Merges the training and the test sets to create one data set.

traintest = rbind(train, test)


# (2) Extracts only the measurements on the mean and standard deviation for each measurement. 

traintest2 = traintest[, c(grep("mean[^F]|std", colnames(traintest)))]
traintest2$subject = traintest$subject
traintest2$activity = traintest$activity

# (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


tt_walking_u = subset(traintest2, traintest2$activity=="WALKING_UPSTAIRS")
tt_walking_d = subset(traintest2, traintest2$activity=="WALKING_DOWNSTAIRS")
tt_walking   = subset(traintest2, traintest2$activity=="WALKING")
tt_sitting   = subset(traintest2, traintest2$activity=="SITTING")
tt_standing  = subset(traintest2, traintest2$activity=="STANDING")
tt_laying    = subset(traintest2, traintest2$activity=="LAYING")

library(plyr)
a = ddply(tt_walking_u,.(subject), numcolwise(mean))
b = ddply(tt_walking_d,.(subject), numcolwise(mean))
c = ddply(tt_walking  ,.(subject), numcolwise(mean))
d = ddply(tt_sitting  ,.(subject), numcolwise(mean))
e = ddply(tt_standing ,.(subject), numcolwise(mean))
f = ddply(tt_laying   ,.(subject), numcolwise(mean))

a$activity = "WALKING_UPSTAIRS"
b$activity = "WALKING_DOWNSTAIRS"
c$activity = "WALKING"
d$activity = "SITTING"
e$activity = "STANDING"
f$activity = "LAYING"
  
  
abcdef = rbind(a,b,c,d,e,f)

setwd("..\\..")

write.table(abcdef, "mydata.txt", row.name= FALSE)

