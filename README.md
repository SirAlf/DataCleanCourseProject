DataCleanCourseProject
===========================
### **README FILE**: EXPLANATION OF R-SCRIPT FOR TRANSFORMING RAW DATA TO REQUIRED TIDY DATA

###### PRELIMINARY STEP: LOAD NEEDED PACKAGES (dplyr and stringr)

===============================================================================

##### STEP 1: DOWNLOAD ZIPPED FOLDER FROM WEBSITE, THEN EXTRACT UNZIPPED FOLDER TO R-WORKING DIRECTORY
>The script initially downloaded the zip folder from the website ("UCI HAR Dataset.zip"), and saved it as "projectData.zip".  Then "projectData.zip" will be "unzipped" to extract the sub-folders and files of the test and train datasets).  ***The extracted folder that would be located in the working directory is called "UCI HAR Dataset"***.  The contents of this folder is described below.  
Finally, as cleanup, the copy of "projectData.zip" was deleted from the working directory by the unlink() command.   
##### CONTENTS OF DOWNLOADED/EXTRACTED FOLDER ("UCI HAR Dataset")
>The "UCI HAR Dataset" folder contains a number of files and folders, but only the following files were used for processing into tidy data:  
1. **"activity labels"**: file containing a data frame of ActivityID's with the corresponding Activity name.  
2. **"features"**:  a file containing the (561) descriptive names of data fields that can be used as column names for the test and train datasets (x\_test and x\_train).  
3. "test" and "train" sub-FOLDERs containing the following files  
  * **"subject\_test"** 	(data frame of SubjectID's) 2947 rows x 1 column  
  * **"y\_test"**		(data frame of ActivityID's) 	2947 rows x 1 column  
  * **"x\_test"**		(data frame of 561 measuremnt variables) 2947 rows x 561 columns  
  * **"subject\_train"** 	(data frame of SubjectID's) 7352 rows x 1 column  
  * **"y\_train"**		(data frame of ActivityID's) 	7352 rows x 1 column  
  * **"x\_train"**		(data frame of 561 measuremnt variables) 	7352 rows x 561 columns  

##### STEP 2: READ, THEN COLUMN-BIND EACH OF subject\_test/subject\_train and y\_test/y\_train DATAFRAMES to create subject.y\_test and subject.y\_train DATAFRAMES
>*(Step 2 assumes that the "***UCI HAR Dataset***" folder containing the sub-folders and needed files, ***resides in the working directory***)

>The *subject\_test* and *y\_test*  dataframes were read and column names (SubjectID and ActivityID, respectively) were attached.  
The dataframes were then "cbind"-ed and the new, combined data frame was called ***subject.y\_test***.  

>Similarly, the *subject\_train* and *y\_train dataframes* were also read and column names (SubjectID and ActivityID, respectively) were attached.   
The dataframes were then "cbind"-ed and the new, combined data frame was called ***subject.y_train*** .  

>The *subject.y\_test* DF will eventually be "cbind"-ed to the *X\_test* DF, while the *subject.y_train* DF will eventually be "cbind"-ed to the *X\_train* DF.  In order to do this, the *X\_test*  and  *X\_train* data set files must first be read into R as a dataframe, and then given column names as explained in Steps 3 and 4. 


##### STEP 3:  READ X\_test , READ X\_train DATAFRAMES, THEN ATTACH COLUMN NAMES TO EACH OF X\_test and X\_train DATAFRAMES FROM THE FEATURE NAMES PROVIDED IN THE "features.txt" file.  
>Before reading the *X\_test* and *X\_train* data frames, the "features.txt" file was first read into a data frame and the vector of the feature names (i.e. column names of measured variables) was extracted (i.e., subsetted out) as a vector,  ***features.vec***.  

>The *X\_test* and *X\_train* dataset files  were then read as dataframes in R, and column names were attached to each, using the previously obtained ***features.vec***.  

##### STEP 4:  COLUMN-BIND x\_test data frame with subject.y\_test data frame.  REPEAT BY COLUMN BIND-ing x\_train dataframe with subject.y\_train data frame
>The new dataframe from the "cbind"ing of *x\_test* and *subject.y\_test* data frames was called "***test\_dataset***"  
The new dataframe from the "cbind"ing of *x\_train* and *subject.y\_train* data frames was called "***train_dataset***".  


##### STEP 5:  ROW-BIND THE test\_data and train\_data DATAFRAMES INTO A MERGED_DATASET
>The resulting data frame from the row-binding (rbind) of the *test\_dataset* and the *train\_dataset* was called "**Merged_Dataset**"

##### STEP 6:  ASSEMBLE "ACTIVITY_LABELS" DATA FRAME MATCHING ACTIVITYID WITH ACTIVITY NAME
>The activity labels data frame has two columns containing the "*ActivityID*" and "*Activity*" (i.e., activity name).
This was used to properly match *Activity* (name) with *ActivityID*'s in the Merged\_Dataset, by the use of the "*merge*" command (in Step 7).

##### STEP 7:  ADD COLUMN OF ACTIVITY NAME ("ACTIVITY") TO MERGED\_DATASET BY MERGING IT WITH ACTIVITY_LABELS DATA FRAME (from STEP 6)

>First, a *merging "index" column* was added into the *Merged\_Dataset*, in order to preserve the row order of the *Merged\_Dataset* dataframe when the `merge` function is  applied.    Inevitably, the `merge` function will destroy the row order of the merged dataframe (which would not be desirable in this case).
The orginal row order can be restored by using the "merging index".   
Once this was done, the "activity_labels" DF was merged with the *Merged\_Dataset* DF.  The merged dataframe was now the "updated"  ***Merged\_Dataset**

>After merging, the *Merged\_Dataset* DF would already contain the column of "Activity" (i.e., activity names).   

>The "*dplyr*" package was then used to properly arrange the columns of the *Merged_Dataset*, as follows:.    
* The **`arrange()`** command was used to arrange the rows of the dataframe, according to the "merging index" (previously defined), thus preserving the original row order.  Preserving the row order before and after merging is important to get the right dataframe.    
* The **`select()`** command was used to get the needed columns for SubjectID, and all the remaining columns which were extracted by regular expressions containing "t",  "f" and "a".   The command also exluded the column for  *ActivityID* by the "negative sign" in the argument, `-ActivityID`.  The *ActivityID* column was excluded, because it was no longer necessary with the presence of the "*Activity*" (name) column (obtained from the **`merge`** operation described above).


##### STEP 8:  EXTRACT FROM MERGED\_DATASET, THE COLUMNS OF MEAN AND STD DEVIATION VARIABLES FOR EACH MEASUREMENT 

>The *dplyr* package in combination with regular expressions was used to extract the needed data containing means and standard deviations ("mean" and "std) as follows:  
* The **`select()`** command was used to ***get*** the columns for: (1) *SubjectID*, (2) *Activity*, (3) columns containing the regular expression "*.[Mm]ean*." , (4) columns containing the regular expression "*.std.*",    ***and to exclude*** the columns containing "*angle*" and "*Freq*".   As mentioned in my CodeBook, data columns for "*Angle*" and "*Freq*" were not included since they are calculated data, and not "*measurement signals*".  Only *measurement signals* were taken in the making of the  tidy data.   

>The data frame containing the extracted column names was called **"Extracted\_Dataset"**.  


>**NOTE** :  As mentioned in my Code Book, only the mean and standard deviations for "*measurement signals*" were taken. (Please refer to my CodeBook for details).   

>This column names with mean and std's for "*Angle*" and "*Freq*" were not included, because by definition (in my Code Book), these were computed values, 
and not "*measurement signals*".  

>Thus the total number of columns was **68**, broken down into **66** (mean and std) feature columns (of "*measurement signals*"), plus **1** column for *SubjectID*, plus **1** column
for Activity.  


>The "***Activity***" column of the Extracted_Dataset was also formalized as a factor with 6 levels of "activities"


##### STEP 9:  CREATE SECOND, INDEPENDENT TIDY DATASET (initially named, "***PreFinal\_TidyData***" ) WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECTID
>The *dplyr* package was again used to conveniently obtain the averages (i.e., the *mean(s)* of the column variables in the ***Extracted\_Dataset***, arranged according to *Activity* and *SubjectID*, and then saving the results into a new dataframe (called, ***PreFinal\_TidyData***) as follows:   
*   The **`group_by()`** command was first used to arrange the rows of the ***Extracted\_Dataset*** according to *SubjectID* and *Activity* (i.e., activity name).  
* The **`summarise_each(funs(mean))`** command was then used to compute the means of the feature columns that were already previously arranged according to *SubjectID* and *Activity*.   
* Finally, the **`arrange()`** command was used to make the primary ordering of the rows according to *Activity*

>As mentioned previously, the new dataframe was called "***PreFinal_TidyData***".  

>In preparation for making the ***Final\_TidyData***, the column names were modified in order to comply with the requirements for tidy data, i.e.: (1) *human readable*, (2) *no punctuations and/or symbols*.   

>All forms of punctuation in the original column names were removed, and modified to make it more human readable.  
This resulted in very long file names, and thus *CamelCase* was used to improve readability.  Modification of column names were done by text manipulation via the stringr package.  These operations were done in Step 10.


##### STEP 10: REPLACE COLUMN NAMES OF FINAL_TIDYDATA WITH MORE DESCRIPTIVE LABELS COMPLYING REQUIREMENTS FOR TIDY DATA:  TEXT MANIPULATION VIA stringr PACKAGE ---> THEN FINALIZE "***Final\_TidyData***"

>The *stringr* package (particularly the **`str_replace`** and the **`str_replace_all`** commands) was used to convert the raw column names into those which comply with the requirement for column names of tidy data:
Among these are: (1) *human readable names*, (2) *no punctuations and/or symbols*.

>*CamelCase* had to be used because the column names were quite very long.   
The final dataframe of tidy data was called "***Final_TidyData***",   containing **180 rows** (30 *SubjectID*''s x 6 *Activity*'s) and **68 columns** ( 1 for  *Activity* + 1 for *SubjectID* + *66 for extracted mean and std of measurement signals* (pls refer to CodeBook and README))

##### STEP 11: SAVE "*Final_TidyData*" DATA SET AS TXT FILE IN WORKING DIRECTORY

>The Final_TidyData was converted to a text file named, "Final_TidyData.txt", in compliance with the instructions of the Course Project.  
 
>**NOTE:**  The saved text file can be read back into R by the following command:   
**`TidyData <- read.table("Final_TidyData.txt", header=TRUE)`**
