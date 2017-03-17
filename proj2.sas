TITLE 'Introduction to SAS: Project 2';

* Put the sleep latency data into an SAS dataset;
DATA SLEEP;
  INPUT @@ PATIENT WEEK1 WEEK2; * Use @@ if multiple iterations per line;
  DATALINES;
  1   61.07   20.36   26  16.07   7.50   51  41.79   11.79
  2   46.07   37.50   27  33.21   26.79  52  22.50   22.50
  3   84.64   61.07   28  51.43   20.36  53  39.64   18.21
  4   31.07   9.64    29  28.93   18.21  54  78.21   26.79
  5   54.64   28.93   30  139.29  37.50  55  46.07   16.07
  6   26.79   11.79   31  78.21   39.64  56  46.07   28.93
  7   58.93   31.07   32  43.93   35.36  57  61.07   33.21
  8   13.93   9.64    33  111.43   7.50  58  39.64   28.93
  9   71.79   35.36   34  56.79   31.07  59  56.79   18.21
  10  82.50   33.21   35  106.07  43.93  60  43.93   24.64
  11  37.50   24.64   36  98.57   77.14  61  43.93   24.64
  12  35.36   46.07   37  43.93   70.00  62  31.07   24.64
  13  37.50   9.64    38  114.64  26.79  63  46.06   24.64
  14  114.64  16.07   39  39.64   33.21  64  22.50   9.64
  15  35.36   9.64    40  91.07   31.07  65  50.36   41.79
  16  73.93   35.36   41  18.21   20.36  66  41.79   18.21
  17  17.50   11.79   42  63.21   18.21  67  35.36   18.21
  18  94.29   20.36   43  37.50   20.36  68  65.36   78.21
  19  22.50   9.64    44  41.79   22.50  69  37.50   31.50
  20  58.93   30.00   45  40.00   43.93  70  48.21   9.64
  21  46.07   100.71  46  50.36   41.79  71  102.86  43.93
  22  31.07   9.64    47  48.21   60.00  72  86.79   43.93
  23  62.14   20.36   48  63.21   50.36  73  31.07   9.64
  24  20.36   13.93   49  54.64   20.36
  25  56.79   32.14   50  73.93   13.93
RUN;

* Sort the data in ascending order by patient number;
PROC SORT DATA=SLEEP;
  BY PATIENT;
RUN;

* Make a nice PDF printout of the sleep latency data;
ODS PDF FILE='/folders/myfolders/proj2-sorted.pdf'
  COLUMNS=3;
TITLE3 'Sleep Latency Data';
PROC PRINT DATA=SLEEP;
RUN;
ODS PDF CLOSE;

* Print to PDF the mean, SD, and 90% CI for each week's sleep latency times;
ODS PDF FILE='/folders/myfolders/proj2-means.pdf';
TITLE3 'Means, SDs, and 90% CI for Weekly Sleep Latency';
PROC MEANS DATA=SLEEP
  ALPHA=0.10
  MEAN STD LCLM UCLM;
  VAR WEEK1 WEEK2;
RUN;
ODS PDF CLOSE;

* Print to PDF an answer concerning testing drug effectiveness;
ODS PDF FILE='/folders/myfolders/proj2-test.pdf';
TITLE3 'Testing Drug Effectiveness';
ODS TEXT="To statistically test the effective of the drug, we could perform a
 pairwise t-test assessing whether the difference between the sleep latency
 times for the two weeks equals to 0.";
ODS PDF CLOSE;

* Save the sleep latency data to be used in Project 3;
PROC EXPORT DATA=SLEEP
  OUTFILE='/folders/myfolders/sleep.dat'
  REPLACE
  DBMS=dlm;
RUN;
