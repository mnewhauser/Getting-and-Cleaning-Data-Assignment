##Codebook

#Variables and Files
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

#Analysis Process
1. Merge 'training' and 'test' data sets by reading them into R and binding them using rbind() and cbind()
2. Extract only measurements on the mean and standard deviation for each measurement by reading the column names for both data sets by using grep() to pull out just the mean and sd from feature list and the features list to pull out means and sd from data.
3. Replace the existing column labels with descriptive activity names
4. Appropriately labels the data set with descriptive variable names by making a list of current column names and feature names and cleaning them up by using tolower() and gsub().
5. From data in step 4, create a tidy data set with avg of each var for each activity and each subject
  - Use aggregate() to find the mean for each combination of subject and label
  - Write the data to upload
  
#Objects and Data Frame Names
- data <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))
- data.mean.std <- data[, c(1, 2, features.mean.std[,1]+2)]
- data.mean.std$Label <- labels[data.mean.std$Label, 2]
- colnames(data.mean.std) <- column.names
- aggregate.means <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
                             by=list(subject = data.mean.std$subject, label = data.mean.std$label),
                             mean)
- write.table(format(aggregate.means, scientific=T), "tidy.txt", row.names=F, col.names=F, quote=2)

