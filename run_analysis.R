####Getting and Cleaning Data Course Project####################################
# You should create one R script called run_analysis.R that does the following.# 
#                                                                              #
# 1.- Merges the training and the test sets to create one data set.            #
# 2.- Extracts only the measurements on the mean and standard deviation for    # 
#      each measurement.                                                       #
# 3.- Uses descriptive activity names to name the activities in the data set   #
# 4.- Appropriately labels the data set with descriptive variable names.       #
#                                                                              #
# 5.- From the data set in step 4, creates a second, independent tidy data set #
#    with the average of each variable for each activity and each subject.     #
################################################################################

library(plyr)


## comprobamos el directorio de trabajo:
getwd()
# Read in the data from files features y activity_labels
 
features = read.table('./features.txt',header=FALSE); #imports features.txt
activity = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
#Assigin column names to the activity
colnames(activity) = c('activityId','activityType');

#Read in the data from test files
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)
subject_test <- read.table("./test/subject_test.txt", header = FALSE)

#Assigin column names to the data test files

colnames(subject_test) = "subjectId";
colnames(x_test) = features[,2];
colnames(y_test) = "activityId";

# create "test" data set
testData <- cbind(y_test, subject_test, x_test)

#Read in the data from train files
x_train <- read.table("./train/X_train.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
subject_train <- read.table("./train/subject_train.txt", header = FALSE)

#Assigin column names to the data train files

colnames(subject_train) = "subjectId";
colnames(x_train) = features[,2];
colnames(y_train) = "activityId";

# create "train" data set
trainData <- cbind(y_train, subject_train, x_train)

# Merges the training and the test sets to create one data set. 
dataset <- rbind(trainData, testData)
colNames  = colnames(dataset)

##2.- Extracts only the measurements on the mean and standard deviation for     
# each measurement. 

selection = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean()..",colNames)  | grepl("-std()..",colNames) )& !grepl("-meanFreq()..",colNames)
mean_std_Data= dataset[selection== TRUE]
colnames(mean_std_Data)

# 3.- Uses descriptive activity names to name the activities in the data set
data_activity = merge(mean_std_Data,activity,by='activityId',all.x=TRUE);
names(data_activity)

#4.- Appropriately labels the data set with descriptive variable names.
names(data_activity)<-gsub("^t", "time", names(data_activity))
names(data_activity)<-gsub("^f", "frequency", names(data_activity))
names(data_activity)<-gsub("Acc", "Accelerometer", names(data_activity))
names(data_activity)<-gsub("Gyro", "Gyroscope", names(data_activity))
names(data_activity)<-gsub("Mag", "Magnitude", names(data_activity))
names(data_activity)<-gsub("BodyBody", "Body", names(data_activity))
names(data_activity)

# 5.- From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

tidyData = aggregate(. ~subjectId + activityId, data_activity, mean)
tidyData<-tidyData[order(tidyData$subjectId,tidyData$activityId),]

write.table(tidyData, file = "tidydata.txt",row.name=FALSE)
