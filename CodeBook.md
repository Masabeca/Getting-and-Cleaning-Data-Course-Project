####CodeBook
Course Project for Getting and Cleaning Data based on Human Activity Recognition Using Smartphones Dataset.
This CodeBook that describes the variables, the data, and any transformations or work that was performed to clean up
the source data to create a tidy dataset as per requirements of course project.
________________________________________
##Information about Source Data Experiment
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial
linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned
into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
________________________________________
## Data Source
*Original data source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
*Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
________________________________________
#Structure of Data present in source data folders
*	README.txt: Details of all the files in downloaded folder
*	features_info.txt: Shows information about the variables used on the feature vector.
*	features.txt: List of all features.i.e list of all measurement variables
*	activity_labels.txt: Lists the activity Id with their corresponding activity name.
*	train/X_train.txt: Training set.
*	train/y_train.txt: Training activity Id Labels
*	train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is     from 1 to 30.
*	test/X_test.txt: Test set.
*	test/y_test.txt: Test activity Id Labels
*	test/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is      from 1 to 30.
#The following files are available for the train and test data. Their descriptions are equivalent.
*	train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard    gravity units g. Every row shows a 128 element vector. The same description applies for the
*  total_acc_x_train.txt and total_acc_z_train.txt files for the Y and Z axis.
*	train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from
   the total acceleration.
*	train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window          sample. The units are radians/second.
   Note: All the files in train/Inertial Signals and test/Inertial Signals will not be used for in this analysis
________________________________________
###Details about Files to be used in analysis from Source Data
##Common Files
*	features.txt: 561 rows of 2 varibles (feature Identifier and feature Name)
*	activity_labels.txt: 6 rows of 2 variables (activity identifier and activity name)
##Test Dataset
*	xTest.txt: 2947 rows of 561 measurement variables. These are measurement variables listed in features.txt
*	yTest.txt: 2947 rows of 1 variables. This is the activity Identifier
*	subjectTest.txt: 2497 rows of 1 variable (subject Identifier)
##Training Dataset
#*	xTrain.txt: 7352 rows of 561 measurement variables. These are measurement variables listed in features.txt
#*	yTrain.txt: 7352 rows of 1 variables. This is the activity Identifier
#*	subjectTrain.txt: 7352 rows of 1 variable (subject Identifier)
###Map of aggregated Data
#*Variable Names	subjectId	activityId	(variable names from features.txt)
#*Data	subjectTest.txt	yTest.txt	xTest.txt
#*Data	subjectTrain.txt	yTrain.txt	xTrain.txt
________________________________________
###Requirements and Details of Transformations through run_analysis.Rscript
##Requirements
#run_analysis.R script has the following requirements to perform transformation on UCI HAR Dataset.
#*1.Merges the training and the test sets to create one data set.
#*2.Extracts only the measurements on the mean and standard deviation for each measurement.
#*3.Uses descriptive activity names to name the activities in the data set
#*4.Appropriately labels the data set with descriptive activity names.
#*5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Detailed Functions of run_analysis.R Script
#*	Downloads the dataset from the URL mentioned above and unzips it to create UCI HAR Dataset folder
#*	Imports "test" and "train" datsets and creates data frames from then and then Merges the training and the test sets
#  to create one data frame.
#*	Extracts a subset of data with only the measurements on the mean "mean()" and standard deviation "std()" for each
#  measurement. Also excludes meanFreq()-X measurements or angle measurements where the term mean exists resulting in
#  66 measurement variables.
#* Updates the variable names in dataframe variable names for data fame to improve readibility
#*	Appropriately labels the data set with descriptive activity names in place of activity Ids
#*	Reshapes dataset to create a data frame with average of each measurement variable for each activity and each subject
*	Writes new tidy data frame to a text file to create the required tidy data set file of 180 observations and 68 columns (2    columns for activityName and subjectID and 66 columns for measurement variables)
________________________________________
##Merge Activities
#subjectTest, yTest, xTest were column bind using cbind function to create testData data frame which added"subjectId", #"activityId" to dataset making it 563 column data.frame with 2947 rows subjectTrain, yTrain,xTrain were column bind using #cbind function to create trainData data.frame which added "subjectId","activityId" to dataset making it 563 column #data.frame with 7352 rows
##Aggregated and Merged Dataset
#testData and trainData data.frame were rowbound using rbind function to create final aggregated dataset/data.frame 
#AllData with 10299 rows and 563 columns
#Below code shows few details of AllData
#> head(names(AggregateData),10)
# [1] "subjectId"         "activityId"        "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"
# [5] "tBodyAcc-mean()-Z" "tBodyAcc-std()-X"  "tBodyAcc-std()-Y"  "tBodyAcc-std()-Z" 
# [9] "tBodyAcc-mad()-X"  "tBodyAcc-mad()-Y" 
#> 

