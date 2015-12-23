# Create one R script called run_analysis.R that does the following
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load Packages and unzip downloaded file
library(plyr)

library(reshape2)

library(data.table)

projectfiles <- unzip("getdata-projectfiles-UCI HAR Dataset.zip")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# I only want the second column because V1 is a list of numbers and not needed for this analysis. Extracting [,2] gives me just the activity labels. Activity labels include: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, & LAYING   

features <- read.table("./UCI HAR Dataset/features.txt")[,2]
# Same thing with features. I only want column 2 descrpitions. Later on, we will extract only the mean and std features for our tidy data set. 

# Below is what we will use to extract only the std and mean. The grepl function search for matches to argument pattern within each element of a character vector
extract_features <- grepl("mean|std", features)

# Next we will need to load the data we will be using to create our new data frame
# load test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#load train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Now we need to start combining, labeling, and cleaning our dataframes. Note when you are checking out and summarizing each of the data frames you will notice the "x" dfs have a large amount of data with about 561 variables.  

#First, lets work on our test data
names(X_test) = features
# all 561 variables in x_test will be labeled as the 561 features

# Now, out of these 561 features, we only want the std and mean
x_test = x_test[,extract_features]

# Next, we need to include activity lables as a variable which is numbered in the y-test df
y_test[,2] = activity_labels[y_test[,1]]

# We need to name the variables we just created
names(y_test) = c("Activity_ID", "Activity_Label")

# can't forget about the actual subjects being analyzed 
names(subject_test) = "subject"

# since we have cleaned each individual data table we need to combine all of the test data into one df
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Next, we need to work on our train data which will be a somewhat similar process as the test data organizing
names(X_train) = features

X_train = X_train[,extract_features]

y_train[,2] = activity_labels[y_train[,1]]

names(y_train) = c("Activity_ID", "Activity_Label")

names(subject_train) = "subject"

train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# Now that both the train and test data are compatiable we need to merge the two together. 
data = rbind(test_data, train_data)

# Let's establish our id_labels and data_labels prior to melting for organization purposes
id_labels   = c("subject", "Activity_ID", "Activity_Label")

data_labels = setdiff(colnames(data), id_labels)
#setdiff(A,B) returns the data in A that is not in B.)

# Meltdata
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

#apply mean function to data set using the dcast function used in the lectures

tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

#take this information and create a new tidy data file

write.table(tidy_data, file = "./tidy_data.txt")

#I also wanted to save my "data" table as well just in case

write.table(data, file = "./assignment3data.txt")
