# Getting and Cleaning Data Programming Assignment

## 1. Merge training and test sets to create one data set

# read in each data set
test.labels <- read.table("test/y_test.txt", col.names="Label")
test.subjects <- read.table("test/subject_test.txt", col.names="Subject")
test.data <- read.table("test/X_test.txt")
train.labels <- read.table("train/y_train.txt", col.names="Label")
train.subjects <- read.table("train/subject_train.txt", col.names="Subject")
train.data <- read.table("train/X_train.txt")
# bind data sets (subjects, labels, data)
data <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))


## 2. Extracts only measurements on the mean and stand dev for each measurement

# read features.txt (contains col names of the train.data and test.data sets)
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
# use grep to pull out just the mean and sd from feature list
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features[,2]), ]
# use the features list to pull out means and sd from data 
# +2 to account for subjects and labels in the beginning of data
data.mean.std <- data[, c(1, 2, features.mean.std[,1]+2)]


## 3. Uses descriptive activity names to name the activities in the data set

# read in activity labels 
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# replace labels in data with label names
data.mean.std$Label <- labels[data.mean.std$Label, 2]


## 4. Appropriately labels the data set with descriptive variable names

# make list of current column names and feature names
column.names <- c("subject", "label", features.mean.std[,2])
# clean up names (remove non-alphabetic character, convert to lowercase)
column.names <- tolower(gsub("\\(\\)", "", column.names))
column.names <- gsub("bodybody", "body", column.names)
# then use the list as column names for data
colnames(data.mean.std) <- column.names


## 5. From data in step 4, create a tidy data set with avg of each var for each activity and each subject

# aggregate to find the mean for each combination of subject and label
aggregate.means <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
                             by=list(subject = data.mean.std$subject, label = data.mean.std$label),
                             mean)

## write the data to upload
write.table(format(aggregate.means, scientific=T), "tidy.txt", row.names=F, col.names=F, quote=2)
