## Abstract:

In this project, data were extracted from UCI Machine Learning repository. In this data set, Human Activity Recognition Using Smartphones Data Set were studied. Human activity recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. 
Data Set Characteristics:  	Multivariate, Time-Series	Number of Instances:	10299	Area:	Computer
Attribute Characteristics:	N/A	Number of Attributes:	561	Date Donated	2012-12-10
Associated Tasks:	Classification, Clustering	Missing Values?	N/A	Number of Web Hits:	479285
•	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

## Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. Check the README.txt file for further details about this dataset. 
A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the UCI website: (https://www.youtube.com/watch?v=XOEN9W05_4A). 
An updated version of this dataset can be found at [http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions]. It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows.

## Attribute Information:
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## The set of variables that were estimated from these signals are:
-	mean(): mean value 
-	std(): standard deviation

## Using an R script (run_analysis.R) the raw data were used to create a tidy data set for further analysis.
>if(!file.exists("./data")){dir.create("./data")}
Warning message:
package ‘lubridate’ was built under R version 3.3.3 
> fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> unzip(zipfile="./data/Dataset.zip", exdir="./data")
> x_train<- read.table("./data/UCI HAR Dataset/train/X_train.txt")
> unzip(zipfile="./data/Dataset.zip", exdir="./data")
> 
> y_train<- read.table("./data/UCI HAR Dataset/train/y_train.txt")
> subject_train<- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
> x_test<- read.table("./data/UCI HAR Dataset/test/X_test.txt")
> y_test<- read.table("./data/UCI HAR Dataset/test/y_test.txt")
> subject_test<- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
> features<- read.table("./data/UCI HAR Dataset/features.txt")
> features<- read.table('./data/UCI HAR Dataset/features.txt')
> activityLabels<- read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Merge training and test sets:
Test and training data (X-train.txt, X_test.txt), subject Ids (subject_train.txt, subject_test.txt), and activity Ids (y_train.txt, y_test.txt) are merged to obtain a single data set. Variables are labelled with the names assigned by original collectors (features.txt).
> colnames(x_train)<- features[,2]
> colnames(y_train)<- "activityId"
> colnames(subject_train)<- "subjectId"
> 
> colnames(x_test)<- features[,2]
> colnames(y_test)<- "activityId"
> colnames(subject_test)<- "subjectId"
> colnames(activityLabels)<- c('activityId', 'activityType')
> 
> mrg_train<- cbind(y_train, subject_train, x_train)
> mrg_test<- cbind(y_test, subject_test, x_test)
> SetAllInOne<- rbind(mrg_train, mrg_test)
> colNames<- colnames(SetAllInOne)

## Extract mean and standard deviation variables:
From the merged data set, the mean (variables with labels that contain “mean”) and standard deviation (variables with labels that contain “std”).
> mean_and_std <- (grepl("activityId" , colNames) | 
+ grepl("subjectId" , colNames) | 
+ grepl("mean.." , colNames) | 
+ grepl("std.." , colNames))
> setForMeanAndStd <- SetAllInOne[ , mean_and_std == TRUE]


## Use descriptive activity names:
Activity description data was added to a new column. Activity id column is used to look up descriptions
in activity_labels.txt.

> setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
+ by='activityId',
+ all.x=TRUE)
> secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
> secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

## The data set is written to a file named secTidySet text file:
> write.table(secTidySet, "secTidySet.txt", row.name=FALSE)


Source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones# 
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws
Contact GitHub 
