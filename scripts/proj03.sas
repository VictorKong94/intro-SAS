TITLE 'Introduction to SAS: Project 3';

* Load the sleep latency data saved from Project 2;
FILENAME REFFILE '/folders/myfolders/sleep.dat';
DATA SLEEP;
  INFILE '/folders/myfolders/sleep.dat';
  INPUT PATIENT WEEK1 WEEK2;
RUN;

* Modify the dataset to include paired differences;
DATA SLEEP; * Overwrite the existing dataset SLEEP;
  SET SLEEP; * Copy the existing dataset SLEEP;
  DIFFERENCE=WEEK2-WEEK1; * Add column of weekly differences;
RUN;

* Print the results of a paired t-test for drug effectiveness;
ODS PDF FILE='/folders/myfolders/proj3-drugs.pdf';
TITLE3 'Paired Comparison T-Test for Drug Effectiveness';
PROC MEANS DATA=SLEEP
  ALPHA=0.05
  MEAN STD T PRT N LCLM UCLM;
  VAR DIFFERENCE;
RUN;
ODS TEXT="There is strong evidence to suggest the drug is effective in
 decreasing sleep latency time; there is less than a 0.01% probability to
 observe such extreme differences between the two weeks purely due to chance.";
ODS PDF CLOSE;

* Import the sepal lengths from the Iris dataset;
DATA IRIS;
  INFILE '/folders/myfolders/iris.dat';
  INPUT SETOSA     _ _ _
        VERSICOLOR _ _ _
        VIRGINICA;
  DROP _; * Use _ to denote columns to drop;
RUN;

* Print PDF of IRIS dataset;
ODS PDF FILE='/folders/myfolders/proj3-iris.pdf'
  COLUMNS=2;
TITLE3 'Sepal Lengths of Iris Species';
OPTIONS PAGESIZE=55;
PROC PRINT DATA=IRIS;
RUN;
ODS PDF CLOSE;

/*******************************************************************************
 How you would conduct a statistical test of whether the sepal lengths for the
 three species are the same?

 To statistically test whether the sepal lengths for the three species are the
 same, we can perform a one-factor ANOVA using the mean sepal lengths.
*******************************************************************************/