TITLE 'Introduction to SAS: Project 4';

/*******************************************************************************
 Import all data from the IRIS dataset.
*******************************************************************************/

DATA IRIS;
  INFILE '/folders/myfolders/iris.dat';
  DO SPECIES=1 TO 3;
    INPUT M1-M4 @;
    OUTPUT;
  END;
RUN;

/*******************************************************************************
 Create three datasets, each containing a unique combination of two species.
*******************************************************************************/

DATA IRIS12;
  SET IRIS; * Copy from the original IRIS dataset;
  WHERE SPECIES=1 OR SPECIES=2; * Keep only Setosa (1) and Versicolor (2);
  KEEP SPECIES M1; * Keep only the species and the sepal length (M1);
RUN;

DATA IRIS13;
  SET IRIS;
  WHERE SPECIES=1 OR SPECIES=3; * Keep only Setosa (1) and Virginica (3);
  KEEP SPECIES M1;
RUN;

DATA IRIS23;
  SET IRIS;
  WHERE SPECIES=2 OR SPECIES=3; * Keep only Versicolor (2) and Virginica (3);
  KEEP SPECIES M1;
RUN;

/*******************************************************************************
 Print to PDF the results of three two-sample t-tests, each using one of the
 three datasets created above.
*******************************************************************************/

ODS PDF FILE='/folders/myfolders/proj4.pdf';

TITLE3 'Comparison of Sepal Length Between Setosa and Versicolor';
PROC TTEST DATA=IRIS12;
  CLASS SPECIES;
RUN;

TITLE3 'Comparison of Sepal Length Between Setosa and Virginica';
PROC TTEST DATA=IRIS13;
  CLASS SPECIES;
RUN;

TITLE3 'Comparison of Sepal Length Between Versicolor and Virginica';
PROC TTEST DATA=IRIS23;
  CLASS SPECIES;
RUN;

ODS PDF CLOSE;

/*******************************************************************************
 How could I use the WHERE= statement to avoid making the above three datasets?
 
 In PROC TTEST, I could have instead specified DATA=IRIS(WHERE(SPECIES=I OR
 SPECIES=J) KEEP=SPECIES M1), where I and J are the two species being compared.
*******************************************************************************/

/*******************************************************************************
 Are the mean sepal lengths different? Does it matter whether the significance
 level is 0.05 or 0.01?
 
 The mean sepal lengths are indeed different and it does not matter whether the
 significance level is 0.05 or 0.01.
*******************************************************************************/
