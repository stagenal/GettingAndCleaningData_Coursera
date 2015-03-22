# Set working directory and check for data directory
setwd("C:/Users/Drew/Desktop/COURSERA/R_Programming")
if (!file.exists("./data")) {
    dir.create("./data")
    }
# Given URL for data
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Download
download.file(URL,destfile="./data/UCI_HAR_data.zip")
# Unzip
unzip (zipfile="./data/UCI_HAR_data.zip",exdir="./data")
# Shorten Path
PATH  <- file.path("./data" , "UCI HAR Dataset")
#####  Part 1 - Merges the training and the test sets to create one data set.
## Ignore Inertial Signals folder
## FILES <- list.files(PATH, recursive=TRUE)
##  Used the following Data
#  test/subject_test.txt
#  test/X_test.txt
#  test/y_test.txt
#  train/subject_train.txt
#  train/X_train.txt
#  train/y_train.txt
## Read the Data
X_dataFeatTest  <- read.table(file.path(PATH, "test" , "X_test.txt" ),       header = FALSE)
X_dataFeatTrain <- read.table(file.path(PATH, "train", "X_train.txt"),       header = FALSE)
Y_dataActTest   <- read.table(file.path(PATH, "test" , "Y_test.txt" ),       header = FALSE)
Y_dataActTrain  <- read.table(file.path(PATH, "train", "Y_train.txt"),       header = FALSE)
S_dataSubTest   <- read.table(file.path(PATH, "test" , "subject_test.txt"),  header = FALSE)
S_dataSubTrain  <- read.table(file.path(PATH, "train", "subject_train.txt"), header = FALSE)
X_dataNames     <- read.table(file.path(PATH, "features.txt"),               header = FALSE)
## Merge the data subsets
Sub_data  <- rbind(S_dataSubTest, S_dataSubTrain)
Act_data  <- rbind(Y_dataActTest, Y_dataActTrain)
Feat_data <- rbind(X_dataFeatTest, X_dataFeatTrain)
## Add header rows
names(Sub_data)  <- c("subject")
names(Act_data)  <- c("activity")
names(Feat_data) <- X_dataNames$V2
## Merge Full_data
Full_data        <- cbind(Sub_data, Act_data, Feat_data)
#####  Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
## Extraction
# Add DPLYR library
library("dplyr", lib.loc="~/R/win-library/3.1")
# use Filter from dplyr
