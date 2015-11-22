# GetCleanDataCourseProject

My course project submission has only a single script:

* run_analysis.R

The first thing the script does is to download the Fitness Tracking zipped archive from the Internet.  Next it unzips the archive and sets the working directory to the "UCI HAR Dataset" folder.

The UCI HAR Dataset folder has 4 files and two sub-directories, "test" and "train" with data files.  The X_train.txt and X_test.txt files in the train and test subdirectories respectively contain the subsets of the data respectively used to train and test the system. These are read in by my script.

The subject_train.txt and subject_test.txt files in the train and test subdirectories indicate, for each line in the X-train and X-test data, which of the 30 subjects in the sample the data was obtained from.  These are read into subjTrain and subjTest variables.

Finally, the y_train.txt and y_test.txt files in the train and test subdirectories indicate, for each line in the X-train and X-test data, which of 6 different activities were being performed at the time.  The mapping of these numerical values to activities is found in the "activity_labels.txt" file in the UCI HAR Dataset folder.

After loading the R library package "dplyr" to manipulate the data frame with the activity data, the run_analysis.R script selects columns of interest in the activity data based on the features_info.txt and features.txt files in the UCI HAR Dataset folder.

To quote from features_info.txt:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy

and several more.  For the purpose of our analysis, we only extract the mean() and std() (Standard Deviation) for each of the time and frequency domain signals in the codebook.  The columns for all the features in the X-train and X-test data are indicated in the "features.txt" file in the UCI HAR Dataset folder.

The variables "meanStdTrain" and "meanStdTest" in the run_analysis.R script consist of the subset of columns in the original measured data that consist of the mean and standard deviation calculations.  

Next, the Subject and Activity columns associated with the Training and Testing data are added to form a data frame along with the measured data.  Once the Training and Testing data frames are formed the rows of these two sets are appended to each other to form a single data frame.  

The next few lines of the run_analysis script assigns names to the columns of the data frames based on those given in the "features.txt" file.  The "Subject" and "Activity" column names are added as the first two elements of this list of column names, and then the R colnames() command is executed to assign these names to all the columns of the data frame.

Finally the Subject and Activity columns of the data frame are converted into factors, with the numerical values of Activity being converted to named activities based on the "activity_labels.txt" file in the UCI HAR Dataset folder.  The R command "aggregate" is applied to the data frame to calculate the mean (average) of all the columns of data grouped by the Subject and Activity factor variables.  The resulting data frame has 180 rows: The product of the (6 activities) engaged in by the (30 subjects) with the mean of the other 66 variables in the columns of the tidy data set.
