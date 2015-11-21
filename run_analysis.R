# Getting and Cleaning Data Week3 
# PROJECT 1 By Servo Poserio
# Created: Nov. 18, 2015

install.packages("plyr")
library(plyr)
# Set work directory
setwd("~/workdiR/Course3-4/Getting and Cleaning Data/week3/Project1")

## PREPARE DATA
# Download and unpack source

desfile <- paste(getwd(),"dataset.zip",sep="/")
## Define target path destination
if(!file.exists(desfile)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, desfile, mode="wb")
}

## Unpack zip file
decompFile <- paste(getwd(), "dataset.zip", sep = "")

if(!file.exists(decompFile)){
  unzip(desfile, list = FALSE, overwrite = FALSE)
}

## STEP 1: Merges the training and the test sets to create one data set.

# Load features data
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

dsDir <- paste(getwd(),"UCI HAR Dataset/",sep="/")

# Read training data sets
subjTrainFile <- paste(dsDir,"train/subject_train.txt",sep="")
xTrainFile <- paste(dsDir,"train/X_train.txt",sep="")
yTrainFile <- paste(dsDir,"train/y_train.txt",sep="")
subjTrainDs <- read.table(subjTrainFile,col.names="Subject_ID")
xTrainDs <- read.table(xTrainFile,col.names= features$V2)
yTrainDs <- read.table(yTrainFile,col.names="Activity_ID")

# Read test data sets
subjTestFile <- paste(dsDir,"test/subject_test.txt",sep="")
xTestFile <- paste(dsDir,"test/X_test.txt",sep="")
yTestFile <- paste(dsDir,"test/y_test.txt",sep="")
subjTestDs <- read.table(subjTestFile,col.names="Subject_ID")
xTestDs <- read.table(xTestFile,col.names= features$V2)
yTestDs <- read.table(yTestFile,col.names="Activity_ID")

# Assemble training data set
trainingDS <- cbind(subjTrainDs,yTrainDs,xTrainDs)
# Assemble test data set
testDS <- cbind(subjTestDs,yTestDs,xTestDs)
# Merge data sets
dfHAR <- rbind(trainingDS, testDS)
#Sort by Subject_ID
dfHAR <- arrange(dfHAR, Subject_ID)

# Save data (Optional)
fRds <- paste(getwd(),"dfHAR.rds",sep="/")
saveRDS(dfHAR,file=fRds)
#readRDS (Optional)
#rdsHAR <- readRDS(fRds)

## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std_DS <- dfHAR[,c(1,2,grep("std", colnames(dfHAR)), grep("mean", colnames(dfHAR)))]
# Write table data to csv
fCsv <- paste(getwd(),"mean_std_Dataset.csv",sep="/")
write.csv(mean_std_DS,fCsv,row.names=F)

## STEP 3: Uses descriptive activity names to name the activities in the data set
# Parse column labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

## STEP 4: Appropriately labels the data set with descriptive variable names.
# rename columns
colnames(activityLabels)[1] <- "Activity_ID"
colnames(activityLabels)[2] <- "Activity"

# replace activity ID with Activity labels
dsHAR <- merge(activityLabels,dfHAR,by="Activity_ID")

## STEP 5: From the data set in step 4, creates a second, independent tidy data set with the 
#           average of each variable for each activity and each subject.

# Calculate column mean
avgTidyDS <- ddply(mean_std_DS, .(Subject_ID, Activity_ID), .fun=function(x){ colMeans(x[,-c(1:2)]) })
# Append Activity labels to tidy dataset
tidy_dataset <- merge(activityLabels,avgTidyDS,by="Activity_ID")

# Write table data to csv
f1 <- paste(getwd(),"tidy_dataset.txt",sep="/")
write.csv(tidy_dataset,f1,row.names=F)

