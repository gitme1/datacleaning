################################################################################################################################
##                                                                                                                            ##                          
##  Data_Cleaning Project: This project is divided into 2 parts as follows                                                    ##
##    Part 1:                                                                                                                 ##  
##      a) read in several text files(training and test sets), merge them to create 1 dataset                                 ##
##      b) extract only the measurements on the mean and standard deviation for each measurement                              ##
##    Part 2:                                                                                                                 ##
##      a) create a second, independent tidy data set with the average of each variables for each activity and each subject   ##
##      b) write that tidy data set as a text file                                                                            ##
##                                                                                                                            ##
################################################################################################################################


## Part1: read files, combine files, extract measurement variables
##        create a dataset for Part2
 
# set working directory
setwd("C:/DataScience_Cleaning/Project")

# read in subject_test.txt(subject), y_test.txt(activity) & x_test.txt(measurements)
subject_test <- read.table("c:/DataScience_Cleaning/Project/Dataset/test/subject_test.txt")
Y_test <- read.table("c:/DataScience_Cleaning/Project/Dataset/test/Y_test.txt")
X_test <- read.table("c:/DataScience_Cleaning/Project/Dataset/test/X_test.txt")

# check any na in those (subject_test,X_test,Y_test): None here
sum(is.na(subject_test))
sum(is.na(Y_test))
sum(is.na(X_test))

# change the column names
colnames(subject_test)<-"subject"
colnames(Y_test)<-"activity"

# combine them: (subject_test,Y_test,X_test) into 1 data set(test)
test <- cbind(subject_test, Y_test, X_test)

# read in subject_train.txt(subject), y_train.txt(activity) & x_train.txt(measurements)
subject_train <- read.table("c:/DataScience_Cleaning/Project/Dataset/train/subject_train.txt")
Y_train <- read.table("c:/DataScience_Cleaning/Project/Dataset/train/Y_train.txt")
X_train <- read.table("c:/DataScience_Cleaning/Project/Dataset/train/X_train.txt")

# check any na in those (subject_train,X_train,Y_train)
sum(is.na(subject_train))
sum(is.na(Y_train))
sum(is.na(X_train))

# change the column names
colnames(subject_train)<-"subject"
colnames(Y_train)<-"activity"

# combine them: (subject_train,Y_train,X_train) into 1 data set(train)
train <- cbind(subject_train, Y_train, X_train)

# combine test and train into 1 data set(dataset)
dataset <- rbind(train,test)

# change activity to character and assign associated names based on the activity labels
activities <- read.table("c:/DataScience_Cleaning/Project/Dataset/activity_labels.txt")
dataset$activity<-as.character(dataset$activity)
dataset$activity[dataset$activity=="1"]<-as.character(activities[1,2])
dataset$activity[dataset$activity=="2"]<-as.character(activities[2,2])
dataset$activity[dataset$activity=="3"]<-as.character(activities[3,2])
dataset$activity[dataset$activity=="4"]<-as.character(activities[4,2])
dataset$activity[dataset$activity=="5"]<-as.character(activities[5,2])
dataset$activity[dataset$activity=="6"]<-as.character(activities[6,2])

# read in feature list, make a column name list(col_name), change the column names of dataset:(dataset)
features <- read.table("c:/DataScience_Cleaning/Project/Dataset/features.txt")
feature_list <- (features[,2])                  
col_name <- c("subject","activity")
col_name <- append(col_name,as.character(feature_list),after=2)
names(dataset) <- col_name

# select variables with mean() and std(),find the length of mean_name
index_mean <- grep("mean()",fix=TRUE,colnames(dataset))
mean_name <- names(dataset[index_mean])
len_mean <- length(mean_name)
index_std <- grep("std()",fix=TRUE,colnames(dataset))
std_name <- names(dataset[index_std])

# create a data set(data): subject, activity, all mean var.go first, follow by all std var.
#  also create 2 column list: 1 for mean, 1 for std, both with subject & activity
cols <- c("subject","activity")
cols_mean <- append(cols, as.character(mean_name),after=2)
cols_std <- append(cols, as.character(std_name),after=2)
select_var <- append(mean_name, as.character(std_name), after=len_mean)
cols_select <- append(cols, as.character(select_var),after=2)
data <- dataset[,cols_select]


## Part2: create a data set:tidy_data with ave of each variable for each activity and each subject
##          here variable:66, subject:30, activity:6; rows=180(30x6), columns=68(66+2) 

#subset to 2 data set: 1 for mean(data_mean), 1 for std(data_std) 
#   to calculate ave of mean & std base on the combination of subject & activity
data_mean <- subset(data[,cols_mean])
ave_mean <- aggregate(.~subject+activity,data=data_mean,mean)

data_std<-subset(data[,cols_std])
ave_std<-aggregate(.~subject+activity,data=data_std,sd)

# merge into 1 data set(tidy_data) with ordered by subject
tidy <- merge(ave_mean,ave_std)
tidy_data <- tidy[order(tidy$subject,decreasing=FALSE), ]

# write to file with column names but no row names(system generated id here)
write.table(tidy_data, file="c:/DataScience_Cleaning/Project/tidy_data.txt",row.names=FALSE)

# check the text file by re-read back into dataset
#  text_h<-read.table("c:/DataScience_Cleaning/Project/tidy_data.txt",header=TRUE)
#  View(text_h)
