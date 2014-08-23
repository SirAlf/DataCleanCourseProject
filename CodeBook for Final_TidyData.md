DataCleanCourseProject
===========================

### MY CODEBOOK FOR FINAL_TIDY DATA
 
===================================================================  
#### DESCRIPTION OF COLUMN VARIABLES IN ORIGINAL CODEBOOK
The variables in the raw dataset were distributed across different files as follows:

(1) ActivityID for the test and train datasets (file names are **"y\_test"** and **"y\_train"**).
The ActivityID's can be translated to Activity names by the accompanying **"activity\_labels"** file. There are 6 ActivityID's corresponding to:     
 1=WALKING, 2=WALKING_UPSTAIRS, 
3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING.

(2) SubjectID for the test and train datasets (**"subject\_test"** and **"subject\_train" files**).
There are 30 subjects (corresponding to 30 SubjectID's) who participated in the experiment

(3) **"features"** field containing 561 variable names.  These features have been described in the **"features_info"** file in the original data files.  

According to the "features_info" file, the "features" variables come from the accelerometer and gyroscope 3-axial raw signals (in the X, Y, Z directions): tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time). The acceleration signal was separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ).

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).  The magnitude of these three-dimensional signals were also calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

A Fast Fourier Transform (FFT) was applied to some of the signals producing: fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (The letter 'f' was attached to the these field names to indicate frequency domain signals). 

The variable names for the time and frequency domains of the signals are shown below:
(Henceforth, these will be called, **"measurement signals"**).
* tBodyAcc-XYZ 
* tGravityAcc-XYZ 
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ  
* tBodyGyroJerk-XYZ
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

**UNITS OF MEASURED VARIABLES** : The original codebook says that Accelerometer signals are in units of acceleration and gyroscope signal are in units of velocity.
The codebook does not mention the system of units (i.e., whether SI or American Engineering units) used for acceleration and velocity

The 3-axial (X,Y,Z) signals above were used to estimate variables of the feature vector for each pattern.  The variable names are:
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Only the mean and standard deviations of the "measurement signals" are relevant for the making of the tidy data

The following vectors were also obtained and used on the angle() variable:  

- gravityMean  
- tBodyAccMean  
- tBodyAccJerkMean  
- tBodyGyroMean  
- tBodyGyroJerkMean  

***Since angle() is a calculated quantity(rather than a measurement signal), it was NOT INCLUDED as a measurement signal.***

========================================================================   
### COLUMN VARIABLES (FIELDS) IN THE **TIDY DATA SET** 

(1) **SubjectID**:  This corresponds to the 30 participants of the experiment.

(2) **Activity**:  Activity names corresponding to the ActivityID's of the test and train datasets ("y_test" and "y_train").  This was obtained by merging the "activity_lables" with the ActivityID's datasets of the train and test data.

(3) **mean of "measurment signals"** as defined above :  
NOTE: Each "measuremnt signal" in a row corresponds to 3 column files, corresponding to X, Y, and Z directions.
Total columns for mean of measurement signals should be equal to [(8*3)+9=] 33 columns.  


* tBodyAcc-mean()-XYZ
* tGravityAcc-mean()-XYZ
* tBodyAccJerk-mean()-XYZ
* tBodyGyro-mean()-XYZ
* tBodyGyroJerk-mean()-XYZ
* fBodyAcc-mean()-XYZ
* fBodyAccJerk-mean()-XYZ
* fBodyGyro-mean()-XYZ
* tBodyAccMag-mean()
* tGravityAccMag-mean()
* tBodyAccJerkMag-mean()
* tBodyGyroMag-mean()
* tBodyGyroJerkMag-mean()
* fBodyAccMag-mean()
* fBodyAccJerkMag-mean()
* fBodyGyroMag-mean()
* fBodyGyroJerkMag-mean()

(4) **standard deviation (std) of "measurment signals"** as defined above :
NOTE: Each "measuremnt signal" in a row corresponds to 3 column files, corresponding to X, Y, and Z directions.
Total columns for standard deviations of measurement signals should be equal to [(8*3)+9=] 33 columns.

