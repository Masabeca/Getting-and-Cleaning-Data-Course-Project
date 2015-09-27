## Downloading and unzip the dataset from the link 
#**************************************************
if (!file.exists("data")) {dir.create("data")}

dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl, destfile = "./data/UCI_HAR_Dataset.zip")
list.files("./data")

unzip("./data/UCI_HAR_Dataset.zip", exdir="./data")
list.files("./data/UCI HAR Dataset")

## Step 1.
## Merges the training and the test sets to create one data set.
# *****************************************************************

# Load the activity and features datasets to create data frames
activityLab <- read.table("./Data/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
feature <- read.table("./Data/UCI HAR Dataset/features.txt", sep="", header=FALSE)

# updating the column names for activity and feature variable data frames
colnames(activityLab) <- c("activityId", "activityName")
colnames(feature) <- c("varId", "varName")

# Load test datasets 
xTest <- read.table("./Data/UCI HAR Dataset/test/X_test.txt", sep="",header=FALSE)
yTest <- read.table("./Data/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
subjectTest <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Load training datasets 
xTrain <- read.table("./Data/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
yTrain <- read.table("./Data/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
subjectTrain <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Updating the column names for test and training data frames
colnames(xTest) <- feature$varName
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"

colnames(xTrain) <- feature$varName
colnames(yTrain) <- "activityId"
colnames(subjectTrain) <- "subjectId"

# Binding test data frames into one data frame
testData <- cbind(subjectTest, yTest, xTest)
# Binding training data frames into one data frame
trainData <- cbind(subjectTrain, yTrain, xTrain)

# Merge test and training data frames in one data frame
AllData <- rbind(testData, trainData)

## Step 2. 
##Extracts only the measurements on the mean and standard deviation for each measurement. 
# *****************************************************************************************
# creating a vector of Indexs where mean() and std() exist in column names of AllData data frame
subsetFeatVarIndex <- grep("mean\\(\\)|std\\(\\)", names(AllData))

# create subset of data based on mean() and std() column indices 
# and includng first 2 columns which have subjectId and activityId values
subsetAllData <- AllData[ , c(1,2, subsetFeatVarIndex)]

## Step 3.
## Uses descriptive activity names to name the activities in the data set.
#*************************************************************************
names(subsetAllData) <- gsub("-", "", names(subsetAllData))
names(subsetAllData) <- gsub("\\(\\)", "", names(subsetAllData))
names(subsetAllData) <- gsub("mean", "Mean", names(subsetAllData))
names(subsetAllData) <- gsub("std", "Std", names(subsetAllData))

## Step 4. 
##Appropriately labels the data set with descriptive variable names. 
#***********************************************************************************
SubFinalData <- merge(activityLab, subsetAllData, by="activityId", all=TRUE)
#remove the activityId column which is no longer needed 
FinalData <- subset(SubFinalData, select = -activityId)

##Step 5.
## From the data set in step 4, creates a second, independent tidy data set with the average
## of each variable for each activity and each subject. 
#*******************************************************************************************************
library(reshape2)
# using melt function to reshare data activityName, subjectId and all measurement values
FinalDataMelt <- melt(FinalData, id.vars=c("activityName", "subjectId"), measure.vars=(names(FinalData[3:68])) )

# creating new tidy data.frame “tidyData”, using cast function to reshare data and provide 
# average of each measurement variable for each activity and each subject
tidyData <- dcast(FinalDataMelt, activityName + subjectId ~variable, mean)

# writng new tidy data.frame "tidyData" to a text file excluding row names to create
# the required tidy data file 180 observations and 68 columns
# (2 columns for activityName and subjectID and 66 columns for measurement variables) 

write.table(tidyData, "tidyData.txt", sep="\t", row.names=FALSE)

