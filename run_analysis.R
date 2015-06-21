library(dplyr)

loadActivityNames <- function() {
        
        # load, then merge training and test labels
        X <- read.csv(file = "UCI\ HAR\ Dataset/train/y_train.txt", sep = "", header = FALSE)
        Y <- read.csv(file = "UCI\ HAR\ Dataset/test/y_test.txt", sep = "", header = FALSE)
        Z <- rbind(X, Y)
        
        # rename the label header
        Z <- rename(Z, activity_label = V1)
        
        # load activity names
        A <- read.csv(file = "UCI\ HAR\ Dataset/activity_labels.txt", sep = "", header = FALSE)
        
        # add 'Activity' column to labels dataset; value is derived from activity names dataset
        mutate(Z, Activity = ifelse(Z[,1] == A[1,1], as.character(A[1,2]),
                             ifelse(Z[,1] == A[2,1], as.character(A[2,2]),
                             ifelse(Z[,1] == A[3,1], as.character(A[3,2]),
                             ifelse(Z[,1] == A[4,1], as.character(A[4,2]),
                             ifelse(Z[,1] == A[5,1], as.character(A[5,2]),
                             ifelse(Z[,1] == A[6,1], as.character(A[6,2]), NA)))))))
}

loadSubjects <- function() {
        
        # load, then merge training and test subjects
        X <- read.csv(file = "UCI\ HAR\ Dataset/train/subject_train.txt", sep = "", header = FALSE)
        Y <- read.csv(file = "UCI\ HAR\ Dataset/test/subject_test.txt", sep = "", header = FALSE)
        Z <- rbind(X, Y)
        
        # rename the header to 'Subject'
        Z <- rename(Z, Subject = V1)
        Z
}

loadMergedDataSet <- function() {

        # loads headers for both training and test datasets
        H <- read.csv(file = "UCI\ HAR\ Dataset/features.txt", sep = "", header = FALSE)  
        H <- H[,2]
        
        # header contains duplicate columnn names; make them unique with make.names
        H.unique <- make.names(H, unique = TRUE)
        
        # collapse contiguous dots to make cleaner names
        H.unique <- gsub("\\.{2, }", ".", H.unique)
        
        # load training and test data sets
        X <- read.csv(file = "UCI\ HAR\ Dataset/train/X_train.txt", sep = "", header = FALSE)
        Y <- read.csv(file = "UCI\ HAR\ Dataset/test/X_test.txt", sep = "", header = FALSE)
        
        # merge datasets; these datasets are identical so they can be stacked via rbind
        Z <- rbind(X, Y)
        
        # set headers to column names
        colnames(Z) <- H.unique
        
        # merge activity names, subjects and measurements into one dataset
        cbind(loadActivityNames(), 
              loadSubjects(), 
              Z)
}

# main function
createTidyDataSet <- function() {
        
        # load data
        X <- loadMergedDataSet()
        
        # filter on subject, activity and measurements for mean and std deviation
        Y <- select(X, 
                matches("Subject", ignore.case = FALSE),
                matches("Activity", ignore.case = FALSE),
                contains(".mean."), 
                contains(".std."))
        
        # apply mean to all measurements grouped by subject and activity
        Y.groupBy = Y[,c("Subject","Activity")]
        Y.measurements <- Y[,3:length(Y)]
        Z <- aggregate(Y.measurements, Y.groupBy, FUN = mean)
        
        # export to txt file
        write.table(Z, "./tidy_data_set.txt", sep="\t", row.names = FALSE)
}