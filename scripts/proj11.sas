TITLE 'Introduction to SAS: Project 11';

* Read in the data on milk production by month;
DATA MILK;
  INFILE '/folders/myfolders/milk.dat' MISSOVER;
  INPUT YEAR MILK @;
  IF YEAR<1975;
  DO MONTH=1 TO 12;
    OUTPUT;
    INPUT MILK @;
  END;
RUN;

* Fit an ARIMA model to the time series to predict milk production for 1975;
ODS PDF FILE='/folders/myfolders/proj11-milk.pdf';
PROC ARIMA
  DATA=MILK;
  IDENTIFY
    VAR=MILK(12)
    NLAG=30
    CENTER
    OUTCOV=MILKCOV
    NOPRINT;
RUN;
ESTIMATE
  P=1 Q=3
  NODF
  NOCONSTANT
  METHOD=ML
  PLOT;
RUN;
FORECAST
  LEAD=12
  OUT=MILKPRED
  PRINTALL;
RUN;
ODS TEXT="The predictions for milk production in the training data had an r^2 of
 0.9921 while the predictions for milk production in the year of 1975 had an r^2
 of 0.9096 -- this is a good model.";
ODS PDF CLOSE;

* Read in the data on milk production by month;
DATA AIRLINE;
  INFILE '/folders/myfolders/airline.dat' MISSOVER;
  INPUT YEAR MILES @;
  IF YEAR<1977;
  DO MONTH=1 TO 12;
    LOGMILES=LOG(MILES);
    OUTPUT;
    INPUT MILES @;
  END;
RUN;

* Fit an ARIMA model to the time series to predict milk production for 1975;
ODS PDF FILE='/folders/myfolders/proj11-airline.pdf';
PROC ARIMA
  DATA=AIRLINE;
  IDENTIFY
    VAR=LOGMILES(12)
    NLAG=30
    CENTER
    OUTCOV=LOGMILESCOV
    NOPRINT;
RUN;
ESTIMATE
  P=1 Q=3
  NODF
  NOCONSTANT
  METHOD=ML
  PLOT;
RUN;
FORECAST
  LEAD=12
  OUT=LOGMILESPRED
  PRINTALL;
RUN;
ODS TEXT="The predictions for log flight counts in the training data had an r^2
 of 0.9852 while the predictions for log flight counts in the year of 1977 had
 an r^2 of 0.7802 -- this a poor model.";
ODS PDF CLOSE;