* tBodyAcc-std()-XYZ
* tGravityAcc-std()-XYZ
* tBodyAccJerk-std()-XYZ
* tBodyGyro-mean()-XYZ
* tBodyGyroJerk-std()-XYZ
* fBodyAcc-std()-XYZ
* fBodyAccJerk-std()-XYZ
* fBodyGyro-std()-XYZ
* tBodyAccMag-std()
* tGravityAccMag-std()
* tBodyAccJerkMag-std()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-std()
* fBodyAccMag-std().
* fBodyAccJerkMag-std()
* fBodyGyroMag-std()
* fBodyGyroJerkMag-std()

The tidy data set has a total of 2 (SubjectID, Activity) plus 66 or a **total of 68 columns or fields**.

The rows of the tidy data correspond to the mean of the measurement signals according to Activity and SubjectID.

In compliance with the requirements for tidy data, the variable (ii.e., column) names of the final data set were then **converted to "human readable form"** (with no punctuations of any kind) via the *stringr* package.  
***CamelCase*** was also applied to column names in order to improve readability.   
The final column names corresponding to the raw data column names are listed below:

* SubjectID
* Activity
* TimeDependentBodyAccelerometerSignalMeanAtXaxis
* TimeDependentBodyAccelerometerSignalMeanAtYaxis
* TimeDependentBodyAccelerometerSignalMeanAtZaxis
* TimeDependentGravityAccelerometerSignalMeanAtXaxis
* TimeDependentGravityAccelerometerSignalMeanAtYaxis
* TimeDependentGravityAccelerometerSignalMeanAtZaxis
* TimeDependentBodyAccelerometerJerkSignalMeanAtXaxis
* TimeDependentBodyAccelerometerJerkSignalMeanAtYaxis
* TimeDependentBodyAccelerometerJerkSignalMeanAtZaxis
* TimeDependentBodyGyrometerSignalMeanAtXaxis
* TimeDependentBodyGyrometerSignalMeanAtYaxis
* TimeDependentBodyGyrometerSignalMeanAtZaxis
* TimeDependentBodyGyrometerJerkSignalMeanAtXaxis
* TimeDependentBodyGyrometerJerkSignalMeanAtYaxis
* TimeDependentBodyGyrometerJerkSignalMeanAtZaxis
* TimeDependentBodyAccelerometerSignalMeanMagnitude 
* TimeDependentGravityAccelerometerSignalMeanMagnitude 
* TimeDependentBodyAccelerometerJerkSignalMeanMagnitude 
* TimeDependentBodyGyrometerSignalMeanMagnitude 
* TimeDependentBodyGyrometerJerkSignalMeanMagnitude 
* FourierTransformBodyAccelerometerSignalMeanAtXaxis
* FourierTransformBodyAccelerometerSignalMeanAtYaxis
* FourierTransformBodyAccelerometerSignalMeanAtZaxis
* FourierTransformBodyAccelerometerJerkSignalMeanAtXaxis
* FourierTransformBodyAccelerometerJerkSignalMeanAtYaxis
* FourierTransformBodyAccelerometerJerkSignalMeanAtZaxis
* FourierTransformBodyGyrometerSignalMeanAtXaxis
* FourierTransformBodyGyrometerSignalMeanAtYaxis
* FourierTransformBodyGyrometerSignalMeanAtZaxis
* FourierTransformBodyAccelerometerSignalMeanMagnitude 
* FourierTransformBodyAccelerometerJerkSignalMeanMagnitude 
* FourierTransformBodyGyrometerSignalMeanMagnitude 
* FourierTransformBodyGyrometerJerkSignalMeanMagnitude 
* TimeDependentBodyAccelerometerSignalStandardDeviationAtXaxis
* TimeDependentBodyAccelerometerSignalStandardDeviationAtYaxis
* TimeDependentBodyAccelerometerSignalStandardDeviationAtZaxis
* TimeDependentGravityAccelerometerSignalStandardDeviationAtXaxis
* TimeDependentGravityAccelerometerSignalStandardDeviationAtYaxis
* TimeDependentGravityAccelerometerSignalStandardDeviationAtZaxis
* TimeDependentBodyAccelerometerJerkSignalStandardDeviationAtXaxis
* TimeDependentBodyAccelerometerJerkSignalStandardDeviationAtYaxis
* TimeDependentBodyAccelerometerJerkSignalStandardDeviationAtZaxis
* TimeDependentBodyGyrometerSignalStandardDeviationAtXaxis
* TimeDependentBodyGyrometerSignalStandardDeviationAtYaxis
* TimeDependentBodyGyrometerSignalStandardDeviationAtZaxis
* TimeDependentBodyGyrometerJerkSignalStandardDeviationAtXaxis
* TimeDependentBodyGyrometerJerkSignalStandardDeviationAtYaxis
* TimeDependentBodyGyrometerJerkSignalStandardDeviationAtZaxis
* TimeDependentBodyAccelerometerSignalMagnitudeStandardDeviation 
* TimeDependentGravityAccelerometerSignalMagnitudeStandardDeviation 
* TimeDependentBodyAccelerometerJerkSignalMagnitudeStandardDeviation 
* TimeDependentBodyGyrometerSignalMagnitudeStandardDeviation 
* TimeDependentBodyGyrometerJerkSignalMagnitudeStandardDeviation 
* FourierTransformBodyAccelerometerSignalStandardDeviationAtXaxis
* FourierTransformBodyAccelerometerSignalStandardDeviationAtYaxis
* FourierTransformBodyAccelerometerSignalStandardDeviationAtZaxis
* FourierTransformBodyAccelerometerJerkSignalStandardDeviationAtXaxis
* FourierTransformBodyAccelerometerJerkSignalStandardDeviationAtYaxis
* FourierTransformBodyAccelerometerJerkSignalStandardDeviationAtZaxis
* FourierTransformBodyGyrometerSignalStandardDeviationAtXaxis
* FourierTransformBodyGyrometerSignalStandardDeviationAtYaxis
* FourierTransformBodyGyrometerSignalStandardDeviationAtZaxis
* FourierTransformBodyAccelerometerSignalMagnitudeStandardDeviation 
* FourierTransformBodyAccelerometerJerkSignalMagnitudeStandardDeviation 
* FourierTransformBodyGyrometerSignalMagnitudeStandardDeviation 
* FourierTransformBodyGyrometerJerkSignalMagnitudeStandardDeviation 

