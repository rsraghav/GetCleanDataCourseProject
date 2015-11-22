# projectFileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?accessType=DOWNLOAD"
# download.file(projectFileURL,destfile="UCI_HAR_dataset.zip",method="curl")
#unzip("UCI_HAR_dataset.zip")
setwd("UCI HAR Dataset")
xTrain <- read.table("train/X_train.txt")
xTest <- read.table("test/X_test.txt")
subjTrain <- read.table("train/subject_train.txt")
subjTest <- read.table("test/subject_test.txt")
actTrain <- read.table("train/y_train.txt")
actTest <- read.table("test/y_test.txt")

library(dplyr)
meanStdTrain <- xTrain[,c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,530,531,542,543)]
meanStdTest <- xTest[,c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,530,531,542,543)]

subjActMeanStdTrain <- data.frame(subjTrain,actTrain,meanStdTrain)
subjActMeanStdTest <- data.frame(subjTest,actTest,meanStdTest)

allSelectData <- rbind(subjActMeanStdTrain,subjActMeanStdTest)
varBodyNames <- c("timeBodyAccelerationXmean","timeBodyAccelerationYmean","timeBodyAccelerationZmean","timeBodyAccelerationXstandardDev","timeBodyAcceleartionYstandardDev","timeBodyAccelerationZstandardDev")
varGravityNames <- c("timeGravityAccelerationXmean","timeGravityAccelerationYmean","timeGravityAccelerationZmean","timeGravityAccelerationXstandardDev","timeGravityAccelerationYstandardDev","timeGravityAccelerationZstandardDev")
varBodyAccelJerkNames <- c("timeBodyAccelerationJerkXmean","timeBodyAccelerationJerkYmean","timeBodyAccelerationJerkZmean","timeBodyAccelerationJerkXstandardDev","timeBodyAcceleartionJerkYstandardDev","timeBodyAccelerationJerkZstandardDev")
varBodyGyroNames <- c("timeBodyGyroXmean","timeBodyGyroYmean","timeBodyGyroZmean","timeBodyGyroXstandardDev","timeBodyGyroYstandardDev","timeBodyGyroZstandardDev")
varBodyGyroJerkNames <- c("timeBodyGyroJerkXmean","timeBodyGyroJerkYmean","timeBodyGyroJerkZmean","timeBodyGyroJerkXstandardDev","timeBodyGyroJerkYstandardDev","timeBodyGyroJerkZstandardDev")
varBodyMagNames <- c("timeBodyAccelMagnitudeMean","timeBodyAccelMagnitudeStdDev","timeGravityAccelMagnitudeMean","timeGravityAccelMagnitudeStdDev","timeBodyAccelJerkMagnitudeMean","timeBodyAccelJerkMagnitudeStdDev","timeBodyGyroMagnitudeMean","timeBodyGyroMagnitudeStdDev","timeBodyGyroJerkMagnitudeMean","timeBodyGyroJerkMagnitudeStdDev")
varFreqBodyNames <- c("FreqBodyAccelerationXmean","FreqBodyAccelerationYmean","FreqBodyAccelerationZmean","FreqBodyAccelerationXstandardDev","FreqBodyAccelerationYstandardDev","FreqBodyAccelerationZstandardDev")
varFreqBodyJerkNames <- c("FreqBodyAccelerationJerkXmean","FreqBodyAccelerationJerkYmean","FreqBodyAccelerationJerkZmean","FreqBodyAccelerationJerkXstandardDev","FreqBodyAccelerationJerkYstandardDev","FreqBodyAccelerationJerkZstandardDev")
varFreqBodyGyroNames <- c("FreqBodyGyroXmean","FreqBodyGyroYmean","FreqBodyGyroZmean","FreqBodyGyroXstandardDev","FreqBodyGyroYstandardDev","FreqBodyGyroZstandardDev")
varFreqBodyMagNames <- c("FreqBodyAccelMagnitudeMean","FreqBodyAccelMagnitudeStdDev","FreqBodyAccelJerkMagnitudeMean","FreqBodyAccelJerkMagnitudeStdDev","FreqBodyGyroMagnitudeMean","FreqBodyGyroMagnitudeStdDev","FreqBodyGyroJerkMagnitudeMean","FreqBodyGyroJerkMagnitudeStdDev")
varNames <- c(varBodyNames,varGravityNames,varBodyAccelJerkNames,varBodyGyroNames,varBodyGyroJerkNames,varBodyMagNames,varFreqBodyNames,varFreqBodyJerkNames,varFreqBodyGyroNames,varFreqBodyMagNames)
varSubjActNames <- c("Subject","Activity",varNames)
colnames(allSelectData) <- varSubjActNames
allSelectData <- transform(allSelectData, Activity = factor(Activity))
levels(allSelectData$Activity) <- c("Walking","Walk Upstairs","Walk Downstairs","Sitting","Standing","Laying")
allSelectData <- transform(allSelectData, Subject = factor(Subject))

tidy <- aggregate(allSelectData[,3:68],list(allSelectData$Subject,allSelectData$Activity),mean)
colnames(tidy) <- varSubjActNames
head(tidy[,1:6])
dim(tidy)
setwd("..")
write.table(tidy,file = "tidyDataSet.txt", row.names = FALSE)