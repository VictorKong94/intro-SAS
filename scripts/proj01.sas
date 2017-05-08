TITLE 'Introduction to SAS: Project 1';

DATA FIRST;
  INPUT NAME $ AGE;
  DATALINES;
  John 12
  Jane 11
  Jack 13
  Amy  10
RUN;

* Save printed dataset to PDF file;
ODS PDF FILE='/folders/myfolders/proj1.pdf';
PROC PRINT DATA=FIRST;
RUN;
ODS PDF CLOSE;