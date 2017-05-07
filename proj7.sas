TITLE 'Introduction to SAS: Project 7';

* Load the data on skin cancer incidence vs. sunspot activity;
DATA SKIN;
  INFILE '/folders/myfolders/skin.dat';
  INPUT YEAR MALE TOTAL SUNSPOT;
RUN;

* Plot showing MALE ~ YEAR and TOTAL ~ YEAR;
PROC SGPLOT
  DATA=SKIN;
  SERIES X=YEAR Y=MALE;
  SERIES X=YEAR Y=TOTAL;
  XAXIS LABEL='Year';
  YAXIS LABEL='Skin Cancer Incidence per 100000';
  TITLE 'Incidence of Skin Cancer by Year';
RUN;

* Plot with two Y-axes showing MALE ~ YEAR and SUNSPOT ~ YEAR;
PROC SGPLOT
  DATA=SKIN;
  SERIES X=YEAR Y=MALE;
  SERIES X=YEAR Y=SUNSPOT /Y2AXIS;
  XAXIS LABEL='Year';
  YAXIS LABEL='Skin Cancer Incidence per 100000';
  Y2AXIS LABEL='Sunspots';
  TITLE 'Male Skin Cancer Incidence vs. Sunspots by Year';
RUN;

* Plot showing TOTAL ~ YEAR (line) and SUNSPOT ~ YEAR (needle);
PROC SGPLOT
  DATA=SKIN;
  SERIES X=YEAR Y=TOTAL;
  NEEDLE X=YEAR Y=SUNSPOT;
  XAXIS LABEL='Year';
  YAXIS DISPLAY=(NOLABEL);
  TITLE 'Total Skin Cancer Incidence vs. Sunspots by Year';
RUN;

* Load the data on tomato yield by soil and fertilizer;
DATA TOMATO;
  INFILE '/folders/myfolders/tomato.dat' MISSOVER;
  INPUT SOIL $ YIELD @;
  DO FERTILIZER=1,1,2,2,3,3;
    OUTPUT;
    INPUT YIELD @;
  END;
RUN;

* Plot of yield as a function of soil and fertilizer;
PROC SGPLOT
  DATA=TOMATO;
  VLINE SOIL /GROUP=FERTILIZER RESPONSE=YIELD STAT=MEAN;
  XAXIS LABEL='Soil';
  YAXIS LABEL='Mean Yield';
  TITLE 'Mean Tomato Yield by Soil and Fertilizer';
RUN;

/*******************************************************************************
 Does a two-factor additive model for yield as a function of soil and fertilizer
 make sense here?

 While there may be interaction between soil and fertilizer, it is sufficient to
 assume a two-factor additive model for yield as a function of the two.
*******************************************************************************/