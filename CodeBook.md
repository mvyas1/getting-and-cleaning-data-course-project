# This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The data source



  Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* 

  Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Relevant Files/Data:



- 'README.txt'



- 'features_info.txt': Shows information about the variables used on the feature vector.



- 'features.txt': List of all features.



- 'activity_labels.txt': Links the class labels with their activity name.



- 'train/X_train.txt': Training set.



- 'train/y_train.txt': Training labels.



- 'test/X_test.txt': Test set.



- 'test/y_test.txt': Test labels.


## Details of the script:

first step is to read all the data after downloading it

'''
testData <- read.table("./test/X_test.txt",header=FALSE)
testData_act <- read.table("./test/y_test.txt",header=FALSE)
testData_sub <- read.table("./test/subject_test.txt",header=FALSE)
trainData <- read.table("./train/X_train.txt",header=FALSE)
trainData_act <- read.table("./train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./train/subject_train.txt",header=FALSE)

activities <- read.table("./activity_labels.txt",header=FALSE,colClasses="character")

features <- read.table("./features.txt",header=FALSE,colClasses="character")

the training data set, testing data set, and related activities and subjects are inidivually put in a R table


Transformations are produced so that descriptive names can be used for the activities and features

testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)


column names are properly assigned

Merging codes to combine test and train sets

Subset the measurements for the mean and std for by activities and subject

Write the tidy dataset to a txt file