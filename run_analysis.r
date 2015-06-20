library(dplyr)
library(plyr)
library(reshape2)
#Change the working directory to the downloaded file. The file is downloaded in the same working directory as the directory given by the getwd() command.

setwd("./UCI HAR Dataset")

#Start for the training set
setwd("./train")
training_data<-read.table("./X_train.txt")
subject_train<-read.table("./subject_train.txt")
activity_train<-read.table("./y_train.txt")
 
#Get the test set data as well
setwd("..")  #Go back to the downloaded file
setwd("./test")
test_data<-read.table("./X_test.txt")
subject_test<-read.table("./subject_test.txt")
activity_test<-read.table("./y_test.txt")

#Get the features .
setwd("..")
features_data<-read.table("./features.txt")

#dim(features_data)
col_names<-t(features_data[,2])
names(training_data)<-col_names
names(test_data)<-col_names
#Finished labelling the columns of the data frame

#Adding the subject and activity columns
training_data<-cbind(cbind(training_data,subject_train),activity_train)
names(training_data)[562:563]<-c("subject","Activity")

test_data<-cbind(cbind(test_data,subject_test),activity_test)
names(test_data)[562:563]<-c("subject","Activity")
activity<-read.table("./activity_labels.txt")
activities<-activity[,2]

#v1<-names(training_data)
#v2<-names(test_data)
#g<-v1==v2

#Now merging
#df<-merge(x=training_data,y=test_data,all=TRUE)
df<-rbind(training_data,test_data)

#Applying the activity labels
df$Activity<-as.character(factor(df$Activity,labels=activities))

#Now taking only those measurements related to mean() and std()
dff<-df[,grepl("mean()",names(df))|grepl("std()",names(df)) ]
#Again bind the subject and the activity columns to the new dataframe
dff<-cbind(dff,df$subject)
dff<-cbind(dff,df$Activity)
names(dff)[(ncol(dff)-1):ncol(dff)]<-c("subject","Activity")

#Group by activity and subject
dff<-group_by(dff,Activity)
dff<-group_by(dff,subject)

#now step 5. Getting the mean  for each activity each subject.
#The aggregate function plays a similar role like the ddply but it allows for multiple variables in place of a single variable inside .()  in ddply.
dff_final<-aggregate(dff[,1:(ncol(dff)-2)],by=list(dff$subject,dff$Activity),FUN=mean,na.rm=TRUE)
names(dff_final)[1:2]<-c("Subject","Activity")

#Using the melt function in r to convert to a long but thin data frame.
dff_final1<-melt(dff_final,id=c("Subject","Activity"))

#Now write tidy dataset to a file
write.table(dff_final1,file="TidyData.txt",row.name=FALSE,sep="\t")

