TITLE 'Introduction to SAS: Project 5';

* Read in the PRODPREF dataset;
DATA PRODPREF;
  INFILE '/folders/myfolders/prodpref.dat';
  INPUT JUDGE SAMPLE1 SAMPLE2
        @16 (R11-R16) (1.)
        @25 (R21-R26) (1.)
        PREFERENCE;
  * Determine each judge's preferred sample;
  IF SAMPLE1=27 AND PREFERENCE=1 OR
     SAMPLE2=27 AND PREFERENCE=2 THEN SAMPPREF=27;
  IF SAMPLE1=45 AND PREFERENCE=1 OR
     SAMPLE2=45 AND PREFERENCE=2 THEN SAMPPREF=45;
RUN;

* Determine the number of judges who preferred sample 27;
ODS PDF FILE='/folders/myfolders/proj5-samp27.pdf';
TITLE3 'How Many Judges Preferred Sample 27?';
PROC FREQ
  DATA=PRODPREF;
  TABLES SAMPPREF;
RUN;
ODS TEXT="It looks like 98 of the 200 judges preferred sample 27.";
ODS PDF CLOSE;

* ;
ODS PDF FILE='/folders/myfolders/proj5-chisq.pdf';
TITLE3 'Distributions of Rankings in Six Aspects of Quality';
PROC FREQ
  DATA=PRODPREF
  PAGE;
  TABLES R11*R21
         R12*R22
         R13*R23
         R14*R24
         R15*R25
         R16*R26
  /CHISQ;
RUN;
ODS TEXT="Although the distributions for aspect 1 seem similar for the two
 samples (p = 0.8257), the distributions for aspects 2 through 6 are likely
 different (p < 0.0020). The products are not interchangeable.";
ODS PDF CLOSE;