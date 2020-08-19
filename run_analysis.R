## STEP 1 extraction of files
path_rf <- "C:/Users/TEST PC/Downloads/getdata_projectfiles_UCI HAR TidyDataset/UCI HAR TidyDataset"

dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)


dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)


dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

## STEP 2 merging test and train data

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

# name cols

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# bind all data together to form a single data set
d<-cbind(dataSubject, dataActivity)
TidyData <- cbind(d,dataFeatures)
str(TidyData)

## STEP 3 Extract only the measurements on the mean and standard deviation for each measurement

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
#subset data
selectedNames<-c("subject", "activity", as.character(subdataFeaturesNames) )
TidyData<-subset(TidyData,select=selectedNames)
str(TidyData)

## STEP 4 Uses descriptive activity names to name the activities in the data set

#extract labels file
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
lbls <- activityLabels$V2
TidyData$activity <- factor(TidyData$activity,labels = as.vector(lbls))

## STEP 5 Appropriately labels the data set with descriptive variable names
names(TidyData)<-gsub("^t", "time", names(TidyData))
names(TidyData)<-gsub("^f", "frequency", names(TidyData))
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))

## STEP 6 creates a second, independent tidy data set with the average of each variable for each activity and each subject

aggregateData<-aggregate(.~subject+ activity , TidyData, mean)
aggregateData<-aggregateData[order(aggregateData$subject,aggregateData$activity),]

##print out the data frames
print("Here is the Tidy Data")
print(TidyData)
print("Here is the aggregate data")
print(aggregateData)
