# Datacleaning_Coursera
Project for Coursera course - Getting and Cleaning Data


The run_analysis.R file will automatically download the Samsung data and unzip in the working directory.
By running the code, the output meantable.txt file of average of each variable for each activity and each subject will be in the output folder of unzipped UCI HAR Dataset folder.


Code book for main variables:

dataset_all: The raw data set by combining test, training as well as their respective subject (1~30) and activity index (1~6);
dataset: Capture only the mean and standard deviation measurements from dataset_all;
activity_name: Transforming subject and activity index into descriptive name (e.g., "subject 1 WALKING", "subject 10 SITTING", etc.);
cleanset: Replacing subject and activity index columns with activity_name in dataset;
meantable: The required output file of data.
