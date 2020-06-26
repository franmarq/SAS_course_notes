/*st101s01.sas*/ /*Part A*/ 
%let interval=BodyTemp HeartRate; 
ods graphics; 
ods select histogram; 
proc univariate data=stat1.NormTemp noprint; 
   var &interval; 
   histogram &interval / normal kernel; 
   inset n mean std / position=ne; 
   title "Interval Variable Distribution Analysis"; 
run;
/*st101s01.sas*/ /*Part B*/ 
proc ttest data=stat1.NormTemp h0=98.6 plots(only shownull)=interval; 
   var BodyTemp; 
   title 'Testing Whether the Mean Body Temperature=98.6'; 
run; 
title;

/*st101s02.sas*/ 
ods graphics; 
proc ttest data=STAT1.German plots(shownull)=interval; 
   class Group; 
   var Change; 
   title "German Grammar Training, Comparing Treatment to Control"; 
run;


/**/

/*st102s01.sas*/  /*Part A*/
proc means data=stat1.garlic; 
   var BulbWt;
   class Fertilizer;
   title 'Descriptive Statistics of BulbWt by Fertilizer';
run;

proc sgplot data=stat1.garlic;
    vbox BulbWt / category=Fertilizer 
                  connect=mean;
    title "Bulb Weight Differences across Fertilizers";
run;

title;


/*st102s01.sas*/  /*Part B*/
ods graphics;

proc glm data=stat1.garlic plots=diagnostics;
    class Fertilizer;
    model BulbWt=Fertilizer;
    means Fertilizer / hovtest=levene;
    title "One-Way ANOVA with Fertilizer as Predictor";
run;
quit;

title;