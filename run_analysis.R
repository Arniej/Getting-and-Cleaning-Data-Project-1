# Creating a directory named "data" using commands file.exists and dir.create:
if(!file.exists("./data")){dir.create("./data")}

# Store the dataset in a file named "fileUrl":
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Down load fileUrl and store it in folder ./data/Dataset:
download.file(fileUrl, destfile = "./data/Dataset.zip")

# Unzip the Dataset file and store it in ./data directory:
unzip(zipfile="./data/Dataset.zip", exdir="./data")

# Using read.table command, read the trainings tables (Activity, Subject, Features) including X_train, y_train, subject_train:
x_train<- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train<- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Read the testing tables (Activity, Subject, Features files) including X_test, y-test, subject_test: 
x_test<- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test<- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Read Features and Activity Lables files:
features<- read.table('./data/UCI HAR Dataset/features.txt')
activityLabels<- read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Assign each column names:
colnames(x_train)<- features[,2]
colnames(y_train)<- "activityId"
colnames(subject_train)<- "subjectId"
colnames(x_test)<- features[,2]
colnames(y_test)<- "activityId"
colnames(subject_test)<- "subjectId"
colnames(activityLabels)<- c('activityId', 'activityType')

# Merge all data in one set named "SetAllInOne":
mrg_train<- cbind(y_train, subject_train, x_train)
mrg_test<- cbind(y_test, subject_test, x_test)
SetAllInOne<- rbind(mrg_train, mrg_test)

# Extract mean and standard deviation for each measurement:
mean_and_std <- (grepl("activityId" , colNames) | 
grepl("subjectId" , colNames) | 
grepl("mean.." , colNames) | 
grepl("std.." , colNames))

# Make subset from SetAllInOne: 
setForMeanAndStd <- SetAllInOne[ , mean_and_std == TRUE]

# Use descriptive activity names to name the activities in the data set:
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
by='activityId',
all.x=TRUE)

# Create a second, independent tidy data set with average of each variable:
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# Write second tidy data set in txt file format:
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)



