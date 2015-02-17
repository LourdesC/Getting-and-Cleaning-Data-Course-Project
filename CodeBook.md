This code book that describes the variables, the data, and any transformations or work that I performed to clean up
the data.

# ANALISYS 

Section 1. Merge the training and the test sets to create one data set.
 first I merge the test set (x_test, y_test, subject_test) whith cbind() and I save the result in  testData
 second I merge the train set (x_test, y_test, subject_test) whith cbind() and I save the result in trainData
 third I merge the testData and trainData with rbind and I save the result in dataset
 
Section 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 In this section I use de instruction grepl() for selection the mean and std and I create a new data set 
 called mean_std_Data , with the measurements on the mean and standard deviation for each measurement.
 
Section 3.- Uses descriptive activity names to name the activities in the data set.
  In this section I create a new data set called data_activity with contens the label of activities.
 
Section 4.- Appropriately labels the data set with descriptive variable names.
For this section I use the funxtion gsub().

Section 5.- From the data set in step 4, creates a second, independent tidy data set with the average of each 
variable for each activity and each subject.
 I create a new data set called tidyData and the file tidyData.txt  using write.table()

# ANALISYS  
 
 x_test, y_test, subject_test,  x_train, y_train, subject_train contain the data from the downloaded files.
 trainData contain merge of x_train, y_train, subject_train 
 testData contain merge of x_test, y_test, subject_test
 dataset contain merge of trainData and testData.
 mean_std_Data is a data set with only the measurements on the mean and standard deviation foreach measurement.
 data_activity is the previous data set with labels for activities.
 tidyData is the final data set with the with the average of each variable for each activity and each subject
 
 

