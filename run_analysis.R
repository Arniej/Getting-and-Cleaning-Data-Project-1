# Creating a directory named "data" using commands file.exists and dir.create
if(!file.exists("./data")){dir.create("./data")}

# Store the dataset in a file named "fileUrl" 
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Down load fileUrl and store it in folder data file Dataset
download.file(fileUrl, destfile = "./data/Dataset.zip")

# Unzip the Dataset file and store it in data folder
unzip(zipfile="./data/Dataset.zip", exdir="./data")

# Using read.table command, read the data (X_train, y_train, subject_train, X_test, y-test, subject_test) from "train" and "test" folders 
# and store them in corresponding files as below
x_train<- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train<- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test<- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("./data/UCI HAR Dataset/test/y_test.txt")
sub_test<- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features<- read.table('./data/UCI HAR Dataset/features.txt')
activityLabels<- read.table('./data/UCI HAR Dataset/activity_labels.txt')
