TITLE 'Introduction to SAS: Project 9';

* Load the tomato yield data;
DATA TOMATO;
  INFILE '/folders/myfolders/tomato.dat' MISSOVER;
  INPUT SOIL $ YIELD @;
  DO FERTILIZER=1,1,2,2,3,3;
    OUTPUT;
    INPUT YIELD @;
  END;
RUN;

* Assess soil and fertilizer combination for the greatest yield;
ODS PDF FILE='/folders/myfolders/proj9-tomato.pdf';
TITLE3 'Tomato Yield by Soil and Fertilizer Combination';
PROC GLM
  DATA=TOMATO;
  CLASS SOIL FERTILIZER;
  MODEL YIELD=SOIL FERTILIZER;
  MEANS SOIL FERTILIZER / BON ALPHA=0.1;
  MEANS SOIL FERTILIZER / BON ALPHA=0.05;
  MEANS SOIL FERTILIZER / BON ALPHA=0.01;
RUN;
ODS TEXT="The only pairs of significantly different tomato yields with respect
 to soil are seen at the 0.10 and 0.05 between soils II and IV, in which soil IV
 appears to be more effective. With respect to fertilizer, 1 and 3 seem to be
 significantly different at all levels, with fertilizer 1 being the more
 effective of the two.";
ODS PDF CLOSE;

* Load the skin cancer incidence data;
DATA SKIN;
  INFILE '/folders/myfolders/skin.dat';
  INPUT YEAR _ TOTAL _;
  DROP _;
  LOG_TOTAL=LOG(TOTAL);
RUN;

* Fit skin cancer incidence as linear and exponential functions of time;
ODS PDF FILE='/folders/myfolders/proj9-skin.pdf';
TITLE3 'Skin Cancer Incidence as Function of Time';
PROC GLM
  DATA=SKIN;
  MODEL TOTAL=YEAR;
RUN;
PROC GLM
  DATA=SKIN;
  MODEL LOG_TOTAL=YEAR;
RUN;
ODS TEXT="The model for skin cancer incidence as a linear function of time
 appears slightly better than its exponential counterpart, as we can see both in
 the plots and in the coefficients of determination (0.928330 vs. 0.884024).
 From the plot, I would also think adding a sinusoidal component to the model
 would improve it greatly.";
ODS PDF CLOSE;