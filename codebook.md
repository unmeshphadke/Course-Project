This is the readme file for the course project for the Getting and Cleaning Data course.
This file describes the steps taken in the script to achieve the required task for this project.

The required tasks for this project are:
1: Create one R script called run_analysis.R that does the following. 
2: Merges the training and the test sets to create one data set.
3: Extracts only the measurements on the mean and standard deviation for each measurement. 
4: Uses descriptive activity names to name the activities in the data set
5: Appropriately labels the data set with descriptive variable names. 
6: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data is present in The UCI HAR dataset directory is assumed to be in the working directory in R(working directory given by getwd() function.)
1: Initially the read.table function is use dto read in the relevant data. training_data dataframe contains the training_set. subject_train has 
info about subject indexes. activity_train has the activity labels.

2: Same procedure is done for the test set data for the relevant files. The dataframes have similar names with "train" replaced by "test".he string meanFReq

3: Now the features are read into the features_data dataframe. Similarly activities are read into activity dataframe and its second row is selected which
   contains teh column names.

4: The features_data datframe is now used to appropriately label the columns if the training and test set dataframes.

5: Now the subject indexes and the activity numbers columns are added to the training and test dataframes. The columns are also labelled appropriately.

6: Same thing is done for the test set dataframe(test_data).

7: It can be checked that the number of rows in the training_data and teh test_data dataframes is the same. Thus both the data frames have the same
   variables. The test and training sets are from the same large dataset. So they can be merged by just using a singlle rbind function call. This
   completes the merging of training_data and test_data.

8: Now the activity column is converted from numeric to factor by using hte activities vector. This labels the various activities by their names rather
   than by their numbers or indexes.

9: Now we take only those measurements on the mean and the standard deviation. We use the grepl function to index the required columns. The grepl function takes 
  only those columns which have the string "std()" or "mean()" in their names. (This approach also includes the columns having the string "meanFreq()").

10:The new dataframe is named as "dff". We now append the subject and the activity columns to the dataframe dff. We rename the columns appropriately.

11:The group_by() function is then used to first group the dataframe according to Activity and then the subject. 

12: We now perform the step of getting the mean of each variable for each actvity,each subject. for this we use the aggregate() function in r. We take the mean of all 
    other columns in the dataframe for each activity each subject.( we use  "by=list(dff$subject,dff$Activity)" argument to obtain for each activity , each subject.).

13: The dataframe at this juncture is a very wide one containing about 80 odd columns. We now use hte melt function to convert it to  a thinner dataframe. We do this 
    by converting all the feature columns into a single column with each entry in that column representing one of the features.

14: We now write this dataframe which is our tidy data set to a file labelled TidyData.txt.
 .