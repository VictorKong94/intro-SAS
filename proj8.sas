TITLE 'Introduction to SAS: Project 8';

* Load the iris data with species and sepal length;
DATA IRIS;
  INFILE '/folders/myfolders/iris.dat';
  LENGTH SPECIES $10;
  DO SPECIES='SETOSA','VERSICOLOR','VIRGINICA';
    INPUT SEPAL_LENGTH _ _ _ @;
    OUTPUT;
  END;
  DROP _;
RUN;

* Test equality of sepal length for the three species;
ODS PDF FILE='/folders/myfolders/proj8-iris.pdf';
TITLE3 'Comparison of Sepal Length Between Iris Species';
PROC GLM
  DATA=IRIS;
  CLASS SPECIES;
  MODEL SEPAL_LENGTH=SPECIES;
  MEANS SPECIES / BON ALPHA=0.1 CLM;
  MEANS SPECIES / BON ALPHA=0.01 CLM;
RUN;
ODS PDF CLOSE;

/*******************************************************************************
 Briefly, are the three mean lengths different? Which pairs are different at the
 90% level? At the 99% level?
 
 The three mean lengths are indeed different. In fact, all pairs are different
 at both the 90% and 99% levels.
*******************************************************************************/

* Load the data on birth weight of Poland China pigs;
DATA PIG;
  INFILE '/folders/myfolders/pig.dat' MISSOVER;
  INPUT LITTER WEIGHT @;
  DO WHILE (WEIGHT NE .);
    OUTPUT;
    INPUT WEIGHT @;
  END;
RUN;

* Test for the presence of litter effect;
ODS PDF FILE='/folders/myfolders/proj8-pig.pdf';
TITLE3 'Accessing the Presence of Litter Effect in Poland China Pigs';
PROC GLM
  DATA=PIG;
  CLASS LITTER;
  MODEL WEIGHT=LITTER;
  MEANS LITTER / SCHEFFE ALPHA=0.05;
RUN;
ODS PDF CLOSE;

/*******************************************************************************
 Is there litter effect at the 5% level of significance?
 
 There is insufficient evidence to conclude the presence of litter effect at the
 5% level of significance.
*******************************************************************************/