======================================================================
#### TRANSFORMATIONS ON THE RAW DATA TO PRODUCE THE REQUIRED TIDY DATA (Using dplyr and stringr packages)  

(1) After loading needed packages, and after reading and extracting the files into the working directory, the subject\_test and y\_test dataframes were read (attaching column names of "SubjectID" and "ActivityID" to each data frame), and then column-bind(ed) into a subject.y\_test dataframe.  Similarly, the subject\_train and y\_train dataframes were read (attaching column names of "SubjectID" and "ActivityID" to each data frame), and column-bind(ed) into a subject.y\_train dataframe

(2) The X\_test and X\_train dataframes were read and column names (obtained from a vector of feature names from the "features" file) were attached.

(3) The subject.y\_test dataframe was column-bind(ed) to the X\_test data frame to form the "test_dataset" dataframe.  Similarly, the subject.y_train dataframe was column-bind(ed) to the X_train data frame to form the "train_dataset" dataframe.

(4) The "test\_dataset" and "train\_datasets" were row-bind(ed) to form the ***Merged_Dataset***.   
 (A column for "Activity", i.e., activity name still needed to be added, and this was done in the next step).

(5) The "activity\_labels" file was read and attached with the column names for "Activity" (activity name) and "ActivityID. Using the merge command on the "activity_labels" and "Merged_Dataset" dataframes, a new column for "Activity" was added to the Merged_Dataset.    The dplyr package was used to properly arrange the relevant columns in the Merged_dataset. 

(6) The column names containing the mean and standard deviations of the measured signals from the Merged_Dataset  were extracted to give the "***Extracted\_Dataset***" dataframe.     
(Please refer to README markdown file for basis of selecting the mean and standard deviation columns) The *dplyr* package was convieniently used for this.

(7) From the Extracted\_Dataset, the dplyr package was used to obtain the "second, independent" dataframe containing the average of the values of the column variables.  This dataframe was named "***PreFinal_Dataset***", which still needs to undergo text processing of column names, as explained in step 8.

(8) The column names in the "PreFinal\_Dataset" were converted to conform to requirements of column names for tidy data ("human readable", "no punctuations or symbols").    
The *stringr* package was used for this purpose.  Since the column names were unusually long, CamelCase had to be used.  The final tidy data was named, "***Final_TidyData***".

(9)  The Final_TidyData dataframe was *saved as a text file* in the working directory.  The saved text file can be read back into
R by the following command: Tidy_Data <- TidyData <- read.table("Final_TidyData.txt", header=TRUE)


