## LOAD NECESSARY PACKAGES  
	library(dplyr)
	library(stringr)


## STEP 1: DOWNLOAD ZIPPED FOLDER FROM WEBSITE, THEN EXTRACT UNZIPPED FOLDER
##	 TO R-WORKING DIRECTORY (After extraction, copy of zipped folder is removed)


	if (!file.exists("UCI HAR Dataset")) {
	fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	mydestfile <- "projectData.zip"
	download.file(url=fileUrl, destfile=mydestfile)
	print("Unzipping file, please wait ... ")
	unzip("projectData.zip") 
		# Unzip will extract "UCI HAR Dataset" to working dir
	unlink("projectData.zip")  #After "unzip"-ing, unlink can remove projectData.zip as this has become unnecessary
	DateDownloaded <- date()
	print("File successfully loaded on")
	print(DateDownloaded)
	}
	
	# Unzipping will put a folder named "UCI HAR Dataset" in the working directory
	# Relevant files for data manipulation are: 
	#	subect_test, y_test, X_test  ---> (SubjectID, ActivityID, features) [test data set]
	#	subject_train, y_train, X_train ---> (SubjectID, ActivityID, features) [train data set]
	#	activity labels ---> relates activity number to activity name
	#	features ---> contains a column of names of data variables


## STEP 2: READ THEN COLUMN-BIND subject_test and y_test DATAFRAMES ---> subject.y_test DF
##	     READ THEN COLUMN-BIND subject_train and y_train DATAFRAMES ---> subject.y_train DF

	# Read, then cbind subject_test and y-test dataframes, then add column names
		subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
			header = FALSE, sep = "")
			# subject_test has 2947 rows corresp to subject id
		colnames(subject_test) <- "SubjectID"

		y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
			header = FALSE, sep = "") 
			# y_test has 2947 rows and has 6 levels corresp to activity
		colnames(y_test) <- "ActivityID"
		y_test$ActivityID <- as.character(y_test$ActivityID)

		subject.y_test <- cbind(subject_test, y_test)


	# Read, then cbind subject_train and y-train dataframes, then add column names
		subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
			header = FALSE, sep = "")
			# subject_train has 7352 rows corresp to subject id
		colnames(subject_train) <- "SubjectID"

		y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
		 	header= FALSE, sep = "")
			# y_train has 7352 rows and has 6 levels corresp to activity
		colnames(y_train) <- "ActivityID"
		y_test$ActivityID <- as.character(y_test$ActivityID)

		subject.y_train <- cbind(subject_train, y_train)


## STEP 3: READ X_test , READ X-train DATAFRAMES
##		ATTACH COLUMN NAMES TO EACH OF X_test and X_train
##		FROM THE FEATURE NAMES PROVIDED IN THE "features.text" file

	# First read "features.txt" into R as a dataframe, and then 
	# extract vector of feature (i.e., column) names ("features.vec")
		features <- read.table("UCI HAR Dataset/features.txt", 
			header = FALSE, sep = "", stringsAsFactors=FALSE)
		features.vec <- features$V2   #vector of feature names  #FEATURES VECTOR 
	

	# Read X_test and attach feature (i.e., column) names from features.vec
		x_test <- read.table("UCI HAR Dataset/test/x_test.txt", 
			header = FALSE, sep = "", stringsAsFactors=FALSE)
		x_test <- tbl_df(x_test) # for screen printing convenience
			# x_test has 2947 rows and 561 columns corresp to features
		colnames(x_test) <- features.vec


	# Read X_train and attach feature (i.e., column) names from features.vec
		x_train <- read.table("UCI HAR Dataset/train/x_train.txt", 
			header = FALSE, sep = "", stringsAsFactors=FALSE)
		x_train <- tbl_df(x_train)  # for screen printing convenience
			# x_train has 7352 rows and 561 columns corresp to features
		colnames(x_train) <- features.vec


## STEP 4: COLUMN-BIND x_test DATAFRAME WITH subject.y_test DATAFRAME to form ---> test_dataset DF
## 	     COLUMN-BIND x_train DATAFRAME WITH subject.y_train DATAFRAME to form ---> train_dataset DF

	test_dataset <- cbind(subject.y_test, x_test)
	train_dataset <- cbind(subject.y_train, x_train)


## STEP 5: ROW-BIND THE test_data and train_data DATAFRAMES INTO A 
##	      MERGED DATASET

	Merged_Dataset <- rbind(test_dataset,train_dataset)
	Merged_Dataset <- tbl_df(Merged_Dataset) # command from dplyr package for screen printing convenience


## STEP 6:  ASSEMBLE "ACTIVITY_LABELS" DATA FRAME MATCHING 
## 		ACTIVITYID WITH ACTIVITY NAME
##		(This will be used as a "lookup table" to properly match 
## 		Activity (name) with ActivityID's in the Merged_Dataset 
##		 (via "merge" function, to be done in Step 7)


	activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
		header = FALSE, sep = "")
	colnames(activity_labels) <- c("ActivityID", "Activity")