#> head(AllData[1:3])
# subjectId activityId tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
#1         2          5         0.2571778       -0.02328523       -0.01465376
#2         2          5         0.2860267       -0.01316336       -0.11908252
#3         2          5         0.2754848       -0.02605042       -0.11815167
#> 
________________________________________
#Extraction of only the measurements on the mean and standard deviation for each measurement.
#Activities:
#•	Extract a subset of data with only the measurements on the mean mean() and standard deviation std() for
#each measurement
#Extraction of selected measurement values
#•	grep functions are used to search for occurance of mean mean() and standard deviation std() in AggregateData
#  variable Names using escape characters.
#•	Using escape characters to search exactly for mean() and std() occurance helps to exclude meanFreq()-Xmeasurements
#  and/or angle measurements where the term mean exists
#•	The resulting selection would have only 66 measurement variables.

#Below code shows search using grep functions in column names of AggregateData data frame.
#> head(featureVariables[grepl("mean\\(\\)|std\\(\\)", names(AggregateData)), ], 10)
   varId              varName
3      3    tBodyAcc-mean()-Z
4      4     tBodyAcc-std()-X
5      5     tBodyAcc-std()-Y
6      6     tBodyAcc-std()-Z
7      7     tBodyAcc-mad()-X
8      8     tBodyAcc-mad()-Y
43    43 tGravityAcc-mean()-Z
44    44  tGravityAcc-std()-X
45    45  tGravityAcc-std()-Y
46    46  tGravityAcc-std()-Z
> 
> 
> 
> tail(featureVariables[grepl("mean\\(\\)|std\\(\\)", names(AggregateData)), ])
    varId                    varName
518   518  fBodyBodyAccJerkMag-mad()
519   519  fBodyBodyAccJerkMag-max()
531   531     fBodyBodyGyroMag-mad()
532   532     fBodyBodyGyroMag-max()
544   544 fBodyBodyGyroJerkMag-mad()
545   545 fBodyBodyGyroJerkMag-max()
> 
•	In order to extract a subset of only measurements on the mean mean() and standard deviation std() grep is used
to create index of matched column numbers.
•	This index of column numbers is used to create subset of data based on mean() and std() column indices and also includng first 2 columns which have subjectId and activityId values.
Below code show the Index of occurance for mean() and std()
> head(grep("mean\\(\\)|std\\(\\)", names(AggregateData)), 10)
 [1]  3  4  5  6  7  8 43 44 45 46
> 
This stage crates a data.frame subsetAggregateData of 10299 observations and 68 variables
________________________________________
Clean up variable names to in the data set
Activities:
•	Update the variable names in dataframe for data fame to improve readibility
Variable Transformation activities
•	camelcase has been used for R objects created and variable names for data fame to improve readibility.
•	gsub function is used to remove instances of "-" and "()" from variables names in the extracted subset
subsetAggregateData data.frame
•	Instances of mean are replaced by Mean and std by Std to obtain proper camelcase in variable names
e.g. "tBodyAcc-mean()-X" is changed to "tBodyAccMeanX"
Usage of gsub function
gsub("-", "", names(subsetAggregateData))
Below code shows the changes in variable names after cleaning up variable names.
> head(names(AggregateData))
[1] "subjectId"         "activityId"        "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"
[5] "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" 
> 
> head(names(subsetAggregateData))
[1] "subjectId"     "activityId"    "tBodyAccMeanX" "tBodyAccMeanY" "tBodyAccMeanZ" "tBodyAccStdX" 
> 
________________________________________
Label the data set with descriptive activity names.
Activities:
•	Appropriately label the data set with descriptive activity names in place of activity Ids
ActivityName Update
•	activityLabels and tidy data frames are merged using merge function to add a new column
and create a new data.framesubFinalData with corresponding "activityName" for each "activityId" in each row of the
dataset
The below code snippet shows updated activityName in the dataset
> head(subFinalData[1:5])
  activityId activityName subjectId tBodyAccMeanX tBodyAccMeanY
