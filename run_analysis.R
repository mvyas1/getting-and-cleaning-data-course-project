# download files and unzip them.
# set working directory
setwd("C:/Users/Malhar.Vyas/Documents/UCI HAR Dataset")

#load data table library
library("data.table")

# import all the data into R tables
testData <- read.table("./test/X_test.txt",header=FALSE)
testData_act <- read.table("./test/y_test.txt",header=FALSE)
testData_sub <- read.table("./test/subject_test.txt",header=FALSE)
trainData <- read.table("./train/X_train.txt",header=FALSE)
trainData_act <- read.table("./train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./train/subject_train.txt",header=FALSE)

activities <- read.table("./activity_labels.txt",header=FALSE,colClasses="character")

features <- read.table("./features.txt",header=FALSE,colClasses="character")

# Using descriptive activity names to label the data
testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# Appropriately labels the data set with descriptive activity names
colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("Activity")
colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-c("Subject")
colnames(trainData_sub)<-c("Subject")

# merge test and training sets into one data set
testData<-cbind(testData,testData_act)
testData<-cbind(testData,testData_sub)
trainData<-cbind(trainData,trainData_act)
trainData<-cbind(trainData,trainData_sub)
fullData<-rbind(testData,trainData)

# subset the measurements for the mean and standard deviation for each measurement
fullData_mean<-sapply(fullData,mean,na.rm=TRUE)
fullData_sd<-sapply(fullData,sd,na.rm=TRUE)

# Create a tidy dataset which contains mean and std for activities by subject
# write the dataset into a csv file
Alldata <- data.table(fullData)
tidy_set<-Alldata[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy_set,file="tidy.csv",sep=",",row.names = FALSE)