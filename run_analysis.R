
#Download and unzip data, change directory if necessary
setwd("C:/Users/lianx/Desktop/Coursera/R Programming/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "./raw.zip")
unzip("raw.zip")

#Read all necessary data sets
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
activity_label <- read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")

#Combine test and training data sets with subject (1~30) and activity (1~6), and names the columns
subject <- rbind(subject_test, subject_train)
colnames(subject) <- "subject"
activity <- rbind(y_test, y_train)
colnames(activity) <- "activity"
raw <- rbind(test, train)
colnames(raw) <- features$V2
dataset_all <- cbind(subject, activity, raw)

#Extracts only the mean and standard deviation for each measurement
l1 <- grep("mean\\(", names(dataset_all))
l2 <- grep("std\\(", names(dataset_all))
list <- c("1", "2", l1, l2)
dataset <- dataset_all[, as.numeric(list)]

#Generate descriptive names for each observation ("subject # + activity name")
activity_name <- c()
for(i in 1:nrow(dataset))  { activity_name[i] <- paste("subject", dataset[i,1], activity_label$V2[dataset[i,2]]) }
cleanset <- cbind(activity_name, dataset[3:ncol(dataset)])

#Creates a tidy data set with the average of each variable for each activity and each subject
meantable <- data.frame(matrix(nrow = 180, ncol = ncol(cleanset)-1))
names(meantable) <- names(cleanset)[2:ncol(cleanset)]

k <- 1
#Loop each of 30 subject
for(i in 1:30){
  
  #Loop each of 6 activity
  for(j in activity_label$V2){         
    name <- paste("subject", i, j)
    rownames(meantable)[k] <- paste(name, "mean")
    index <- grep(name, cleanset$activity_name)
    
    #Loop each of 66 selected measurements
    for(n in 2:ncol(cleanset)) { meantable[k, n-1] <- mean(cleanset[index, n]) }
    k <- k+1
  }
}

#Output meantable.txt
if(!dir.exists("./UCI HAR Dataset/output/")) { dir.create("./UCI HAR Dataset/output/") }
write.table(meantable, file = "./UCI HAR Dataset/output/meantable.txt", row.names = FALSE)