1          1      WALKING        26     0.2314146  -0.017722438
2          1      WALKING        29     0.3312213  -0.018502366
3          1      WALKING        29     0.3755700  -0.024728610
4          1      WALKING        29     0.2332297  -0.034451457
5          1      WALKING        29     0.2362494  -0.014396940
6          1      WALKING        29     0.2645428   0.002484389
> 
Final Dataset finalData
•	"activityId" column which is no longer needed because we mapped acitityName to activityId in the dataset
•	"activityId" column is dropped to create final data.frame called finalData
•	This data frame has 10299 observations and 68 columns.
•	2 columns for "activityName" and "subjectId" and remaing 66 for measurement variables with measurements
on the mean() and std()
________________________________________
Tidy Data Set with the average of each variable for each activity and each subject
Activities:
•	Reshape dataset to create a data frame with average of each measurement variable for each activity and each subject
•	Writes new tidy data frame to a text file to create the required tidy data
Transformation Details - melt and dcast
•	reshape2 package is leveraged for reshaping the dataset. library(reshape2)
•	melt function of reshare2 package is leveraged to reshape data based on id variables "activityName" and
"subjectId" against all measurement values variables to create finalDataMelt data frame.
•	melt takes wide-format data and melts it into long-format data.
•	finalDataMelt data frame has 679734 observations of 4 variables
Using melt
The below code shows data transformation done by using melt function to create finalDataMelt data frame
> head(finalDataMelt)
  activityName subjectId      variable     value
1      WALKING        26 tBodyAccMeanX 0.2314146
2      WALKING        29 tBodyAccMeanX 0.3312213
3      WALKING        29 tBodyAccMeanX 0.3755700
4      WALKING        29 tBodyAccMeanX 0.2332297
5      WALKING        29 tBodyAccMeanX 0.2362494
6      WALKING        29 tBodyAccMeanX 0.2645428
> 
Using dcast
•	lastly, dcast function of reshap2 package is leveraged for creating new tidy data.frame called avgSujectActivities
•	This dataset provides average of each measurement variable for each activity and each subject
•	dcast takes long-format data and casts it into wide-format data.
Tidy data frame
•	The result od dcast operation is the tidy data frame avgSujectActivities
•	This data frame has 180 observations/rows and 68 columns/variables
•	68 columns(2 columns for activityName and subjectID and 66 columns for measurement variables)
•	Each measurement variable columns [3 to 68] is average value for each combination of subjectId andactivityName
The below code shows few details of the Tidy data frame
> head(avgSujectActivities[1:7])
  activityName subjectId tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ tBodyAccStdX tBodyAccStdY
1       LAYING         1     0.2215982   -0.04051395    -0.1132036   -0.9280565   -0.8368274
2       LAYING         2     0.2813734   -0.01815874    -0.1072456   -0.9740595   -0.9802774
3       LAYING         3     0.2755169   -0.01895568    -0.1013005   -0.9827766   -0.9620575
4       LAYING         4     0.2635592   -0.01500318    -0.1106882   -0.9541937   -0.9417140
5       LAYING         5     0.2783343   -0.01830421    -0.1079376   -0.9659345   -0.9692956
6       LAYING         6     0.2486565   -0.01025292    -0.1331196   -0.9340494   -0.9246448
> 
Tidy Data File
•	The tidy data frame is written to a file using write.table function with "\t" separator to
create tidy.txt file
•	By default column names are kept in file. Row Names have to be explicity excluded using row.names=FALSE argument
in write.table function
##Description of variables in the Tidy Data
#Variable Name	Details