## STEP 7:  ADD COLUMN OF ACTIVITY NAME ("ACTIVITY") TO MERGED_DATASET 
## 		BY MERGING IT WITH ACTIVITY_LABELS DATA FRAME (from STEP 6) 
## 		(The row order after merging will be preserved by using 
##		  a "merging index")


	# First add index column to Merged_Dataset (purpose is to preserve row order of data frames after "merge"-ing")
	Merged_Dataset$index <- 1:nrow(Merged_Dataset)
	
	# Then merge "activity_labels" dataframe to the "Merged_Dataset dataframe by ActivityID
	Merged_Dataset <- merge(activity_labels, Merged_Dataset, by="ActivityID")
	
	# Arrange columns of "Merged_Dataset" dataframe by Activity, SubjectID, and the rest of feature names (by dplyr package)
	Merged_Dataset <- Merged_Dataset %>%
		arrange(index) %>%
		select(Activity, SubjectID, -ActivityID, contains("t"), contains("f"), contains("a"))
	Merged_Dataset <- tbl_df(Merged_Dataset) #dplyr command for screen printing convenience



## STEP 8:  EXTRACT FROM MERGED DATASET, THE COLUMNS OF MEAN AND STD DEVIATION VARIABLES 
##		FOR EACH MEASUREMENT (Store in data frame, Extracted_Dataset) *dplyr package used
##		(README.md explains the basis of obtaining the feature columns)

	Extracted_Dataset <- Merged_Dataset %>%
		select(SubjectID, Activity, contains(".[Mm]ean."), 
				contains(".std."), -contains("angle"), -contains("Freq")) 
	
	# The "Activity" column of the Extracted_Dataset was formalized as a factor with 6 levels of "activities"
	activities <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
			"SITTING","STANDING","LAYING")
	Extracted_Dataset$Activity <- factor(Extracted_Dataset$Activity, 
			levels=activities, labels=activities)


## STEP 9:  CREATE SECOND, INDEPENDENT (initially named, "PreFinal_TidyData") TIDY DATA SET WITH THE AVERAGE OF 
## 		EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT *dplyr package used
##		(The "PreFinal_TidyData" DF, must still undergo 
##			text processing of column names in Step 10, as explained in README.md )

	PreFinal_TidyData <- Extracted_Dataset %>%
		group_by(Activity, SubjectID) %>%
		summarise_each(funs(mean)) %>%
		arrange(Activity)


## STEP 10: REPLACE COLUMN NAMES OF FINAL_TIDYDATA WITH MORE DESCRIPTIVE
## 		LABELS COMPLYING REQUIREMENTS FOR TIDY DATA (HUMAN READABLE, NO DOTS/SYMBOLS,...)
##		(stringr package and regular expressions used).Please see README
##		THEN FINALIZE TO MAKE THE "Final_TidyData" DATAFRAME

	# stringr package used to manipulate column titles (package has already been called above)
		
	b <- colnames(PreFinal_TidyData)
	pattern <- "\\(\\)"; b <- str_replace_all(b, pattern, " ")
	pattern <- "( -)|-"; b <- str_replace_all(b, pattern, "")
	pattern <- "tBody"; b <- str_replace(b, pattern, "TimeDependentBody")
	pattern <- "tGravity"; b <- str_replace(b, pattern, "TimeDependentGravity")
	pattern <- "fBody|fBodyBody"; b <- str_replace(b, pattern, "FourierTransformBody")
	pattern <- "Acc"; b <- str_replace(b, pattern, "AccelerometerSignal")
	pattern <- "Gyro"; b <- str_replace(b, pattern, "GyrometerSignal")
	pattern <- "SignalJerk"; b <- str_replace(b, pattern, "JerkSignal")
	pattern <- "Magmean"; b <- str_replace(b, pattern, "meanMagnitude")
	pattern <- "Magstd"; b <- str_replace(b, pattern, "Magnitudestd")
	pattern <- "mean"; b <- str_replace(b, pattern, "Mean")
	pattern <- "std"; b <- str_replace(b, pattern, "StandardDeviation")
	pattern <- "X"; b <- str_replace(b, pattern, "AtXaxis")
	pattern <- "Y"; b <- str_replace(b, pattern, "AtYaxis")
	pattern <- "Z"; b <- str_replace(b, pattern, "AtZaxis")

	colnames(PreFinal_TidyData) <- b

	Final_TidyData <- PreFinal_TidyData


## STEP 11:  SAVE FINAL TIDY DATA SET AS TXT FILE IN WORKING DIRECTORY

	write.table(Final_TidyData, "Final_TidyData.txt", row.names=FALSE)

##	NOTE: In order to read back the text file into R, please use: 
##		Tidy_Data <- read.table("Final_TidyData.txt", header=TRUE) 








