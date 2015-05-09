## Getting and Cleaning Data Course Project

## 1.Merges the training and the test sets to create one data set
filenamesTest <- list.files("test", pattern="*.txt", full.names=TRUE)
filenamesTrain <- list.files("train", pattern="*.txt", full.names=TRUE)
listTest <- lapply(filenamesTest, read.table)
listTrain <- lapply(filenamesTrain, read.table)
test1 <- listTest[[1]]
test2 <- listTest[[2]]
test3 <- listTest[[3]]
train1 <- listTrain[[1]]
train2 <- listTrain[[2]]
train3 <- listTrain[[3]]
tableTest <- cbind(test1, test3, test2)
tableTrain <- cbind(train1, train3, train2)
tableMerged <- rbind(tableTest, tableTrain)

## 4. Appropriately labels the data set with descriptive variable names 
colnames(tableMerged)[1:2] <- c("Subject", "Activity")
featuresLabels <- read.table("features.txt")
vecFeatures <- as.character(featuresLabels[,2])
colnames(tableMerged)[3:563] <- vecFeatures
tableSorted <- tableMerged[ order(tableMerged$Subject, tableMerged$Activity), ]

## 2. Extracts only the measurements on the mean and standard
## deviation for each measurement
tableExtracted <- subset(tableSorted, select=grep("mean|std|Activity|Subject", colnames(tableSorted)))

## 3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("activity_labels.txt")
vecLabels <- as.character(activityLabels[,2])
for(i in 1:nrow(tableExtracted)){ ## nrow(tableExtracted)
    number <- as.numeric(tableExtracted[i, "Activity"])
    tableExtracted[i, "Activity"] <- vecLabels[number]
}
## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject
rownames(tableExtracted) <- NULL ## removing unnecassary row
tidyData <- aggregate(.~ Subject + Activity, tableExtracted, mean)
write.table(tidyData, file="tidyData.txt", row.name=FALSE)
