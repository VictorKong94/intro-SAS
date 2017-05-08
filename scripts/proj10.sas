TITLE 'Introduction to SAS: Project 10';

* Load the Iris data;
DATA IRIS;
  INFILE '/folders/myfolders/iris.dat';
  LENGTH SPECIES $10;
  DO SPECIES='SETOSA','VERSICOLOR','VIRGINICA';
    INPUT SEPAL_LENGTH SEPAL_WIDTH PETAL_LENGTH PETAL_WIDTH @;
    OUTPUT;
  END;
RUN;

* Are the four measurements different for each Iris species?;
ODS PDF FILE='/folders/myfolders/proj10-part1.pdf';
PROC GLM
  DATA=IRIS;
  CLASS SPECIES;
  MODEL SEPAL_LENGTH SEPAL_WIDTH PETAL_LENGTH PETAL_WIDTH=SPECIES;
  MANOVA H=_ALL_;
RUN;
ODS TEXT="There appears to be a significant difference in all four measurements
 between the species. There is a good prospect for building a classification
 model for species using these four measurements.";
ODS PDF CLOSE;

* Are length measurements twice width measurements?;
ODS PDF FILE='/folders/myfolders/proj10-part2-1.pdf';
PROC GLM
  DATA=IRIS;
  CLASS SPECIES;
  MODEL SEPAL_LENGTH SEPAL_WIDTH=SPECIES;
  MANOVA H=_ALL_
         M=(1 -2) PREFIX=DIFF;
RUN;
PROC GLM
  DATA=IRIS;
  CLASS SPECIES;
  MODEL PETAL_LENGTH PETAL_WIDTH=SPECIES;
  MANOVA H=_ALL_
         M=(1 -2) PREFIX=DIFF;
RUN;
ODS TEXT="The length measurements do not seem to be twice the width measurements
 for either sepals or petals.";
ODS PDF CLOSE;

* Are the sepal length means the same for all three species?;
ODS PDF FILE='/folders/myfolders/proj10-part2-2.pdf';
PROC GLM
  DATA=IRIS;
  CLASS SPECIES;
  MODEL SEPAL_LENGTH=SPECIES;
  MANOVA H=_ALL_;
RUN;
ODS TEXT="Sepal lengths are not the same for all three species. This analysis
 can substitute the univariate one-way ANOVA done in Project 8, though the other
 was more informative.";
ODS PDF CLOSE;

* ;
ODS PDF FILE='/folders/myfolders/proj10-part3.pdf';
PROC GLM
  DATA=IRIS;
  MODEL SEPAL_WIDTH=SEPAL_LENGTH PETAL_LENGTH PETAL_WIDTH;
  MANOVA H=_ALL_;
RUN;
ODS TEXT="It does appear that sepal width could be modeled as a linear function
 of the other three measurements.";
ODS PDF CLOSE;