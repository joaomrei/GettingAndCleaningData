GettingAndCleaningData
======================

Coursera Data Science Specialization Project - Getting and Cleaning Data

file: run_analysis.R

This script runs on Windows only beacause it uses setwd to navigate in Windows folder structure
One alternative is to manually place every data file in the same dir. This way there is no need to use setwd.
I opted to do it automatically but on windows.


It begins by downloading the original dataset in zip format and unzip.
Next it loads train and test dataset, subject, activity and features data

# (4) Appropriately labels the data set with descriptive variable names.

Builds subject and activity variables and names all variable names (colnames())


# (3) Uses descriptive activity names to name the activities in the data set

Sets the activity variable as character with descriptive activity names (e.g. "WALKING" and "SITTING")

# (1) Merges the training and the test sets to create one data set.

traintest = rbind(train, test)


# (2) Extracts only the measurements on the mean and standard deviation for each measurement. 

Subsets merget dataset to choose variables names  with "mean and "std" but not "meanF"

traintest2 = traintest[, c(grep("mean[^F]|std", colnames(traintest)))]

# (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Creates subset dataframes for every activity
e.g.

tt_walking_u = subset(traintest2, traintest2$activity=="WALKING_UPSTAIRS")

we get 6 new dataframes

for every dataframe we calculate the mean of every numeric variable (using plyr package):
e.g.

a = ddply(tt_walking_u,.(subject), numcolwise(mean))

we get 6 new dataframes with 30 observations, one for every subject.

Next we row bind the 6 dataframes and get the final one:

abcdef = rbind(a,b,c,d,e,f)

The final 'data.frame':	180 obs. of  59 variables



