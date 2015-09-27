#CodeBook
Course Project for Getting and Cleaning Data based on Human Activity Recognition Using Smartphones Dataset. This CodeBook that describes the variables, the data, and any transformations or work that was performed to clean up the source data to create a tidy dataset as per requirements of course project.
________________________________________

##Information about Source Data Experiment

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
________________________________________

##Data Source
Original data source:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
________________________________________

### Structure of Data present in source data folders

*	README.txt: Details of all the files in downloaded folder
*	features_info.txt: Shows information about the variables used on the feature vector.
* features.txt: List of all features.i.e list of all measurement variables
* activity_labels.txt: Lists the activity Id with their corresponding activity name.
* X_train.txt: Training set.
* y_train.txt: Training activity Id Labels
* subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1    to 30.
* X_test.txt: Test set.
*	y_test.txt: Test activity Id Labels
*	subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The following files are available for the train and test data. Their descriptions are equivalent:
* train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units g. Every row shows a 128 element vector.
*	total_acc_x_train.txt and total_acc_z_train.txt files for the Y and Z axis.
*	train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
*	train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample.

The units are radians/second. 
Note: All the files in train/Inertial Signals and test/Inertial Signals will not be used for in this analysis

________________________________________

##Details about Files to be used in analysis from Source Data 

###Common Files

*	features.txt: 561 rows of 2 varibles (feature Identifier and feature Name)
*	activity_labels.txt: 6 rows of 2 variables (activity identifier and activity name)


###Test Dataset

*	xTest.txt: 2947 rows of 561 measurement variables. These are measurement variables listed in features.txt
*	yTest.txt: 2947 rows of 1 variables. This is the activity Identifier
*	subjectTest.txt: 2497 rows of 1 variable (subject Identifier)


###Training Dataset

*	xTrain.txt: 7352 rows of 561 measurement variables. These are measurement variables listed in features.txt
*	yTrain.txt: 7352 rows of 1 variables. This is the activity Identifier
*	subjectTrain.txt: 7352 rows of 1 variable (subject Identifier)

________________________________________

###Map of aggregated Data

*	Variable Names subjectId activityId (variable names from features.txt)
*	Data subjectTest.txt yTest.txt xTest.txt
*	Data subjectTrain.txt yTrain.txt xTrain.txt 

________________________________________

##Requirements and Details of Transformations through run_analysis.Rscript

###Requirements run_analysis.R script has the following requirements to perform transformation on UCI HAR Dataset.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

###Detailed Functions of run_analysis.R Script:

*	Downloads the dataset from the URL mentioned above and unzips it to create data folder
*	Imports "test" and "train" datsets and creates data frames from then and then merges the training and the test sets to create one data frame.
*	Extracts a subset of data with only the measurements on the mean "mean()" and standard deviation "std()" for each    measurement. Also excludes meanFreq()-X measurements or angle measurements where the term mean exists resulting in 66 measurement variables.
*	Updates the variable names in dataframe variable names for data fame to improve readibility
*	Appropriately labels the data set with descriptive activity names in place of activity Ids
*	Reshapes dataset to create a data frame with average of each measurement variable for each activity and each subject
*	Writes new tidy data frame to a text file to create the required tidy data set file of 180 observations and 68 columns (2 columns for activityName and subjectID and 66 columns for measurement variables) 

________________________________________

##Merge Activities

subjectTest, yTest, xTest were column bind using cbind function to create testData data frame which added"subjectId", "activityId" to dataset making it 563 column data.frame with 2947 rows subjectTrain, yTrain,xTrain were column bind using cbind function to create trainData data.frame which added "subjectId","activityId" to dataset making it 563 column data.frame with 7352 rows. 
________________________________________

##Aggregated and Merged Dataset

testData and trainData data.frame were rowbound using rbind function to create final dataset/data.frame called AllData with 10299 rows and 563 columns.

________________________________________

##Final Dataset finalData

"activityId" column which is no longer needed because we mapped acitityName to activityId in the dataset, "activityId" column is dropped to create final data.frame called finalData.This data frame has 10299 observations and 68 columns.2 columns for "activityName" and "subjectId" and remaing 66 for measurement variables with measurements 3 on the mean() and std(). 

________________________________________

## Tidy Data Set with the average of each variable for each activity and each subject 

## Activities:

* Reshape dataset to create a data frame with average of each measurement variable for each activity and each subject
*	Writes new tidy data frame to a text file to create the required tidy data

##Transformation Details - melt and dcast
* reshape2 package is leveraged for reshaping the dataset. library(reshape2)
* melt function of reshape2 package is leveraged to reshape data based on id variables "activityName" and "subjectId" against all measurement values variables to create finalDataMelt data frame.
*	melt takes wide-format data and melts it into long-format data.
*	finalDataMelt data frame has 679734 observations of 4 variables 

________________________________________ 

##Tidy Data File

The tidy data frame is written to a file using write.table function with "\t" separator to create tidy.txt file. By default column names are kept in file. Row Names have to be explicity excluded using row.names=FALSE argument in write.table function.
