
# Notes about the SAS's Course
## Statistics 1: Introduction to ANOVA, Regression, and Logistic Regression

This notes is based in the course materials, some codes and images are property . I made a Jupyter Notebook using JupiterLab with SAS University Edition. 

## 0. Script to setup the sesion
Run this script in the begining the each session to access the data in the correct way. 


```sas
%let InicioCurso=/folders/myfolders/Statistics1_ANOVA_Regression_LogisticRegression;
%include "&InicioCurso/inicio.sas";
```




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
  <title></title>
  <meta http-equiv="content-type" content="text/html; charset=None">
  <style type="text/css">
td.linenos { background-color: #f0f0f0; padding-right: 10px; }
span.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }
pre { line-height: 125%; }
body .hll { background-color: #ffffcc }
body  { background: #ffffff; }
body .c { color: #0000FF } /* Comment */
body .k { color: #ff0000; font-weight: bold } /* Keyword */
body .n { color: #008000 } /* Name */
body .ch { color: #0000FF } /* Comment.Hashbang */
body .cm { color: #0000FF } /* Comment.Multiline */
body .cp { color: #0000FF } /* Comment.Preproc */
body .cpf { color: #0000FF } /* Comment.PreprocFile */
body .c1 { color: #0000FF } /* Comment.Single */
body .cs { color: #0000FF } /* Comment.Special */
body .kc { color: #ff0000; font-weight: bold } /* Keyword.Constant */
body .kd { color: #ff0000; font-weight: bold } /* Keyword.Declaration */
body .kn { color: #ff0000; font-weight: bold } /* Keyword.Namespace */
body .kp { color: #ff0000; font-weight: bold } /* Keyword.Pseudo */
body .kr { color: #ff0000; font-weight: bold } /* Keyword.Reserved */
body .kt { color: #ff0000; font-weight: bold } /* Keyword.Type */
body .s { color: #111111 } /* Literal.String */
body .na { color: #008000 } /* Name.Attribute */
body .nb { color: #008000 } /* Name.Builtin */
body .nc { color: #008000 } /* Name.Class */
body .no { color: #008000 } /* Name.Constant */
body .nd { color: #008000 } /* Name.Decorator */
body .ni { color: #008000 } /* Name.Entity */
body .ne { color: #008000 } /* Name.Exception */
body .nf { color: #008000 } /* Name.Function */
body .nl { color: #008000 } /* Name.Label */
body .nn { color: #008000 } /* Name.Namespace */
body .nx { color: #008000 } /* Name.Other */
body .py { color: #008000 } /* Name.Property */
body .nt { color: #008000 } /* Name.Tag */
body .nv { color: #008000 } /* Name.Variable */
body .sb { color: #111111 } /* Literal.String.Backtick */
body .sc { color: #111111 } /* Literal.String.Char */
body .sd { color: #111111 } /* Literal.String.Doc */
body .s2 { color: #111111 } /* Literal.String.Double */
body .se { color: #111111 } /* Literal.String.Escape */
body .sh { color: #111111 } /* Literal.String.Heredoc */
body .si { color: #111111 } /* Literal.String.Interpol */
body .sx { color: #111111 } /* Literal.String.Other */
body .sr { color: #111111 } /* Literal.String.Regex */
body .s1 { color: #111111 } /* Literal.String.Single */
body .ss { color: #111111 } /* Literal.String.Symbol */
body .bp { color: #008000 } /* Name.Builtin.Pseudo */
body .vc { color: #008000 } /* Name.Variable.Class */
body .vg { color: #008000 } /* Name.Variable.Global */
body .vi { color: #008000 } /* Name.Variable.Instance */

  </style>
</head>
<body>
<h2></h2>

<div class="highlight"><pre><span></span><span class="s">47   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode=&#39;inline&#39;) device=svg style=HTMLBlue; ods</span><br><span class="s">47 ! graphics on / outputfmt=png;</span><br><span class="cm">NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT</span><br><span class="s">48   </span><br><span class="s">49   %let InicioCurso=/folders/myfolders/Statistics1_ANOVA_Regression_LogisticRegression;</span><br><span class="s">50   %include &quot;&amp;InicioCurso/inicio.sas&quot;;</span><br><span class="cm">NOTE: Libref STAT1 was successfully assigned as follows: </span><br><span class="cm">      Engine:        V9 </span><br><span class="cm">      Physical Name: /folders/myfolders/ECST142</span><br><span class="cm">NOTE: Libref CURSO was successfully assigned as follows: </span><br><span class="cm">      Engine:        V9 </span><br><span class="cm">      Physical Name: /folders/myfolders/Statistics1_ANOVA_Regression_LogisticRegression</span><br><span class="cm">NOTE: PROCEDURE FORMAT used (Total process time):</span><br><span class="cm">      real time           0.01 seconds</span><br><span class="cm">      cpu time            0.02 seconds</span><br><span class="cm">      </span><br><span class="s">75   </span><br><span class="s">76   ods html5 (id=saspy_internal) close;ods listing;</span><br><br><span class="s">77   </span><br></pre></div>
</body>
</html>




## 7: Categorical Data Analysis

* Logistic regression is used to model the relationship between a binary response variable and a set of predictor variables. 
* first look for associations between predictors and a binary response using hypothesis tests. 
* build a logistic regression model and discuss how to characterize the relationship between the response and predictors. 
* use logistic regression to build a model, or classifier, to predict unknown cases.

#### Associations between Categorical Variables

* you can determine the frequencies of data values and possible associations among variables. An association exists between two categorical variables if the distribution of one variable changes when the value of the other variable changes.
* To look for associations, you examine the frequencies of values across the combinations of variables. 

#### Demo: Examining the Distribution of Categorical Variables Using PROC FREQ and PROC UNIVARIATE



```sas
title;
proc format;
    value bonusfmt 1 = "Bonus Eligible"
                   0 = "Not Bonus Eligible"
                  ;
run;

proc freq data=STAT1.ameshousing3;
    tables Bonus Fireplaces Lot_Shape_2
           Fireplaces*Bonus Lot_Shape_2*Bonus/
           plots(only)=freqplot(scale=percent);
    format Bonus bonusfmt.;
run;

proc univariate data=STAT1.ameshousing3 noprint;
    class Bonus;
    var Basement_Area ;
    histogram Basement_Area;
    inset mean std median min max / format=5.2 position=nw;
    format Bonus bonusfmt.;
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="proc_title_group">
<p class="c proctitle">The FREQ Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Sale Price &gt; $175,000</th>
</tr>
<tr>
<th class="r b header" scope="col">Bonus</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">Not Bonus Eligible</th>
<td class="r data">255</td>
<td class="r data">85.00</td>
<td class="r data">255</td>
<td class="r data">85.00</td>
</tr>
<tr>
<th class="r rowheader" scope="row">Bonus Eligible</th>
<td class="r data">45</td>
<td class="r data">15.00</td>
<td class="r data">300</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Bar Chart of Percents for Bonus" src="data:image/png;base64,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5szZunVrenr6vn0N/JKT7OxsjUZz8eLFMWPGPPHEE/W+/NjY2EWLFp09e/b69etLly5txQDobPgWQJukp6cr6DSqqqrc3NwURTl8+HBISEh1dXVycvJDDz2kKMqmTZumTp2qHlZZWWk2m69evVpUVKQG2HEHxz8/vr6+R44caezuJ06cGDBggLp48uTJ3r17K4py9OjRe+65RzXgK4QAAAqjSURBVF38/vvv+/XrpyjKoUOHevbsmZycXF1dffPM9f7Q/uIXv1DvGxoa6nhh48aN6k2Kohw/flzd2X7riRMngoOD1Vurq6tNJlNxcbH91k2bNk2cOFG99cyZM35+fs54vtEB8S0Ap0hPT+cVcCcVGRkZHR29du1a+8qlS5cCAwPVy2azuXv37hcvXmzs7urHUeXl5WvXrn3ggQfOnTt3y7sbjcba2trGNoyKitq4ceMbb7zRq1ev//zP/6ypqWnwEVUffPBBg5sUFRX17NlTvdzgv21pNBrVC25ubr6+vuqbhPYv/9NPP1VPb+nTp09hYSFvwaEJfAug7Qhw5/Xf//3fiYmJ9rOxevbsmZeXp16+du1aYWFhQEBA0zt4eHg8/vjjQUFB3377bfPvrtVq7f9xcfyvzMMPP5ycnJyVlXXs2LGtW7e24ivq2bOn/WOtioqKmw+4du2aoihCiKqqqsuXLztO2KtXr5kzZzr+fGo2m1sxAzoVvgXQFgS487rjjjtefPHF5cuXq1cnT568f//+jz76qKSkZP78+ePGjfPx8fH09KysrCwuLm5wh8rKyq1bt+bk5ERERDR49wbv1bt377y8vIMHD1qt1ueff15d/Oqrr/7rv/7LarVqtVqz2Wz/Ob1FJk2atG/fvr179+bn5y9evPjmA3788cc///nPZWVlS5YsGTdunIeHh/2mhx9+eN++fbt27bp27dqxY8cmTZpUWlraihnQqfAtgLYgwJ3anDlz7GdX3XHHHR999NGyZcsCAwMvXLiwadMmIYSbm9usWbP8/f0PHjzoeEdPT0+NRuPj4/Pqq68mJSX169evwbs3SD3J86GHHpo4caL9RJWIiAibzTZixIg+ffr07t37l7/8Zb17qY9o1+AJJv7+/m+//facOXOGDx8eGxt781twffr00el0vXr1+u677958803Hm7p27bpr166XX37Z39//8ccfnzJliqenZ7OeRHRKfAug7TTp6emDBw+WPQbgTBUVFX/6058uX768fft22bMAEvAt4PoyMjJ4BYyOIy0tTX1x4O/vn5eX53iKGdAZ8C1we+H3AaPjCA8PV08wATonvgVuL7wCBgBAAgIMAIAEBBgAAAkIMAAAEhBgAAAkIMAAAEhAgAEAkIAAAwAgAQEGAEACAgygTaZPny57BOC2RICBdmG1WmfNmtWzZ0+z2Txq1Khdu3Y1fbBGo2nmzh4eHvZfidOjR4+nn3765l8b9+OPPw4YMODmX+reTBUVFXV1dbc8bOfOnQMHDvz444/79++/ZMkS9fe322y2kydP/vznP3/kkUfUwz744APNv1u1apUQolevXo6LWVlZ9fbPysq69957TSZTSEjIp59+2tJFwMURYKBdTJkyRafTHT58uKSkZP369bt37/7444+dtfnRo0cVRamrqzt48ODZs2d///vf1zuge/fuJ0+ebN3vlBVCpKenDx8+vMFfeGd38uTJ2bNnr1u3bsqUKbt27crJyVF/FXxsbOykSZPsv5peCDFjxgz773gvLi728vKaMmWKelN+fr79prCwMMf9FUWZPn360KFD8/Pzly5dGhcXV1hY2PzF1n3hwE8qPT1dAeBUtbW1Op0uLS2twVt3794dFRVlMpl69+791ltvKYpy4cIFIYR6a2Zm5ujRoz09PYcOHfrtt9/efHeLxaIGWPXhhx/27dtXUZQzZ85069YtJSXF09Pz3XfftW+Yk5Pz0EMPeXt7h4aGbt68uZmPcuLEiZiYmAcffDAjI6PBr2Lr1q1jx45VFGXatGk33/qXv/xlypQpN68vWrRo6tSp6uWAgADHANeTlpZmMBhKSkrUqyNGjNi4cWPzFxvbFnAR6enpvAIGnE+r1b7wwgvTpk3bsGFDQUFBvVs3bNiwePHiK1euvPnmm88880x+fr79poqKivHjx8fExFy8eHHevHkPPfTQ1atXG3sURVHOnDnz+uuvjxs3zr6yZcuWCxcujB49Wl25du3a+PHjBw0adPr06ffffz85ObmZjxIeHp6SkvKHP/xh5syZTz755KVLl+odMHLkyOPHj69YseLChQvqm8+3VFpaun79+kWLFqlXfX19w8PDLRbLyJEjv/jii3oHZ2VlBQUFeXt7q1cHDBhw6tSp5i82Zx5ALgIMtIsVK1a89957aWlpgwYNGjNmzO7du+037dmzZ+LEiWaz+YEHHujRo0d2drbjTZ6enosWLfL09JwxY8bQoUOTkpJu3nz48OEajUar1d57770hISGvvvqqun7lypX4+Hh7ioQQe/fuNZlMq1at6tq165AhQ9TdmvkoQoiJEycePXr0woULMTEx9W4KDg7esWNHRkZGTk6Ov7//kiVLamtrm35OXnvttaioqKFDh6pX09LSCgoKfvzxx1mzZj388MP1qllZWenl5WW/6u3tXVlZ2fzFpicBXAEBBtrLiBEj3nrrrUuXLv3xj3+cP3++/ZXfu+++GxMT07t3b4vFcu7cuRs3btjvYrVas7Oz7eclpaSkOH6Yamd/Czo/P//111/38PBQ13U6XVRUlOOR58+fDwkJqXeGVzMfRQixd+/e4cOH9+rVKyUl5eZbJ0yYsGPHjnHjxqWlpSUnJ//tb39r4tmoqKhYt26d/Umws1gszzzzzLBhwz755JN662VlZfarlZWVFoul+YtNTAK4CL3sAYAOzmAwPPLIIzqdbu7cuStWrEhOTp4/f/6GDRsiIyO7dOkSHh7ueHBgYOCoUaMOHDjgrEcPDAw8deqUoiiODW7Oo6Slpc2bN0+n023dunXQoEFNP0qfPn3Gjx9/8uTJJo5JTEwcPHjwvffe2+CtN27cMBgMjithYWFnz54tLS1VX9D/61//mjlzZvMXmx4YcAW8Agacr7y8fNy4cVu2bDl79mx1dXVqaurKlSvHjh0rhDh37lxISMj9999fW1u7cuXKnJwcm81mv+ODDz5otVrXrVtXWlp64cKFl19++aWXXmrLJJMmTbpx48aCBQuuXr2anp4+efLkqqqqWz7KwYMHn3zyyfnz5+/du7ex+qakpMyaNSstLU09Gfudd94ZP358Y2NUVVX99a9/dXz5u2nTpueffz4nJ6e8vPzVV1/94YcfYmNjHe8yaNCg4ODgF1988erVq++///7x48djY2Obv9iWJw34iXAWNNAezp0799RTT/n7+7u5uYWGhq5YsaK6ulpRlKtXr8bExJjN5rvvvvu1116LiYl55ZVXHM+Czs7Onjx5cteuXXv06DFz5sy8vLx6O9c7C9ruzJkzOp1Ovey4YV5e3uTJk318fPr167du3bra2tpbPkp5ebl6WBPKy8sXL14cGhqq0Wj69u37+uuvO95a7yzohISEqKgoxwMKCwufffbZvn37WiyWqKiogwcPquujR49es2aNevmHH36IjIw0Go39+/f/5JNPWroIuLL09HRNenr64MGDZf8YAOB2NX369MbO4WqFsWPHrlmzZsSIEc7aEHBNGRkZBBgAgJ9aRkYGnwEDACABAQYAQAICDACABAQYAAAJCDAAABIQYAAAJCDAAABIQIABAJCAAAMAIAEBBgBAAgIMAIAEBBgAAAkIMAAAEhBgAAAk0AshMjIyZI8BAEDn8j9wUyMN2zv3JAAAAABJRU5ErkJggg=="/>
</div>
</div>
</div>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Number of fireplaces</th>
</tr>
<tr>
<th class="r b header" scope="col">Fireplaces</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">0</th>
<td class="r data">195</td>
<td class="r data">65.00</td>
<td class="r data">195</td>
<td class="r data">65.00</td>
</tr>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="r data">93</td>
<td class="r data">31.00</td>
<td class="r data">288</td>
<td class="r data">96.00</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="r data">12</td>
<td class="r data">4.00</td>
<td class="r data">300</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Bar Chart of Percents for Fireplaces" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAIAAAC6s0uzAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO3dfVSUdf7w8e/AzDAwPKkkKgmED5ii6Q/WNMk8qfmw5eoSrZlubsfdooefldXRY5bWSTc3LdYKbUstc9WkbVtbM6luO5KFIYliEQ8+TqghCsPDKAxc9x/XvbNzI6CMQ58J368/OjMX13yvDzPm22tmYAz5+fkKAAD8vIxKqSFDhkiPAQDAVeTAgQN+0jMAAHA1IsAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAgFJKWSwWw38EBQUlJiZmZGQ0NTXpX21qarrxxhvj4uIqKio8PkSzRcLDww0Gw6lTp7y1YIey2+2pqalhYWEGgyE9Pd39S+53ncv8+fM7Yrwrv9MA30GAgeYcDkdeXt6DDz44ffp0TdP0jY2NjUop19UWjRkzxmAwfPrpp63tcDmLtK3ZIa58wcu0YsWKzMxMu92ulBo6dOhl3upnGw/4JTJKDwD4kOLi4r59+x4/fjwjI2P58uVbt24dO3bs/fff7+fnl5ube4WLe2WRDl2wDYWFhUqpZ599dvHixS3uoN91zTb+bOMBv0ScAQPNRUdHL1u27IEHHlBKuZ5udX/yc+/evePHj+/WrVt4ePjNN9+8cePGxsbGpKSkL774Qik1fvz4cePGuW6ye/fuPn36DB48WLX0DGp2dvbQoUMtFktycvLBgwf1jUaj0WAw1NTU6FcjIiL0W7V2CH3B+vr6Z599Ni4uzmw29+rV66GHHqqsrHQffv369UlJScHBwUlJSfv27bv4G29thfDw8Pfee08ptWTJkvDw8Mu/J93Hu/jecDgcjz32WM+ePfVvPy8vz/1WmZmZF98z7r744ovU1NRrrrkmJCRk1KhROTk5+vampqaVK1cmJCRYLJbevXvPmjWruLi4jcO1+Ghe/vcIeC4/P18DrnoBAQFKqeLiYteW/fv36/+PVFVVaZoWFhamlDp58uT58+cvjlBxcXFiYqLr6tixY103GTFihFJq5syZ7ou4LptMJtetoqKiamtrNU3z9/dXSlVXV+uTdOvWTb9Va4fQF7zzzjubTTVs2LD6+nrXbu7i4uIuvhNaW8H95mFhYS3edc2sW7euxe/X/d6444473G8SHh5eUVHR9j3jWrCxsbHZN9W9e3e73a5p2uzZs5sNc+edd7Z2uNYeTe/9yQJalp+fzxkw0LLevXvrF1znkbqzZ89WVlaGhoa+9dZbZWVlH3300ZgxY/r06ZObm3vLLbcopbKystxfBj5+/PgPP/ywYcOGFo8yZ86cU6dO7du375prrvnxxx///ve/tzFSa4dQSuXn52dmZvr5+b333ns1NTWff/55aGjot99+m5mZ6donNTX11KlTX3/9tZ+f3+HDh5u9lamNFSorK1NSUpRSGzZsaHZvtJfr3ti/f/+2bdsiIiK++eaburq6559/vrKy0v3tXW3fM35+fikpKa+//vrZs2fLysr69+//008/5efnf/fdd+vXr1dKLV++vLKy8tixY3Pnzh04cGBrh2vt0byS7xG4XJwBA1pLZ8D665cGg0E/E3U/mVuyZInRaFRKdevW7dlnn9VPkTVNc9VRv6rfZMOGDa41Lz4j1C9rmvbYY48ppR577DGt9TPg1g5x8uTJt956Syk1ZswY17EefPBBpdTjjz/u2q2srEz/Uq9evdRF53ltr+AK8OXcdW18v64V9MM18+tf/7rte8b9S8eOHXvkkUeGDBniOhX+4IMP1q5dq5S66aab3Meora1t43CtPZpAh+IMGGjVK6+8opQaNmxYcHBwsy8988wz33///bx585qampYsWXL99dfrrzK2SH+x9pL01x0DAwNdW5xOZ3tn1tzeb+z6GSoXg8GgX3B/drddK1w5173h59fCXz42m+3ijRffM0qp06dPJyYmrlq16sCBA1VVVc1uol30vus2DteuRxPwIgIMNHf06NGHHnro3XffVUo9+eSTzb76448/Tpgw4cSJE88888zhw4fHjh1bVlb2xhtvKKX0E6lvv/328o/10ksvlZeX5+Xlbdy4USmVkJCglLJarUqpf/3rX2fOnHn66afdf462tUMkJSUppXbv3r1ly5a6urrPPvtMn1/ffjmufIV20V8M7tq168cff+xwOI4ePbpy5cqpU6e6dmjxnnHZuXPnmTNnJk6cmJeXt2LFCovFom8fOXKkUuqrr75avnx5VVXVyZMnlyxZ8sQTT7R2uDYeTaDD8RQ0oLXyTqK0tDTXDq4nP7dv337xnmvXrtU07ZFHHtGvRkVFaRc9laq19JSs/myzLi4u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uq6uzul01tfXez49fElDQ4PT2VhXV2f099o/LvU/IX5+vvKvVVyJhvp6Z6PT4XBojfxfj45itVovZzf5ANfV1U2dOvWpp55KTExUSlmt1ur/JNbpdDqdTvfv5MKFC7W1da6rRpNRKdXY2Ojx0RsbG7WmJk3TPF4BPkXTNE1pjY2NBuW1x1T/E8Ifks5Bfxybmpqu4K8NwDuEA1xVVTVlypRZs2bdd999+pZ+/foVFBTol4uKiiIjI10nxEqp+H59m62Qt/+A6/zYAw6Hw2Q2BwQEeLwCfIrZbDYZjSEhISajv7fW1P+EcAbcOTQ0NBj9jVarNchikp4FVzvJv1MqKiomTJhw//33z5kzx7VxxIgRTqczIyOjoqJi8eLF06ZNE5wQAIAOIhng9PT0nJyce+65x2AwGAwGo9GolDKZTFu2bElPT4+KiqqpqVm6dKnghAAAdBDJAD/33HOaG6fTqW9PTk4uLCw8f/789u3bu3TpIjghAAAdhJe1AAAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBglB4AAH7Z/vnPf9p+PCk9Bbxp1qxZYaHBHX0UAgwAV+T06fL4gUOu6R4pPQi84/2tm2sd5wkwAPwCdO3arTsB7iz8DD/Ti7O8BgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAF8McHZ29oABAywWy5QpU6qqqqTHAQDA+3wuwPX19ampqXPnzrXZbAEBAQsWLJCeCAAA7/O5AO/Z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"/>
</div>
</div>
</div>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Regular or irregular lot shape</th>
</tr>
<tr>
<th class="b header" scope="col">Lot_Shape_2</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tfoot>
<tr>
<th class="c b footer" colspan="5">Frequency Missing = 1</th>
</tr>
</tfoot>
<tbody>
<tr>
<th class="rowheader" scope="row">Irregular</th>
<td class="r data">93</td>
<td class="r data">31.10</td>
<td class="r data">93</td>
<td class="r data">31.10</td>
</tr>
<tr>
<th class="rowheader" scope="row">Regular</th>
<td class="r data">206</td>
<td class="r data">68.90</td>
<td class="r data">299</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX5" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Bar Chart of Percents for Lot_Shape_2" src="data:image/png;base64,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t2/gwIEmkykhIaGyslJ2QgAAPEE4wNOnT+/Vq9fJkydXrlz56aefKqXq6uqSkpJSUlKsVquPj8/cuXNlJwQAwBP0gvddXFyclZW1detWo9E4bty4cePGKaUyMjKMRmNycrJSat68eRMmTHjnnXcEhwQAwBMkz4C//fbbqKiomTNn+vr63n333d99951SqrCwMCYmRtshOjr63LlzVVVVgkMCAOAJkmfAFRUVWVlZTz755O9///tVq1b98z//c35+fm1trb+/v7aD2WzW6/U2my0gIEDbUlBYdL6iwrmC3luvlKLQgKyampr6urrLly9LDwK0S11dnb2+vqamRu+t88T6zma1TTLAvr6+d911169+9Sul1PPPP79s2bKioiKLxVJdXa3tYLfb7Xa7xWJx3sRoNJp9TM6r3t7ezv8FIMXLy0vnpdPpPPJvGeB2Op1Op9N5eXl5e0u+DCwZ4Ojo6KKiIrvdrtfrtaeuwWAYMGBAXl6etkNBQUFoaKjzhFgp1bdP72aL7M/8pmmhAdx4vr6+er3BaDRKDwK0i8Fg8NbrfX19jQbJ8zfJ+N9xxx09evRYvHhxVVXV22+/HRYWFhkZOWrUKLvdnpaWVl5evmjRosmTJwtOCACAh0gGWKfTbd68eefOnaGhoR988MEf//hHLy8vg8GQnp6empoaERFRU1OzdOlSwQkBAPAQyZeglVK33357ZmZms41xcXH5+fki8wAAcGPwqygBABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABDgSoA3bNjQbMvChQvdMQwAAF3FtQX49OnTp0+fnjFjxukm9u/f//rrr3toPgAAOiX9Ne0dHh7e7IJSymKxzJkzx51DAQDQ2V1bgOvr65VSI0aMyMrK+vsS+mtbBAAAXFs7tdYePnw4MzOzoKCgoaHB+aXHH3/cvZMBANCJuXLy+vzzz6elpcXGxvr4+Dg3EmAAANrPlQC/++67e/fujY2Ndfs0AAB0Ea78GFJYWFjTD2EBAIBr5UqA58+f/9prr7l9FAAAug5XXoJ+/PHHGxoaVq9e3XSj3W5300gAAHR+rgS4sLDQ7XMAANCluPISdN++fQMDA3ft2rVq1aq+ffuuX7++sbHR7ZMBANCJuRLgzMzM/v37b968efny5Uopk8m0ePFidw8GAEBn5kqAk5OT09LSdu7cqV2dOnXq7t273ToVAACdnCsBLiwsnDRpkvNqYGDg5cuX3TcSAACdnysBHj58+MqVK51X165dO3r0aPeNBABA5+fKp6DfeuutCRMm/OEPf1BKxcXFWa3WXbt2uXswAAA6M1cCPGTIkKNHj27fvt1qtUZGRsbHx/v6+rp9MgAAOjEX/5Kgn5/flClTtMuXLl1qbGz08nLl1WwAALomV6q5bt26pKQk59XExMS33nrLfSMBAND5uRLgZcuWzZs3z3n1tddea/qZLAAAcFWuBPjMmTORkZHOq3369CkrK3PfSAAAdH6uBHjMmDErVqzQLjscjmXLlo0dO9atUwEA0Mm58iGs1NTUhx566OOPP77tttvy8/MbGxv5MSQAAK6JKwEuKirKy8vbsWPHyZMnH3/88fj4eJPJ5PbJAADoxFwJcFJSktVqTUxMdPs0AAB0Ea68B7xly5bf/OY3Bw4ccPs0AAB0Ea4EeNq0aZ988sno0aP1TVzPEAUFBWazuaKiQru6b9++gQMHmkymhISEysrK61kZAICOyZUAZ2VlHTp06Pjx44VNuDyBw+FITk52/j2lurq6pKSklJQUq9Xq4+Mzd+5cl1cGAKDDciXAffv2DQwM3LVr16pVq/r27bt+/frGxkaXJ0hLS7v77rudv8kyIyPDaDQmJyeHhITMmzdvy5YtLq8MAECH5UqAMzMz+/fvv3nz5uXLlyulTCbT4sWLXbt7q9W6evXq+fPnO7cUFhbGxMRol6Ojo8+dO1dVVeXa4gAAdFiuvHebnJyclpY2ZcoUnU6nlJo6darLfw84OTl52bJlTf+YUm1trb+/v3bZbDbr9XqbzRYQEKBtKTpeXFH59x7rvb2VUjU1Na7dOwC3uHjxYn19fV1dnfQgQLvU19c32O0XL16s03vkzwj5+fm1ZzdXAlxYWDhp0iTn1cDAQOc7uNdk06ZNJpOp6VJKKYvFUl1drV222+12u91isTi/6nA4HI6/v9zd6PDSNrpw7wDci2cibhaOJgTHcCXAw4cPX7lypfPjUWvXrnXtDPijjz766KOPtNNopVS3bt22bds2YMCAvLw8bUtBQUFoaKjzhFgp1T+qX7NFvjmU3XQHADeexWIxGAw+Pj7SgwDtYjQa9QaDn5+f0eAtOIYrAX7rrbcmTJjwhz/8QSkVFxdntVpd+1WUTT9gpdfry8rKgoKC6uvr7Xa79hL3okWLJk+e7MLKAAB0cK4EeMiQIUePHt2+fbvVao2MjIyPj2/6Ju51MhgM6enpTz755HPPPXf//fevXr3aXSsDANBxuPgLNPz8/KZMmeLGOex2u/NyXFxcfn6+GxcHAKCjubYPgFVWVj722GO33nrrv/7rv168eNFDMwEA0OldW4DnzJlTXl7+3//938eOHXv55Zc9NBMAAJ3etb0EvW3btq+//rpfv37Dhg279957V65c6aGxAADo3K7tDPjMmTN9+/ZVSvXr16+kpMQjEwEA0AVc8y8B0X5s1/nDuwAAwAXX/CnorKysFi+PGDHCPRMBANAFXFuALRbL+PHjr7ys+IXMAABci2sLMJUFAMAtPPKHIAAAQNsIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAAC9NIDdGhff/11VVWV9BTANRgzJs7PzyI9BYCrI8BtOZR9+JYePf38/KQHAdrl4DcH+g24/TYCDNwMCPBVDLp9cI8eodJTAO2S912O9AgA2ov3gAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQIBng2tra+fPn33rrrUFBQdOmTausrNS279u3b+DAgSaTKSEhwbkRAIDORDLA3333ndVq3bFjR1FRUW1t7csvv6yUqqurS0pKSklJsVqtPj4+c+fOFZwQAAAPkQzw3Xff/f777w8YMOCWW2555plnvv76a6VURkaG0WhMTk4OCQmZN2/eli1bBCcEAMBDOsp7wEVFRf3791dKFRYWxsTEaBujo6PPnTtXVVUlOhoAAO6nlx5AKaWqqqrefPPNjRs3KqVqa2v9/f217WazWa/X22y2gIAAbUvxyR+rqqudN/T28lZKXbx40UOD1dfX1dfX19XVeWh9wL3s9oa6usuee0a0xmaz2e08U3DTqK+vb7DbbTZbvd4jZ6EWi6U9u8kH2Gaz/exnP3vxxRdjY2OVUhaLpfpvibXb7Xa7vemRXL58+eJFm/Oq3qBXSjU0NHhotsbGRofD4XA4PLQ+4G6OxsZGzz0jWtPY2Oho5JmCm4b2D3tjY2NDg+R/tMIBrqysTEhImDFjxqxZs7QtAwYMyMvL0y4XFBSEhoY6T4iVUtED+jdbIftwrvP82O18fExGo9HHx8dD6wPupdfrTSaz554RrfHz8zPwTMHNw2g06g0GPz8/o8FbcAzJ94DLy8snTpz41FNPPfnkk86No0aNstvtaWlp5eXlixYtmjx5suCEAAB4iGSAU1NTMzMzH3vsMZ1Op9Pp9Hq9UspgMKSnp6empkZERNTU1CxdulRwQgAAPEQywK+++qqjCbvdrm2Pi4vLz8+/dOnS9u3bu3XrJjghAAAe0lF+DAkAgC6FAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCgIwZ43759AwcONJlMCQkJlZWV0uMAAOB+HS7AdXV1SUlJKSkpVqvVx8dn7ty50hMBAOB+HS7AGRkZRqMxOTk5JCRk3rx5W7ZskZ4IAAD363ABLiwsjImJ0S5HR0efO3euqqpKdiQAANxOLz1Ac7W1tf7+/tpls9ms1+ttNltAQIC2xVpSWl1T49zZ28tLKWU9VeKhYRocju/zviu2HPfQ+oB71dfbL1w4bz3lfYPv91xZuc1m+ybzwA2+X8A1lZUXHA5HSWmp3tsjZ6Emk6k9u3W4AFsslurqau2y3W632+0Wi8X51cqqqvLy886rBoNBr9f/ZeduDw1jsvjV2KprbNUeWh9wr9CeYYdzcw7nCtx14C3BZ86VCtwx4BKTr+mzz7/w3Pr+/par7tPhAjxgwIC8vDztckFBQWhoqPOEWCk1eGB0s/1H3z3ixg0HN9n8520PjIsL7tZNehCgQztVevrbnNyfPDxBehB4RId7D3jUqFF2uz0tLa28vHzRokWTJ0+WnggAAPfrcAE2GAzp6empqakRERE1NTVLly6VnggAAPfrcC9BK6Xi4uLy8/OlpwAAwIM63BkwuoLwsB4Gg1F6CqCjM/n49OjeXXoKeEpHPANGpxc3aqT0CMBN4JbgbrcE81nFToszYAAABBBgAAAEEGAAAAQQYAAABBBguKJv375ZWVkeWjwvL2/gwIEeWhy4kS5duqT7G5PJNGTIkA0bNrhlZZ4mnQCfggYAz6qurvbz86utrf3qq6+mTJly++2333nnndJDQR5nwHDd4cOHR40alZqa2qNHj0OHDjkv2+32r776atiwYUFBQb/4xS9qa2u1/dPT03v37t27d+/U1NT+/fsrpbKysoYNG6Z9NS8vT9voVF9fHxQUpJ06jB079sSJE83u1G6339gjBlxnNpsnTpw4YsSI7OxsbQtPky6OAOO6VFVVnThxorS01Nvb23m5oqIiISHhlVde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9dVXtTOqnj17Go3G999/v6amZvHixbm5uU3XPHHixG233TZ27NiGhobXXnvt6NGjdru9tQEmTZpUXl6+dOnSqqqqbdu2bdq06fHHH3f5cEQOoe1j0ev1Foul6XcAmuzs7OnTpx85cqS+vt5sNhsMhtaWbW0Yh8Px7//+7+fPn9+zZ8+mTZtmzJjR4uG78jgC140AA1f30ksvjRgxYurUqSaTadeuXZ9//nlUVNTIkSPz8vKmT58eEBCwdevWVatW9e7d2263Dxs2TCnl4+OzatWqV155JSoqqlu3btoHfZ2mT59uMBh69+49ceLE0NDQ+++//8iRI63du7+//2efffbpp59GRES8/PLLH3zwwfDhw10+FovFcuMP4arHkpKS8sADDyxcuLDpzoMGDYqKinrkkUeCg4M3btz43nvvtbZsa8N4eXlNmzZtyJAhM2fO/J//+Z877rijxcN37ZEErpMuJydn6NCh0mMAnUd0dPSKFSseeeQR6UFc1wkOQSlVXFzcv3//9pyXAzdebm4uZ8DA9Tp58mR8fHxmZmZNTc3atWtPnDhx5513Sg91bTrBIQA3HX6jG3C9wsPD4+Pjf/nLXx47dqxfv36bNm2KiIiQHuradIJDAG46vAQNAMCNxkvQAADIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACNArpXJzc6XHAACga/l/r3QAe55w/8sAAAAASUVORK5CYII="/>
</div>
</div>
</div>
</div>
<div id="IDX6" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Percent</div>
<div class="t">Row Pct</div>
<div class="t">Col Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Fireplaces&#160;by&#160;Bonus</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Fireplaces(Number of fireplaces)</th>
<th class="c b header" colspan="3" scope="colgroup">Bonus(Sale Price &gt; $175,000)</th>
</tr>
<tr>
<th class="r header" scope="col">Not Bonus Eligible</th>
<th class="r header" scope="col">Bonus Eligible</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r t rowheader" scope="row">0</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">177</div>
<div class="r t">59.00</div>
<div class="r t">90.77</div>
<div class="r t">69.41</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">18</div>
<div class="r t">6.00</div>
<div class="r t">9.23</div>
<div class="r t">40.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">195</div>
<div class="r t">65.00</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">1</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">68</div>
<div class="r t">22.67</div>
<div class="r t">73.12</div>
<div class="r t">26.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">25</div>
<div class="r t">8.33</div>
<div class="r t">26.88</div>
<div class="r t">55.56</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">93</div>
<div class="r t">31.00</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">2</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">10</div>
<div class="r t">3.33</div>
<div class="r t">83.33</div>
<div class="r t">3.92</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">2</div>
<div class="r t">0.67</div>
<div class="r t">16.67</div>
<div class="r t">4.44</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">12</div>
<div class="r t">4.00</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">255</div>
<div class="r t">85.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">45</div>
<div class="r t">15.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">300</div>
<div class="r t">100.00</div>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div id="IDX7" style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Bar Chart of Percents for Fireplaces by Bonus" src="data:image/png;base64,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/r9u63GysgoPewAAgMGmoKDAYDB4enpevnyZ9STMroJ+4403Vq9e3dzcbHlIenr6nj17Wltby8vLS0pKJk+eLBaLS0tLtVrtxYsX1Wp1TEwMw5wBAADszMHBoaOjw/G/MZqB2ej8/Py2trZt27Y9/vjjps4zZ84MECKTyVatWpWSkuLr65uVlTV27FhCSG5urkwma2lpUalUuJklAAA8hJgVYNMHeS03evToL774ok+nQqFQKBRMpwIAABgM8vLyXnzxxdra2uDgYNaTML4Ii27cunXL1dW1ra0N52gBAOBh89JLL0ml0j/96U/3cxU0s3PAt27dev311/39/d3c3AghcrmcfjADAADAw8P8KmhzjCZhtgJeunSpXq8/fvw4fQ743Xfffemll5YsWcJoEgAAgAeaVa6CZlaADx061NDQYPrs76hRoxoaGljvGwAA4AHl4ODQ3t6uVqsPHz5MCImOjn7hhReYzcBodGBgYGlpqWnz8OHDuIYZAAAeTiqVKjs7WyKRiESizMzMt956i1E4sxXwli1bpFIpfd53/vz5hw8fLioqYjQDAADAH8OuXbuqqqrok8EikSgiImLDhg2WhzMrwGKx+OLFi4cOHZoyZcrIkSOzs7MfffRRZvkCAAD8ITg5OXV2dtLtjo4OZ2dnRuEMCvDVq1fPnj07duzYl19+mdE+AAAA/nhWr149a9asl19+ube396OPPlq9ejWjcEsL8L/+9S+ZTMbn869evbp//35GjzwEAAD441mxYsXEiRPpi7D27t0bFRXFKNzSArxmzZqPP/5YKpXu378/NTX15MmTjDMdTOrq6ooOFd/PB6gBbGn4cD+F/AUHBzwcDGBwmTx58uTJk9nFWlqAf/zxx+eee44Q8uc//zkhIYHdzgaP7u5uJ2dX0bMz7J0IwL1d//nn7yu0+h6DizPP3rkAgNVYWoD1er2LiwshxMXFpbu72/IdtLW1vfHGG/v376coas2aNStWrCCEqNVqlUql1+vffPPN5ORkFnnfPydn50cewRVk8ADoun3b3ikAgPUxuAiro6Pjju2Bbwd94sQJDw+PysrKGzduzJgx4+mnnxYIBEqlsqSkxMfHRywWR0dHh4SEsEgdAADAjhYuXLh7927W4QwKsIeHxx3bA59JnTFjxowZMwgh/v7+U6ZMqaurq6mpkUgkkZGRhBC5XF5c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"/>
</div>
</div>
</div>
<div id="IDX8" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Percent</div>
<div class="t">Row Pct</div>
<div class="t">Col Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Lot_Shape_2&#160;by&#160;Bonus</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Lot_Shape_2(Regular or irregular lot shape)</th>
<th class="c b header" colspan="3" scope="colgroup">Bonus(Sale Price &gt; $175,000)</th>
</tr>
<tr>
<th class="r header" scope="col">Not Bonus Eligible</th>
<th class="r header" scope="col">Bonus Eligible</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="t rowheader" scope="row">Irregular</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">62</div>
<div class="r t">20.74</div>
<div class="r t">66.67</div>
<div class="r t">24.31</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">31</div>
<div class="r t">10.37</div>
<div class="r t">33.33</div>
<div class="r t">70.45</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">93</div>
<div class="r t">31.10</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Regular</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">193</div>
<div class="r t">64.55</div>
<div class="r t">93.69</div>
<div class="r t">75.69</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">13</div>
<div class="r t">4.35</div>
<div class="r t">6.31</div>
<div class="r t">29.55</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">206</div>
<div class="r t">68.90</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">255</div>
<div class="r t">85.28</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">44</div>
<div class="r t">14.72</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">299</div>
<div class="r t">100.00</div>
</div>
</td>
</tr>
<tr>
<th class="c header" colspan="4" scope="colgroup">Frequency&#160;Missing&#160;=&#160;1</th>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div id="IDX9" style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Bar Chart of Percents for Lot_Shape_2 by Bonus" src="data:image/png;base64,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6XTffPPNXXfdpSxw8ODB4cOH9+nT56mnnrp8+bLhuleuXBH/DWDF0KFD09PTT5486evrGxcXd/vtt+fm5upLHT161M/Pz87ObtKkScqG2ij+2Wef9e/ff8mSJd99913rb2fTpk0RERE6nS48PLz1sxMnTty5c2eLzubm5iFDhhw8eFB52Ldv3+u9VgcOHHB3d1faJ0+evP3226U6gVtbXl4eM2BAgoODw+LFi318fN577736+np9v4WFRVVVlU6nu3jx4t133/3qq68arnXhwoWpU6cuX7787Nmz9fX1r7zyyvXq19fX//vf/66oqFBuElpdXV1SUlJRUWFubq4scPHixSlTpsydO/fHH3988skn09LS2i4+ceLEY8eOOTs7T58+/cEHH9yyZUttba3+WV9f308//TQuLq6urq6dr8Ann3zSq1evsWPH6r/x22+/vW/fvjNnzvz1118NlywsLLz33nuV9l133fXLL79UV1e3v7Od4wF+x5gBA7JycnKeeuopd3f3v//9701NTS2eTUtLGzNmjM5gBrxt27bJkycrzxYXFzs5ORkur8yAFZaWliNGjEhPT9fpdCdPnuzZs+cvv/xiWOq999579NFHDVdvu7ihd955x9LS8uOPPzbs/OijjwIDA1Uq1fDhw48ePWr41DVnwGPHjk1MTGzRWV5e/uijj4aGhhp2vvXWW08++aT+YY8ePSoqKtrfeb3vArg15OXlcTtCQJqPj88HH3xQXl7+t7/9bcqUKampqT169HjnnXc+/vjjoqKiixcvjhw50nD58vLyffv2qVQqfc+VK1esra0Nl6mpqbG1tW2xoT/96U+Ojo6GPefOnRs0aJBU8Z9//nnHjh3bt2+3sbF56623HnvsMcPVQ0NDQ0NDZ86cqdFoAgMDy8rK9LPt1o4fP15cXBwcHNyi38XF5W9/+5uvr69Op9OPpFevXjU1NUq7sbGxsbGxV69e7e+83hiAWwa7oIEOcnV1/fvf/37u3LmsrKwdO3Zs2bIlNjb222+/bX22VP/+/Z966inDf35bpG/73XHHHQUFBe0v/vnnn3t5eZWXlyclJWVnZ8+bN691zAshzMzMgoKCamtrq6qq2tj63/72t4ULF/bocY1/3BsaGszMzAz/Dxg8ePDp06eVdkFBgZOTU+/evdvf2a6XA/g9I4ABCefPnw8ICPjkk08uXLhQVVW1adOmsrKyoUOHlpWVDR8+3MvL68cff1y9enWLE48DAwP379+fkpJSV1d3/PjxKVOmdPiTNlOnTj1+/Ph777136dKlHTt2rF+/vu3ivr6+xcXFb7zxxtChQ1tX27NnT3R09A8//FBfXx8bG+vp6dm3b9/rbbqkpOTzzz+fO3euvmfTpk2vvfbauXPnzp07t2TJkieeeMJw+QcffLCxsTE+Pr6ysnLVqlXTpk2T6gRufRwDBqR88803f/7zn+3s7Pr06TN+/Pjs7GydTnfu3DlfX99evXo9/PDD//rXvxwcHK5evWp4FnROTs6oUaNsbW3vueeed9991/DIceuzoBUnT56855579BvVlzp+/Lifn1/v3r3VarVybnMbxdt28eLFRYsW9e/fv0ePHv7+/vn5+YbPtjgG/Pzzzy9atMhwgXPnzs2aNcvFxaVv374RERHV1dX/X7t2bMMgDARQlEiRGIIBaNiBmi0YjZYVaJnANwgbgFOwQIooJyXvlZZ8cvcLX631uq5hGLZtq7Xu+973fdu20zQdx3Hfev8Qflgp5VFKufctgb81z/OyLB8ZdZ7nOI7runZd95GB8JMiQoAB4Nsiwh8wACQQYABIIMAAkECAASCBAANAAgEGgAQCDAAJBBgAEggwACQQYABIIMAAkODZNE1EZD8DAP7LC9kOAvycm98oAAAAAElFTkSuQmCC"/>
</div>
</div>
</div>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<hr class="pagebreak"/>
<div id="IDX10" class="proc_title_group">
<p class="c proctitle">The UNIVARIATE Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Histogram for Basement_Area" src="data:image/png;base64,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"/>
</div>
</div>
</div>
</div>
</div>
</body>
</html>




#### Practice: Using PROC FREQ to Examine Distributions
An insurance company wants to relate the safety of vehicles to several other variables. A score was given to each vehicle model, using the frequency of insurance claims as a basis. The stat1.safety data set contains the data about vehicle safety.

1. Use PROC FREQ to create one-way frequency tables for the categorical variables Unsafe, Type, Region, and Size. Submit the code and view the results.



```sas
ods graphics off;

proc print data=STAT1.safety(obs=3);
run;

proc freq data=STAT1.safety;
   tables Unsafe Type Region Size;
   title "Safety Data Frequencies";
run;
ods graphics on;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">LOGISTIC MODEL (1):Unsafe=Weight</span> </p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Data Set STAT1.SAFETY">
<caption aria-label="Data Set STAT1.SAFETY"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="r header" scope="col">Obs</th>
<th class="r header" scope="col">Unsafe</th>
<th class="r header" scope="col">Size</th>
<th class="r header" scope="col">Weight</th>
<th class="header" scope="col">Region</th>
<th class="header" scope="col">Type</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="r data">0</td>
<td class="r data">2</td>
<td class="r data">3</td>
<td class="data">N America</td>
<td class="data">Medium</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="r data">0</td>
<td class="r data">3</td>
<td class="r data">4</td>
<td class="data">N America</td>
<td class="data">Sport/Utility</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3</th>
<td class="r data">0</td>
<td class="r data">2</td>
<td class="r data">3</td>
<td class="data">N America</td>
<td class="data">Medium</td>
</tr>
</tbody>
</table>
</div>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<hr class="pagebreak"/>
<div id="IDX1" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">Safety Data Frequencies</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The FREQ Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="r b header" scope="col">Unsafe</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">0</th>
<td class="r data">66</td>
<td class="r data">68.75</td>
<td class="r data">66</td>
<td class="r data">68.75</td>
</tr>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="r data">30</td>
<td class="r data">31.25</td>
<td class="r data">96</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Type</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Large</th>
<td class="r data">16</td>
<td class="r data">16.67</td>
<td class="r data">16</td>
<td class="r data">16.67</td>
</tr>
<tr>
<th class="rowheader" scope="row">Medium</th>
<td class="r data">29</td>
<td class="r data">30.21</td>
<td class="r data">45</td>
<td class="r data">46.88</td>
</tr>
<tr>
<th class="rowheader" scope="row">Small</th>
<td class="r data">20</td>
<td class="r data">20.83</td>
<td class="r data">65</td>
<td class="r data">67.71</td>
</tr>
<tr>
<th class="rowheader" scope="row">Sport/Utility</th>
<td class="r data">16</td>
<td class="r data">16.67</td>
<td class="r data">81</td>
<td class="r data">84.38</td>
</tr>
<tr>
<th class="rowheader" scope="row">Sports</th>
<td class="r data">15</td>
<td class="r data">15.63</td>
<td class="r data">96</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Region</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Asia</th>
<td class="r data">35</td>
<td class="r data">36.46</td>
<td class="r data">35</td>
<td class="r data">36.46</td>
</tr>
<tr>
<th class="rowheader" scope="row">N America</th>
<td class="r data">61</td>
<td class="r data">63.54</td>
<td class="r data">96</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="One-Way Frequencies">
<caption aria-label="One-Way Frequencies"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="r b header" scope="col">Size</th>
<th class="r b header" scope="col">Frequency</th>
<th class="r b header" scope="col">Percent</th>
<th class="r b header" scope="col">Cumulative<br/>Frequency</th>
<th class="r b header" scope="col">Cumulative<br/>Percent</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="r data">35</td>
<td class="r data">36.46</td>
<td class="r data">35</td>
<td class="r data">36.46</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="r data">29</td>
<td class="r data">30.21</td>
<td class="r data">64</td>
<td class="r data">66.67</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3</th>
<td class="r data">32</td>
<td class="r data">33.33</td>
<td class="r data">96</td>
<td class="r data">100.00</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>




2. What is the measurement scale of each of the four variables?

Solution:
Unsafe - Nominal, Binary
Type - Nominal
Region - Nominal
Size - Ordinal
Weight - Continuous

3. Do the variables Unsafe, Type, Region, and Size have any unusual values that warrant further investigation?

Solution:
No

### Tests of Association
...

#### The Pearson Chi-Square Test
...

#### Odds ratios
...

#### Demo: Performing a Pearson Chi-Square Test of Association Using PROC FREQ

* let's run a formal test to determine whether the associations are significant.between the binary response, Bonus, and the categorical predictors, 




```sas
ods graphics off;
proc freq data=STAT1.ameshousing3;
    tables (Lot_Shape_2 Fireplaces)*Bonus
          / chisq expected cellchi2 nocol nopercent 
            relrisk;
    format Bonus bonusfmt.;
    title 'Associations with Bonus';
run;

ods graphics on;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">Associations with Bonus</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The FREQ Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Expected</div>
<div class="t">Cell Chi-Square</div>
<div class="t">Row Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Lot_Shape_2&#160;by&#160;Bonus</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Lot_Shape_2(Regular or irregular lot shape)</th>
<th class="c b header" colspan="3" scope="colgroup">Bonus(Sale Price &gt; $175,000)</th>
</tr>
<tr>
<th class="r header" scope="col">Not Bonus Eligible</th>
<th class="r header" scope="col">Bonus Eligible</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="t rowheader" scope="row">Irregular</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">62</div>
<div class="r t">79.314</div>
<div class="r t">3.7797</div>
<div class="r t">66.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">31</div>
<div class="r t">13.686</div>
<div class="r t">21.905</div>
<div class="r t">33.33</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">93</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Regular</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">193</div>
<div class="r t">175.69</div>
<div class="r t">1.7064</div>
<div class="r t">93.69</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">13</div>
<div class="r t">30.314</div>
<div class="r t">9.8893</div>
<div class="r t">6.31</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">206</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">255</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">44</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">299</div>
</div>
</td>
</tr>
<tr>
<th class="c header" colspan="4" scope="colgroup">Frequency&#160;Missing&#160;=&#160;1</th>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Statistics for Table of Lot_Shape_2 by Bonus</p>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Chi-Square Tests">
<caption aria-label="Chi-Square Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">Prob</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Chi-Square</th>
<td class="r data">1</td>
<td class="r data">37.2807</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio Chi-Square</th>
<td class="r data">1</td>
<td class="r data">34.4226</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Continuity Adj. Chi-Square</th>
<td class="r data">1</td>
<td class="r data">35.1587</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Mantel-Haenszel Chi-Square</th>
<td class="r data">1</td>
<td class="r data">37.1561</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Phi Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data" style="white-space: nowrap">-0.3531</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Contingency Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.3330</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Cramer&apos;s V</th>
<td class="r data">&#160;</td>
<td class="r data" style="white-space: nowrap">-0.3531</td>
<td class="r data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Fisher&apos;s Exact Test">
<caption aria-label="Fisher&apos;s Exact Test"></caption>
<colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">Fisher&apos;s Exact Test</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Cell (1,1) Frequency (F)</th>
<td class="r data">62</td>
</tr>
<tr>
<th class="rowheader" scope="row">Left-sided Pr &lt;= F</th>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Right-sided Pr &gt;= F</th>
<td class="r data">1.0000</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Table Probability (P)</th>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Two-sided Pr &lt;= P</th>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Relative Risk Estimates">
<caption aria-label="Relative Risk Estimates"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Odds Ratio and Relative Risks</th>
</tr>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" colspan="2" scope="colgroup">95%&#160;Confidence&#160;Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Odds Ratio</th>
<th class="r data">0.1347</th>
<td class="r data">0.0664</td>
<td class="r data">0.2735</td>
</tr>
<tr>
<th class="rowheader" scope="row">Relative Risk (Column 1)</th>
<th class="r data">0.7116</th>
<td class="r data">0.6137</td>
<td class="r data">0.8251</td>
</tr>
<tr>
<th class="rowheader" scope="row">Relative Risk (Column 2)</th>
<th class="r data">5.2821</th>
<td class="r data">2.9002</td>
<td class="r data">9.6202</td>
</tr>
</tbody>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Sample Size = 299<br/>Frequency Missing = 1</p>
</div>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Expected</div>
<div class="t">Cell Chi-Square</div>
<div class="t">Row Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Fireplaces&#160;by&#160;Bonus</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Fireplaces(Number of fireplaces)</th>
<th class="c b header" colspan="3" scope="colgroup">Bonus(Sale Price &gt; $175,000)</th>
</tr>
<tr>
<th class="r header" scope="col">Not Bonus Eligible</th>
<th class="r header" scope="col">Bonus Eligible</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r t rowheader" scope="row">0</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">177</div>
<div class="r t">165.75</div>
<div class="r t">0.7636</div>
<div class="r t">90.77</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">18</div>
<div class="r t">29.25</div>
<div class="r t">4.3269</div>
<div class="r t">9.23</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">195</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">1</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">68</div>
<div class="r t">79.05</div>
<div class="r t">1.5446</div>
<div class="r t">73.12</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">25</div>
<div class="r t">13.95</div>
<div class="r t">8.7529</div>
<div class="r t">26.88</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">93</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">2</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">10</div>
<div class="r t">10.2</div>
<div class="r t">0.0039</div>
<div class="r t">83.33</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">2</div>
<div class="r t">1.8</div>
<div class="r t">0.0222</div>
<div class="r t">16.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">12</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">255</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">45</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">300</div>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Statistics for Table of Fireplaces by Bonus</p>
</div>
<div id="IDX5" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Chi-Square Tests">
<caption aria-label="Chi-Square Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">Prob</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Chi-Square</th>
<td class="r data">2</td>
<td class="r data">15.4141</td>
<td class="r data">0.0004</td>
</tr>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio Chi-Square</th>
<td class="r data">2</td>
<td class="r data">14.4859</td>
<td class="r data">0.0007</td>
</tr>
<tr>
<th class="rowheader" scope="row">Mantel-Haenszel Chi-Square</th>
<td class="r data">1</td>
<td class="r data">10.7458</td>
<td class="r data">0.0010</td>
</tr>
<tr>
<th class="rowheader" scope="row">Phi Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.2267</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Contingency Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.2211</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Cramer&apos;s V</th>
<td class="r data">&#160;</td>
<td class="r data">0.2267</td>
<td class="r data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Sample Size = 300</p>
</div>
</div>
</div>
</body>
</html>




* Chi-Square statistic is less than .0001, you reject the null hypothesis at the 0.05 level and conclude that there is evidence of an association between Lot_Shape_2 and Bonus. 
* The Cramer's V value of -0.3531 indicates that the association detected with the chi-square test is relatively weak.
* the odds ratio, refer to the crosstabulation table at the beginning of the output. The top row (Irregular) is the numerator of the ratio, while the bottom row (Regular) is the denominator. The interpretation is stated in relation to the left column of the crosstabulation table (Not Bonus Eligible).
* The value of 0.1347 says that an irregular lot has about 13.5% of the odds of not being bonus eligible, compared with a regular lot. This is equivalent to saying that a regular lot has about 13.5% of the odds of being bonus eligible, compared with an irregular lot. We can interpret the reciprocal of the odds ratio, 1/0.1347=7.423 similarly. The odds of being bonus eligible are more than seven times the odds for homes with irregular lot shapes than regular lot shapes.

#### The Mantel-Haenszel Chi-Square Test

* For ordinal associations, the Mantel-Haenszel chi-square test is a more powerful test than the Pearson chi-square test. 
* When two variables have an ordinal association, an increase in the value of one variable tends to be associated with an increase or decrease in the value of the other variable. 


#### Demo: Detecting Ordinal Associations Using PROC FREQ

we use PROC FREQ to test whether an ordinal association exists between Bonus and Fireplaces.


```sas
ods graphics off;
proc freq data=STAT1.ameshousing3;
    tables Fireplaces*Bonus / chisq measures cl;
    format Bonus bonusfmt.;
    title 'Ordinal Association between FIREPLACES and BONUS?';
run;

ods graphics on;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">Ordinal Association between FIREPLACES and BONUS?</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The FREQ Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Percent</div>
<div class="t">Row Pct</div>
<div class="t">Col Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Fireplaces&#160;by&#160;Bonus</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Fireplaces(Number of fireplaces)</th>
<th class="c b header" colspan="3" scope="colgroup">Bonus(Sale Price &gt; $175,000)</th>
</tr>
<tr>
<th class="r header" scope="col">Not Bonus Eligible</th>
<th class="r header" scope="col">Bonus Eligible</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r t rowheader" scope="row">0</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">177</div>
<div class="r t">59.00</div>
<div class="r t">90.77</div>
<div class="r t">69.41</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">18</div>
<div class="r t">6.00</div>
<div class="r t">9.23</div>
<div class="r t">40.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">195</div>
<div class="r t">65.00</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">1</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">68</div>
<div class="r t">22.67</div>
<div class="r t">73.12</div>
<div class="r t">26.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">25</div>
<div class="r t">8.33</div>
<div class="r t">26.88</div>
<div class="r t">55.56</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">93</div>
<div class="r t">31.00</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">2</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">10</div>
<div class="r t">3.33</div>
<div class="r t">83.33</div>
<div class="r t">3.92</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">2</div>
<div class="r t">0.67</div>
<div class="r t">16.67</div>
<div class="r t">4.44</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">12</div>
<div class="r t">4.00</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">255</div>
<div class="r t">85.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">45</div>
<div class="r t">15.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">300</div>
<div class="r t">100.00</div>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Statistics for Table of Fireplaces by Bonus</p>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Chi-Square Tests">
<caption aria-label="Chi-Square Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">Prob</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Chi-Square</th>
<td class="r data">2</td>
<td class="r data">15.4141</td>
<td class="r data">0.0004</td>
</tr>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio Chi-Square</th>
<td class="r data">2</td>
<td class="r data">14.4859</td>
<td class="r data">0.0007</td>
</tr>
<tr>
<th class="rowheader" scope="row">Mantel-Haenszel Chi-Square</th>
<td class="r data">1</td>
<td class="r data">10.7458</td>
<td class="r data">0.0010</td>
</tr>
<tr>
<th class="rowheader" scope="row">Phi Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.2267</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Contingency Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.2211</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Cramer&apos;s V</th>
<td class="r data">&#160;</td>
<td class="r data">0.2267</td>
<td class="r data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Measures of Association">
<caption aria-label="Measures of Association"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">ASE</th>
<th class="c b header" colspan="2" scope="colgroup">95%<br/>Confidence Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Gamma</th>
<td class="r data">0.4964</td>
<td class="r data">0.1111</td>
<td class="r data">0.2786</td>
<td class="r data">0.7143</td>
</tr>
<tr>
<th class="rowheader" scope="row">Kendall&apos;s Tau-b</th>
<td class="r data">0.2072</td>
<td class="r data">0.0585</td>
<td class="r data">0.0926</td>
<td class="r data">0.3218</td>
</tr>
<tr>
<th class="rowheader" scope="row">Stuart&apos;s Tau-c</th>
<td class="r data">0.1449</td>
<td class="r data">0.0433</td>
<td class="r data">0.0600</td>
<td class="r data">0.2298</td>
</tr>
<tr>
<th class="rowheader" scope="row">Somers&apos; D C|R</th>
<td class="r data">0.1510</td>
<td class="r data">0.0451</td>
<td class="r data">0.0626</td>
<td class="r data">0.2395</td>
</tr>
<tr>
<th class="rowheader" scope="row">Somers&apos; D R|C</th>
<td class="r data">0.2842</td>
<td class="r data">0.0786</td>
<td class="r data">0.1301</td>
<td class="r data">0.4383</td>
</tr>
<tr>
<th class="rowheader" scope="row">Pearson Correlation</th>
<td class="r data">0.1896</td>
<td class="r data">0.0591</td>
<td class="r data">0.0737</td>
<td class="r data">0.3054</td>
</tr>
<tr>
<th class="rowheader" scope="row">Spearman Correlation</th>
<td class="r data">0.2107</td>
<td class="r data">0.0594</td>
<td class="r data">0.0943</td>
<td class="r data">0.3272</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lambda Asymmetric C|R</th>
<td class="r data">0.0000</td>
<td class="r data">0.0000</td>
<td class="r data">0.0000</td>
<td class="r data">0.0000</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lambda Asymmetric R|C</th>
<td class="r data">0.0667</td>
<td class="r data">0.0603</td>
<td class="r data">0.0000</td>
<td class="r data">0.1849</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lambda Symmetric</th>
<td class="r data">0.0467</td>
<td class="r data">0.0424</td>
<td class="r data">0.0000</td>
<td class="r data">0.1298</td>
</tr>
<tr>
<th class="rowheader" scope="row">Uncertainty Coefficient C|R</th>
<td class="r data">0.0571</td>
<td class="r data">0.0298</td>
<td class="r data">0.0000</td>
<td class="r data">0.1156</td>
</tr>
<tr>
<th class="rowheader" scope="row">Uncertainty Coefficient R|C</th>
<td class="r data">0.0313</td>
<td class="r data">0.0167</td>
<td class="r data">0.0000</td>
<td class="r data">0.0640</td>
</tr>
<tr>
<th class="rowheader" scope="row">Uncertainty Coefficient Symmetric</th>
<td class="r data">0.0404</td>
<td class="r data">0.0213</td>
<td class="r data">0.0000</td>
<td class="r data">0.0823</td>
</tr>
</tbody>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Sample Size = 300</p>
</div>
</div>
</div>
</body>
</html>




* The Mantel-Haenszel Chi-Square suggest an odinal association between Bonus and Fireplaces.


#### Practice: Using PROC FREQ to Perform Tests and Measures of Association
The insurance company wants to determine whether a vehicle's safety score is associated with either the region in which it was manufactured or the vehicle's size. The stat1.safety data set contains the data about vehicle safety.

1. Use PROC FREQ to create the crosstabulation of the variables Region by Unsafe. Along with the default output, generate the expected frequencies, the chi-square test of association, and the odds ratio. To clearly identify the values of Unsafe, create and apply a temporary format. Submit the code and view the results.


```sas
proc format; 
   value safefmt 0='Average or Above'
                 1='Below Average';
run;

proc freq data=STAT1.safety;
   tables Region*Unsafe / expected chisq relrisk;
   format Unsafe safefmt.;
   title "Association between Unsafe and Region";
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">Association between Unsafe and Region</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The FREQ Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Expected</div>
<div class="t">Percent</div>
<div class="t">Row Pct</div>
<div class="t">Col Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Region&#160;by&#160;Unsafe</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Region</th>
<th class="c b header" colspan="3" scope="colgroup">Unsafe</th>
</tr>
<tr>
<th class="r header" scope="col">Average or Above</th>
<th class="r header" scope="col">Below Average</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="t rowheader" scope="row">Asia</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">20</div>
<div class="r t">24.063</div>
<div class="r t">20.83</div>
<div class="r t">57.14</div>
<div class="r t">30.30</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">15</div>
<div class="r t">10.938</div>
<div class="r t">15.63</div>
<div class="r t">42.86</div>
<div class="r t">50.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">35</div>
<div class="r t">&#160;</div>
<div class="r t">36.46</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">N America</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">46</div>
<div class="r t">41.938</div>
<div class="r t">47.92</div>
<div class="r t">75.41</div>
<div class="r t">69.70</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">15</div>
<div class="r t">19.063</div>
<div class="r t">15.63</div>
<div class="r t">24.59</div>
<div class="r t">50.00</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">61</div>
<div class="r t">&#160;</div>
<div class="r t">63.54</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">66</div>
<div class="r t">68.75</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">30</div>
<div class="r t">31.25</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">96</div>
<div class="r t">100.00</div>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Statistics for Table of Region by Unsafe</p>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Chi-Square Tests">
<caption aria-label="Chi-Square Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">Prob</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Chi-Square</th>
<td class="r data">1</td>
<td class="r data">3.4541</td>
<td class="r data">0.0631</td>
</tr>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio Chi-Square</th>
<td class="r data">1</td>
<td class="r data">3.3949</td>
<td class="r data">0.0654</td>
</tr>
<tr>
<th class="rowheader" scope="row">Continuity Adj. Chi-Square</th>
<td class="r data">1</td>
<td class="r data">2.6562</td>
<td class="r data">0.1031</td>
</tr>
<tr>
<th class="rowheader" scope="row">Mantel-Haenszel Chi-Square</th>
<td class="r data">1</td>
<td class="r data">3.4181</td>
<td class="r data">0.0645</td>
</tr>
<tr>
<th class="rowheader" scope="row">Phi Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data" style="white-space: nowrap">-0.1897</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Contingency Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.1864</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Cramer&apos;s V</th>
<td class="r data">&#160;</td>
<td class="r data" style="white-space: nowrap">-0.1897</td>
<td class="r data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Fisher&apos;s Exact Test">
<caption aria-label="Fisher&apos;s Exact Test"></caption>
<colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">Fisher&apos;s Exact Test</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Cell (1,1) Frequency (F)</th>
<td class="r data">20</td>
</tr>
<tr>
<th class="rowheader" scope="row">Left-sided Pr &lt;= F</th>
<td class="r data">0.0525</td>
</tr>
<tr>
<th class="rowheader" scope="row">Right-sided Pr &gt;= F</th>
<td class="r data">0.9809</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Table Probability (P)</th>
<td class="r data">0.0334</td>
</tr>
<tr>
<th class="rowheader" scope="row">Two-sided Pr &lt;= P</th>
<td class="r data">0.0718</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Relative Risk Estimates">
<caption aria-label="Relative Risk Estimates"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Odds Ratio and Relative Risks</th>
</tr>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" colspan="2" scope="colgroup">95%&#160;Confidence&#160;Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Odds Ratio</th>
<th class="r data">0.4348</th>
<td class="r data">0.1790</td>
<td class="r data">1.0562</td>
</tr>
<tr>
<th class="rowheader" scope="row">Relative Risk (Column 1)</th>
<th class="r data">0.7578</th>
<td class="r data">0.5499</td>
<td class="r data">1.0443</td>
</tr>
<tr>
<th class="rowheader" scope="row">Relative Risk (Column 2)</th>
<th class="r data">1.7429</th>
<td class="r data">0.9733</td>
<td class="r data">3.1210</td>
</tr>
</tbody>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Sample Size = 96</p>
</div>
</div>
</div>
</body>
</html>




2. For the cars made in Asia, what percentage had a Below Average safety score?
Solution:
Region is a row variable, so look at the Row Pct value in the Below Average cell of the Asia row. Of the cars made in Asia, 42.86% have a Below Average safety score.

3. For the cars with an Average or Above safety score, what percentage was made in North America?
Solution:
Look at the Col Pct value in the Average or Above cell of the N America row. Of the cars with an Average or Above safety score, 69.70% were made in North America.

4. Do you see a statistically significant (at the 0.05 level) association between Region and Unsafe?
Solution:
The association is not statistically significant at the 0.05 alpha level. The p-value is 0.0631.

5. What does the odds ratio compare? What does this suggest about the difference in odds between Asian and North American cars?
Solution:
The odds ratio compares the odds of Below Average safety for North America versus Asia. The odds ratio of 0.4348 means that cars made in North America have 56.52% lower odds for being unsafe than cars made in Asia.

Note: Recall that the odds ratios in the Estimates of Relative Risk table **are calculated by comparing row1/row2 for column1**. In this problem, this comparison is Asia to N America and the outcome is Average or Above in safety. The value 0.4348 is interpreted as the odds of an Average or Above car made in Asia is 0.4348 times the odds for American-made cars. If you want to compare N America to Asia, still using Average or Above for safety, the odds ratio would be the inverse of 0.4348, or approximately 2.3. This is interpreted as cars made in North America have 2.3 times the odds for being safe than cars made in Asia. This single inversion would also create the odds ratio for comparing Asia to N America but Below Average in safety. If you want to compare N America to Asia using Below Average in safety, you invert your odds ratio twice and return to the value 0.4348.

6. Write another PROC FREQ step to create the crosstabulation of the variables Size and Unsafe. Along with the default output, generate the measures of ordinal association. Format the values of Unsafe. Submit the code and view the results.


```sas
proc freq data=STAT1.safety;
   tables Size*Unsafe / chisq measures cl;
   format Unsafe safefmt.;
   title "Association between Unsafe and Size";
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">Association between Unsafe and Size</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The FREQ Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<table role="presentation">
<tr>
<td class="c t"><table class="table" style="border-spacing: 0">
<colgroup><col/></colgroup>
<tbody>
<tr>
<th class="t header" scope="col">
<div class="stacked-cell">
<div class="t">Frequency</div>
<div class="t">Percent</div>
<div class="t">Row Pct</div>
<div class="t">Col Pct</div>
</div>
</th>
</tr>
</tbody>
</table>
</td>
<td><table class="table" style="border-spacing: 0" aria-label="Cross-Tabular Freq Table">
<caption aria-label="Cross-Tabular Freq Table"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c header" colspan="4" scope="colgroup">Table&#160;of&#160;Size&#160;by&#160;Unsafe</th>
</tr>
<tr>
<th class="c b header" rowspan="2" scope="col">Size</th>
<th class="c b header" colspan="3" scope="colgroup">Unsafe</th>
</tr>
<tr>
<th class="r header" scope="col">Average or Above</th>
<th class="r header" scope="col">Below Average</th>
<th class="r header" scope="col">Total</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r t rowheader" scope="row">1</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">12</div>
<div class="r t">12.50</div>
<div class="r t">34.29</div>
<div class="r t">18.18</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">23</div>
<div class="r t">23.96</div>
<div class="r t">65.71</div>
<div class="r t">76.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">35</div>
<div class="r t">36.46</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">2</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">24</div>
<div class="r t">25.00</div>
<div class="r t">82.76</div>
<div class="r t">36.36</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">5</div>
<div class="r t">5.21</div>
<div class="r t">17.24</div>
<div class="r t">16.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">29</div>
<div class="r t">30.21</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="r t rowheader" scope="row">3</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">30</div>
<div class="r t">31.25</div>
<div class="r t">93.75</div>
<div class="r t">45.45</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">2</div>
<div class="r t">2.08</div>
<div class="r t">6.25</div>
<div class="r t">6.67</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">32</div>
<div class="r t">33.33</div>
<div class="r t">&#160;</div>
<div class="r t">&#160;</div>
</div>
</td>
</tr>
<tr>
<th class="t rowheader" scope="row">Total</th>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">66</div>
<div class="r t">68.75</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">30</div>
<div class="r t">31.25</div>
</div>
</td>
<td class="r t data">
<div class="stacked-cell">
<div class="r t">96</div>
<div class="r t">100.00</div>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Statistics for Table of Size by Unsafe</p>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Chi-Square Tests">
<caption aria-label="Chi-Square Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">Prob</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Chi-Square</th>
<td class="r data">2</td>
<td class="r data">31.3081</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio Chi-Square</th>
<td class="r data">2</td>
<td class="r data">32.6199</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Mantel-Haenszel Chi-Square</th>
<td class="r data">1</td>
<td class="r data">27.7098</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Phi Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.5711</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Contingency Coefficient</th>
<td class="r data">&#160;</td>
<td class="r data">0.4959</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Cramer&apos;s V</th>
<td class="r data">&#160;</td>
<td class="r data">0.5711</td>
<td class="r data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Measures of Association">
<caption aria-label="Measures of Association"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="b header" scope="col">Statistic</th>
<th class="r b header" scope="col">Value</th>
<th class="r b header" scope="col">ASE</th>
<th class="c b header" colspan="2" scope="colgroup">95%<br/>Confidence Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Gamma</th>
<td class="r data" style="white-space: nowrap">-0.8268</td>
<td class="r data">0.0796</td>
<td class="r data" style="white-space: nowrap">-0.9829</td>
<td class="r data" style="white-space: nowrap">-0.6707</td>
</tr>
<tr>
<th class="rowheader" scope="row">Kendall&apos;s Tau-b</th>
<td class="r data" style="white-space: nowrap">-0.5116</td>
<td class="r data">0.0726</td>
<td class="r data" style="white-space: nowrap">-0.6540</td>
<td class="r data" style="white-space: nowrap">-0.3693</td>
</tr>
<tr>
<th class="rowheader" scope="row">Stuart&apos;s Tau-c</th>
<td class="r data" style="white-space: nowrap">-0.5469</td>
<td class="r data">0.0866</td>
<td class="r data" style="white-space: nowrap">-0.7166</td>
<td class="r data" style="white-space: nowrap">-0.3771</td>
</tr>
<tr>
<th class="rowheader" scope="row">Somers&apos; D C|R</th>
<td class="r data" style="white-space: nowrap">-0.4114</td>
<td class="r data">0.0660</td>
<td class="r data" style="white-space: nowrap">-0.5408</td>
<td class="r data" style="white-space: nowrap">-0.2819</td>
</tr>
<tr>
<th class="rowheader" scope="row">Somers&apos; D R|C</th>
<td class="r data" style="white-space: nowrap">-0.6364</td>
<td class="r data">0.0860</td>
<td class="r data" style="white-space: nowrap">-0.8049</td>
<td class="r data" style="white-space: nowrap">-0.4678</td>
</tr>
<tr>
<th class="rowheader" scope="row">Pearson Correlation</th>
<td class="r data" style="white-space: nowrap">-0.5401</td>
<td class="r data">0.0764</td>
<td class="r data" style="white-space: nowrap">-0.6899</td>
<td class="r data" style="white-space: nowrap">-0.3903</td>
</tr>
<tr>
<th class="rowheader" scope="row">Spearman Correlation</th>
<td class="r data" style="white-space: nowrap">-0.5425</td>
<td class="r data">0.0769</td>
<td class="r data" style="white-space: nowrap">-0.6932</td>
<td class="r data" style="white-space: nowrap">-0.3917</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lambda Asymmetric C|R</th>
<td class="r data">0.3667</td>
<td class="r data">0.1569</td>
<td class="r data">0.0591</td>
<td class="r data">0.6743</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lambda Asymmetric R|C</th>
<td class="r data">0.2951</td>
<td class="r data">0.0892</td>
<td class="r data">0.1203</td>
<td class="r data">0.4699</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lambda Symmetric</th>
<td class="r data">0.3187</td>
<td class="r data">0.0970</td>
<td class="r data">0.1286</td>
<td class="r data">0.5088</td>
</tr>
<tr>
<th class="rowheader" scope="row">Uncertainty Coefficient C|R</th>
<td class="r data">0.2735</td>
<td class="r data">0.0836</td>
<td class="r data">0.1096</td>
<td class="r data">0.4374</td>
</tr>
<tr>
<th class="rowheader" scope="row">Uncertainty Coefficient R|C</th>
<td class="r data">0.1551</td>
<td class="r data">0.0490</td>
<td class="r data">0.0590</td>
<td class="r data">0.2512</td>
</tr>
<tr>
<th class="rowheader" scope="row">Uncertainty Coefficient Symmetric</th>
<td class="r data">0.1979</td>
<td class="r data">0.0615</td>
<td class="r data">0.0773</td>
<td class="r data">0.3186</td>
</tr>
</tbody>
</table>
</div>
<div class="proc_note_group">
<p class="c proctitle">Sample Size = 96</p>
</div>
</div>
</div>
</body>
</html>




7. What statistic do you use to detect an ordinal association between Size and Unsafe?
Solution:
The Mantel-Haenszel chi-square detects an ordinal association.

8. Do you reject or fail to reject the null hypothesis at the 0.05 level?
Solution:
You reject the null hypothesis at the 0.05 level.

9. What is the strength of the ordinal association between Size and Unsafe?
Solution:
The Spearman Correlation is -0.5425.

10. What is the 95% confidence interval around the statistic that measures the strength of the ordinal association?
Solution:
The confidence interval is (-0.6932, -0.3917).

### Introduction to Logistic Regression

* model the relationship between a binary response and a set of predictor variables.

#### Modeling a Binary Response

* the mean of the response is the probability of a success.
* we want to model the probability of both levels of the response.
* for binary data, the mean of the response is the probability of a success. 
* we want to model the probability of both levels of the response. 

#### Demo: Fitting a Binary Logistic Regression Model Using PROC LOGISTIC

Let's fit a binary logistic regression model in PROC LOGISTIC to characterize the relationship between the continuous variable Basement_Area and our categorical response, Bonus.


```sas
ods graphics on;
proc logistic data=STAT1.ameshousing3 alpha=0.05
              plots(only)=(effect oddsratio);
    model Bonus(event='1')=Basement_Area / clodds=pl; /*event='1' bonus elegible home*/
    title 'LOGISTIC MODEL (1):Bonus=Basement_Area';
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">LOGISTIC MODEL (1):Bonus=Basement_Area</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The LOGISTIC Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Model Information">
<caption aria-label="Model Information"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Model Information</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Data Set</th>
<td class="data">STAT1.AMESHOUSING3</td>
<td class="data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Response Variable</th>
<td class="data">Bonus</td>
<td class="data">Sale Price &gt; $175,000</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Response Levels</th>
<td class="data">2</td>
<td class="data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Model</th>
<td class="data">binary logit</td>
<td class="data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Optimization Technique</th>
<td class="data">Fisher&apos;s scoring</td>
<td class="data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Observations Summary">
<caption aria-label="Observations Summary"></caption>
<colgroup><col/><col/></colgroup>
<tbody>
<tr>
<th class="rowheader" scope="row">Number of Observations Read</th>
<td class="r data">300</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Observations Used</th>
<td class="r data">300</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Response Profile">
<caption aria-label="Response Profile"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Response Profile</th>
</tr>
<tr>
<th class="r b header" scope="col">Ordered<br/>Value</th>
<th class="b header" scope="col">Bonus</th>
<th class="r b header" scope="col">Total<br/>Frequency</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="data">0</td>
<td class="r data">255</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="data">1</td>
<td class="r data">45</td>
</tr>
</tbody>
</table>
<div class="proc_note_group">
<p class="c proctitle">Probability modeled is Bonus=&apos;1&apos;.</p>
</div>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Convergence Status">
<caption aria-label="Convergence Status"></caption>
<colgroup><col/></colgroup>
<thead>
<tr>
<th class="c b header" scope="col">Model Convergence Status</th>
</tr>
</thead>
<tbody>
<tr>
<td class="c data">Convergence criterion (GCONV=1E-8) satisfied.</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Fit Statistics">
<caption aria-label="Fit Statistics"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Model Fit Statistics</th>
</tr>
<tr>
<th class="b header" scope="col">Criterion</th>
<th class="r b header" scope="col">Intercept Only</th>
<th class="r b header" scope="col">Intercept and Covariates</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">AIC</th>
<td class="r data">255.625</td>
<td class="r data">161.838</td>
</tr>
<tr>
<th class="rowheader" scope="row">SC</th>
<td class="r data">259.329</td>
<td class="r data">169.246</td>
</tr>
<tr>
<th class="rowheader" scope="row">-2 Log L</th>
<td class="r data">253.625</td>
<td class="r data">157.838</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX5" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Global Tests">
<caption aria-label="Global Tests"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Testing Global Null Hypothesis: BETA=0</th>
</tr>
<tr>
<th class="b header" scope="col">Test</th>
<th class="r b header" scope="col">Chi-Square</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio</th>
<td class="r data">95.7870</td>
<td class="r data">1</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Score</th>
<td class="r data">65.5624</td>
<td class="r data">1</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Wald</th>
<td class="r data">48.0617</td>
<td class="r data">1</td>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX6" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Parameter Estimates">
<caption aria-label="Parameter Estimates"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="6" scope="colgroup">Analysis of Maximum Likelihood Estimates</th>
</tr>
<tr>
<th class="b header" scope="col">Parameter</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Estimate</th>
<th class="r b header" scope="col">Standard<br/>Error</th>
<th class="r b header" scope="col">Wald<br/>Chi-Square</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Intercept</th>
<td class="r data">1</td>
<td class="r data" style="white-space: nowrap">-9.7854</td>
<td class="r data">1.2896</td>
<td class="r data">57.5758</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Basement_Area</th>
<td class="r data">1</td>
<td class="r data">0.00739</td>
<td class="r data">0.00107</td>
<td class="r data">48.0617</td>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX7" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Association Statistics">
<caption aria-label="Association Statistics"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Association of Predicted Probabilities and Observed Responses</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Percent Concordant</th>
<td class="r data">89.5</td>
<th class="rowheader" scope="row">Somers&apos; D</th>
<td class="r data">0.791</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Discordant</th>
<td class="r data">10.4</td>
<th class="rowheader" scope="row">Gamma</th>
<td class="r data">0.792</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Tied</th>
<td class="r data">0.1</td>
<th class="rowheader" scope="row">Tau-a</th>
<td class="r data">0.202</td>
</tr>
<tr>
<th class="rowheader" scope="row">Pairs</th>
<td class="r data">11475</td>
<th class="rowheader" scope="row">c</th>
<td class="r data">0.896</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX8" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="95% Clodds=PL">
<caption aria-label="95% Clodds=PL"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Odds Ratio Estimates and Profile-Likelihood Confidence Intervals</th>
</tr>
<tr>
<th class="b header" scope="col">Effect</th>
<th class="r b header" scope="col">Unit</th>
<th class="r b header" scope="col">Estimate</th>
<th class="c b header" colspan="2" scope="colgroup">95% Confidence Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Basement_Area</th>
<th class="r data">1.0000</th>
<td class="r data">1.007</td>
<td class="r data">1.005</td>
<td class="r data">1.010</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX9" style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Odds Ratios with 95% Profile-Likelihood Confidence Limits" src="data:image/png;base64,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AAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAAIMAIAAAgwAgAACDACAAFsDnJ6ebviNj4/PpEmTysrK7ujILDlz5kzfvn2trHDjxg13d/eEhIS6GU/KynnGfwEAsFEtXgEHBwdrmqZp2o8//pienr5mzZo7N6zbsX79ek9Pz7i4uLrZXcrKGOO/AADYyJ5T0GVlZTdu3PDz88vPz3dwcDAYDB4eHlOmTFFK5efnDxs2zNXVNTQ09PDhw/r6S5YsadWqla+vb0xMjFJq3759Dz/88J///Gdvb++YmJh3333X29u7d+/ehYWFNa48ePDgiRMnenh4PProo+Xl5VFRUYcOHbr//vstDS8uLi42NjYpKemXX37RtzBhwoTBgwc/88wz5ts3vwm18s3Bi9GV0+8a8Hl05fRvDl60YzIBAH9MtQhwRkaGfgq6devWbdu2feSRRzw9PSsqKjRNu3jx4qlTp06ePLlp06bmzZvn5eUtXbp069atSqkjR45s3rz5+PHjqamp+/fv3717t1Lq2LFjU6ZMOXLkSHR09M2bN9PT05s3b/7111/XuPLhw4ejoqLS0tJycnJ27NixZcuWPn36nDlzpsZBpqSknDt37rHHHnv88cdXrVqlL9y2bdvzzz8fHx9vvn3zm2D7hHxz8OKjr317QWudX1R+QWv96Gvf0mAAgI1qfQq6qqoqLS0tNzc3JiamsrIyOjq6c+fOrVu3/uGHH7KzswcNGvTzzz8PHz48Ly9Pf4m5a9euvXv3+vv7+/r67tq168CBA0qphx566OGHH7733nv9/f3ffvttNze33r17X7t2rcaVBw0aFBUV5e3t3a9fv9zcXOuDjIuLi4qKatas2ZgxY+Lj4ysrK5VSnTt3HjVqVI2DMb8Jtk/IvFWmtTZfAgBAjRxqewWDwdCmTZvJkyevWLFi+fLliYmJX3zxRbt27SZPnqxpWlBQ0OnTpw8fPvyPf/wjPj5+69atTZo0mTNnznvvvWfcwr59+6pvTdM0pVSTJk00TbO+sr6OlbGVlpauXbs2Pz//888/15d888037u7unp6exi2YbH/p0qUmN8F8s5aq/P/SrpkvqVXC/4CYHzswafZh3uzApNnBfNLc3NxsuWKtA6yUunjx4rJly8LDw3Nycnr16tW+ffstW7Zs3br1ySef3LJly08//TR58uQFCxZ069ZN07QhQ4Y88cQTkZGRISEhmzZtysnJCQ8Pt7RlW1Z2cnLKzs4uKytzcnIyuSghIcHX1zc3N7dp06ZKqRkzZsTFxb3++utWtl9SUmJyE8xH5e/vX+NoH2jrdfS//99kiaWVoZTKzs5mfmqLSbMP82YHJs0OtzNp9rwH3KVLl5CQkJkzZ06cOPHrr78OCgrau3fvhAkT0tLS+vbtm5qa2rZt2z59+nzwwQcGg6F79+5z584dM2ZMUFDQ5s2b9VPBltiycnBwcEBAgJeXV1VVlclFcXFx7733nl5fpdTMmTMPHjx49epVK9s3vwm2T8g7zz14yyUAANTIkJycHBYWJj2M+mt5/OoXn3nK0vJvDl58bfqy3Bb3+tw49/FHkx/pG1T3I2xA+PnaDkyafZg3OzBpdrA0aZbaYZSSktJQ/yes/Px8g5nTp0/X8TAe6Rv0Py+6Xt878X9edKW+AADb2fMecH3g6elp/QNZdSZs0izjvwAA2KihvgIGAKBBI8AAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAACCDAAAAIIMAAAAggwAAA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"/>
</div>
</div>
<div id="IDX10" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Predicted Probabilities for Bonus=1 by Basement_Area, with 95% Confidence Limits." src="data:image/png;base64,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lJ+f/8Ybb7D9ERER4ouD27dvJ6Lz588fOXIkJydn1apVbM7L5cuXP/30041OALlmzZr58+c//vjj+fn5p06dmjp16vz581kq6T799NNDhw59++23Tl2RR3Xr1k1KYSQeBuATCMAAcjgG4J07d86cOVMMwHv37h0/fnx2djabkHLs2LEVFRUcx127do1NERwbG9ujR4/ffvvNMcMff/wxLS1t9OjRMTExb775JlsNolG///57t27dbrnllnbt2pWUlBQXFx88eHDmzJkNj7xx48azzz776aef3nvvvZGRke3bt7/33nt/+eUXNkPFzz//zJZnmDFjBpsp88SJE3369KlXwtDQ0NLS0uTk5KVLl7IrIqItW7YkJCR06dLl6NGj4un27t07YMCAiIiIefPmsRp8oxkS0dGjR0eMGBEeHj5p0qS8vLxG0zZPvL0nTpzo3bv3008/HRkZOWrUqF9//XXo0KHh4eEvv/yy42HiU8jPz3/iiSciIyOjoqJeffXVRqd0BvAOBGAAOZKSkoxG4+XLl4nou+++e/HFF1UqFVvhbt++fePHjxeP/OWXX9i6tjExMTk5OeHh4efOnZs1a9Zzzz3nmKFjJOjbt29hYSGLQyqVKjo6OjIyct68eWVlZUSUkJCQm5t77dq1GzduREdHv/baa0uWLGm0kD///HNsbOzEiRMbfnT9+vVZs2a99tprv//+e6dOnR544AG2v2EJq6urw8PDi4qK2FJCRJSfn//II498/PHHhw8fZus+sQynT5/+wgsvXLlyxWQyvfTSS01leOPGjcmTJz/00EO///77nDlzfvzxx6bSSnThwoUePXrk5uZaLJa5c+euX79+3759b775puP82+JTOH369IEDB86dO5eZmXn69OnKykqnzgXgTpiKEkCeadOm/ec//zl9+nTnzp0FQViwYMHrr79uMBgiIyMtFsupU6d69uwpCEJJSQn703/8+PFbb72VpT19+nTHjh0dczt79mxYWNgvv/xSVlZ2//33E1FBQYH46dWrV6dMmfL3v/+d/fjAAw+Eh4cvX748Ly9v/PjxpaWlKSkpcXFxjvMsCoLw73//e9y4cY0WfuPGjTNnzmTbNTU1Op2urKysqRKyACxe0XvvvTdnzhz20S+//JKYmMgynDRpEtt5+fLlmJiYpi75ww8/ZEsTOhamYVoR+4eIuPwf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"/>
</div>
</div>
</div>
</div>
</body>
</html>




* The `PLOTS=` option requests only the EFFECT and ODDSRATIO plots. 
* The `ALPHA=` option requests confidence intervals for each parameter estimate.
* The response variable Bonus, and in parentheses, `EVENT=` specifies the event category for the binary response. PROC LOGISTIC then models the probability of the event category you specify. 
* use the `CLODDS=` to compute confidence intervals for the odds ratios of all predictor variables. `PL` for profile likelihood, `WALD`, or `BOTH`. 
* Profile-likelihood confidence intervals are desirable for small sample sizes. 
* The `CLODDS=` option also enables the production of the odds ratio plot that's specified in the PLOTS= option.

**Conclustions**
* Always check to see that the convergence criterion is satisfied.
* The AIC, SC, and -2 Log L are goodness-of-fit measures. These statistics measure relative fit and are used only to compare models. They do not measure absolute fit of any single model. Smaller values for all these measures indicate better fit. However, -2 Log L can be reduced by simply adding more regression parameters to the model. Therefore, it's not used to compare the fit of models that use different numbers of parameters except for comparisons of nested models using likelihood ratio tests. AIC adjusts for the number of predictor variables, and SC adjusts for the number of predictor variables and the number of observations. SC uses a bigger penalty for extra variables, and therefore, favors more parsimonious models.
* The Global Tests table, Testing Global Null Hypothesis: BETA=0, provides three statistics to test the null hypothesis that all regression coefficients of the model are 0. A significant pvalue for these tests provides evidence that at least one of the regression coefficients for a predictor variable is significantly different from 0. 
* The Parameter Estimates table, Analysis of Maximum Likelihood Estimates, lists the estimated model parameters, their standard errors, Wald Chi-Square values, and p-values. The parameter estimates are the estimated coefficients of the fitted logistic regression model. For this example, the logistic regression equation is logit(p-hat) = -9.7854 (0.00739) * Basement_Area.
* The Wald Chi-Square and its associated p-value tests whether the parameter estimate is significantly different from 0. The p-value for the variable Basement_Area is significant at the 0.05 alpha level.
* The estimated model is displayed on the probability scale in the effect plot. You can see the sigmoidal shape of the estimated probability curve and that the probability of being bonus eligible increases as the basement area increases.


#### Interpreting the Odds Ratio

...


#### Comparing Pairs to Assess the Fit of a Logistic Regression Model
...
* In general, higher percentages of concordant pairs and lower percentages of discordant and tied pairs indicate a more desirable model.

#### Practice: Using PROC LOGISTIC to Perform a Binary Logistic Regression Analysis
The insurance company wants to characterize the relationship between a vehicle's weight and its safety rating. The stat1.safety data set contains the data about vehicle safety.

1. Use PROC LOGISTIC to fit a simple logistic regression model with Unsafe as the response variable and Weight as the predictor variable. Use the EVENT= option to model the probability of Below Average safety scores. Request profile likelihood confidence limits, an odds ratio plot, and an effect plot. Submit the code and view the results.


```sas
ods graphics on;
proc logistic data=STAT1.safety plots(only)=(effect oddsratio);
   model Unsafe(event='1')=Weight / clodds=pl;
   title 'LOGISTIC MODEL (1):Unsafe=Weight';
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">LOGISTIC MODEL (1):Unsafe=Weight</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The LOGISTIC Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Model Information">
<caption aria-label="Model Information"></caption>
<colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">Model Information</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Data Set</th>
<td class="data">STAT1.SAFETY</td>
</tr>
<tr>
<th class="rowheader" scope="row">Response Variable</th>
<td class="data">Unsafe</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Response Levels</th>
<td class="data">2</td>
</tr>
<tr>
<th class="rowheader" scope="row">Model</th>
<td class="data">binary logit</td>
</tr>
<tr>
<th class="rowheader" scope="row">Optimization Technique</th>
<td class="data">Fisher&apos;s scoring</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Observations Summary">
<caption aria-label="Observations Summary"></caption>
<colgroup><col/><col/></colgroup>
<tbody>
<tr>
<th class="rowheader" scope="row">Number of Observations Read</th>
<td class="r data">96</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Observations Used</th>
<td class="r data">96</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Response Profile">
<caption aria-label="Response Profile"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Response Profile</th>
</tr>
<tr>
<th class="r b header" scope="col">Ordered<br/>Value</th>
<th class="b header" scope="col">Unsafe</th>
<th class="r b header" scope="col">Total<br/>Frequency</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="data">0</td>
<td class="r data">66</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="data">1</td>
<td class="r data">30</td>
</tr>
</tbody>
</table>
<div class="proc_note_group">
<p class="c proctitle">Probability modeled is Unsafe=1.</p>
</div>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Convergence Status">
<caption aria-label="Convergence Status"></caption>
<colgroup><col/></colgroup>
<thead>
<tr>
<th class="c b header" scope="col">Model Convergence Status</th>
</tr>
</thead>
<tbody>
<tr>
<td class="c data">Convergence criterion (GCONV=1E-8) satisfied.</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Fit Statistics">
<caption aria-label="Fit Statistics"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Model Fit Statistics</th>
</tr>
<tr>
<th class="b header" scope="col">Criterion</th>
<th class="r b header" scope="col">Intercept Only</th>
<th class="r b header" scope="col">Intercept and Covariates</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">AIC</th>
<td class="r data">121.249</td>
<td class="r data">106.764</td>
</tr>
<tr>
<th class="rowheader" scope="row">SC</th>
<td class="r data">123.813</td>
<td class="r data">111.893</td>
</tr>
<tr>
<th class="rowheader" scope="row">-2 Log L</th>
<td class="r data">119.249</td>
<td class="r data">102.764</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX5" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Global Tests">
<caption aria-label="Global Tests"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Testing Global Null Hypothesis: BETA=0</th>
</tr>
<tr>
<th class="b header" scope="col">Test</th>
<th class="r b header" scope="col">Chi-Square</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio</th>
<td class="r data">16.4845</td>
<td class="r data">1</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Score</th>
<td class="r data">13.7699</td>
<td class="r data">1</td>
<td class="r data">0.0002</td>
</tr>
<tr>
<th class="rowheader" scope="row">Wald</th>
<td class="r data">11.5221</td>
<td class="r data">1</td>
<td class="r data">0.0007</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX6" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Parameter Estimates">
<caption aria-label="Parameter Estimates"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="6" scope="colgroup">Analysis of Maximum Likelihood Estimates</th>
</tr>
<tr>
<th class="b header" scope="col">Parameter</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Estimate</th>
<th class="r b header" scope="col">Standard<br/>Error</th>
<th class="r b header" scope="col">Wald<br/>Chi-Square</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Intercept</th>
<td class="r data">1</td>
<td class="r data">3.5422</td>
<td class="r data">1.2601</td>
<td class="r data">7.9023</td>
<td class="r data">0.0049</td>
</tr>
<tr>
<th class="rowheader" scope="row">Weight</th>
<td class="r data">1</td>
<td class="r data" style="white-space: nowrap">-1.3901</td>
<td class="r data">0.4095</td>
<td class="r data">11.5221</td>
<td class="r data">0.0007</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX7" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Association Statistics">
<caption aria-label="Association Statistics"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Association of Predicted Probabilities and Observed Responses</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Percent Concordant</th>
<td class="r data">55.2</td>
<th class="rowheader" scope="row">Somers&apos; D</th>
<td class="r data">0.474</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Discordant</th>
<td class="r data">7.7</td>
<th class="rowheader" scope="row">Gamma</th>
<td class="r data">0.754</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Tied</th>
<td class="r data">37.1</td>
<th class="rowheader" scope="row">Tau-a</th>
<td class="r data">0.206</td>
</tr>
<tr>
<th class="rowheader" scope="row">Pairs</th>
<td class="r data">1980</td>
<th class="rowheader" scope="row">c</th>
<td class="r data">0.737</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX8" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="95% Clodds=PL">
<caption aria-label="95% Clodds=PL"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Odds Ratio Estimates and Profile-Likelihood Confidence Intervals</th>
</tr>
<tr>
<th class="b header" scope="col">Effect</th>
<th class="r b header" scope="col">Unit</th>
<th class="r b header" scope="col">Estimate</th>
<th class="c b header" colspan="2" scope="colgroup">95% Confidence Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Weight</th>
<th class="r data">1.0000</th>
<td class="r data">0.249</td>
<td class="r data">0.102</td>
<td class="r data">0.517</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX9" style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Odds Ratios with 95% Profile-Likelihood Confidence Limits" src="data:image/png;base64,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UlJSevTo4eHh4ePjExcXl56ebn2B3Nzc+Ph4T0/Pjh07rly50vqXXo5WVVZWvv/++/379/fz82vbtm1kZOSiRYvsd20fibNnz+pvhP7www81TXvmmWd8fX3Dw8NffvnlCRMmKKXmz5+vadq5c+dGjBihv1+ppKTE5mNIf/3rX2+99VY3N7eQkJAnn3xS/3SHk0PSNO2uu+5SVm/86datm/rfwlnvzmAkmoMAa5q2fv36AQMGtG3btlOnTnPnztU/O1FUVPTKK69ERUW1adOmQ4cOEydO1N+BZfHggw/efvvtlg9a7Nq1q1u3bj4+PhMmTHD0JiznA+zouGlOB1j/4Eq3bt1atWoVFhaWmJh4+PBh+1034tFZ/+xyYGBgUVGRo700IsAGN9lglcHpYOPy5cvvvPPOPffc06ZNG09PzzvvvHPmzJlnzpy56i4aF2CDgTlz0Gx2VFdX9+abb0ZGRrZq1So4ODghIeHQoUNOznLTBdj6dCsoKHDyjIbZbDaZzeaoqCj7iQEAAE0kKyuL3wEDACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIMBNegAO/XvTlvyCAulRAADQYKHB7eNHDje+jOsGOL+g4A+THrFfXl5ebvM3e+FqmCPX98HKVfWeX3ApnEquz9EcfbBy1VWv++t7CfrixYvSQ8BVMEfAdcGp5PquZY5+fQEGAOAGQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQQIABABBAgAEAEECAAQAQ4GyAR48evW7dOv3rlJSUXr16WVaFhYUVFRXZXP7gwYNPPPGE/XZ27tyZkJBgvSQ7O3vQoEENGHITyFq2QHYANzYOLwDYczbAQ4YM2b17t/51enr6kSNHcnJylFI//PBDaGhoQECAzeV79+794YcfXseBNqmsZcnSQ7iRcXgBwJ6zAY6Li9MDXFxcfOTIkfHjx6enpyuldu7cee+99yql3n777Y4dOwYFBSUnJyurZ7qzZ8/29/ePjo4eN27cmjVrlFIVFRWPPfaYr6/v6NGja2pqEhISvvnmm65duzbRLXRlX+w5O2DS5+3i/jFg0udf7DkrPRwAQPNxNsC/+c1vcnNzS0tLN2/ePHLkyPHjx3/xxRfqlwDv27fvs88+O3DgwNGjR7/++uvt27fr19q2bVtaWtp33323YsWKvXv36gv37t2bkJBw6tSpgoKCTZs2ff7559HR0dnZ2U1x81zZF3vOjn5mc8aRn0vKazKO/Dz6mc00GABuHs4G2GQyDRo0aO/evenp6UlJSffdd9/+/fsrKioyMzMHDhy4devWHTt2hISEBAUFbd261fJi9a5dux599NHw8PA777wzMTFRXzhs2LCEhISAgIDBgwcXFhY2yc36NViw/NBVlwAAblRuzl90yJAhO3fu3LNnz7Jlyzw9PQcPHvzuu+/ecccdHh4eLVq0mDt37iuvvGK58M6dO5VS7u7uV65ccbTBFi1aaJpmsMf8/PwGLb8Wa/p7XfdtGsuqfV2p/9lp1pEzzT+M5tEUU4ZrxKT8KjBNrs9+jry9vZ25YgMCHBcXN2jQoHvvvdfLy0splZCQMGPGjNmzZyulhg8fPmbMmPj4+IiIiLS0tIKCggEDBiilfvvb306dOnXcuHGXLl1av359nz597Dfr4eGRn59fXV3t4eFhsyokJMT+8vn5+fUuv0YTMiqv+zaNvTvp84wjP1svieoZPmFlcw+jKdjM0Zr+Xk0xZbhGTIrra6KHO1xH1zJHDfgccGRkpIeHR1JSkv7t6NGjy8vLhw0bppTq27fv/Pnzx40b16lTp88++2zs2LH6ZWJjY8eOHdu3b9+pU6cOHDjQZDLZbzY8PDw0NNTf39/gufINafbku6+6BABwo2rAM2ClVEFBgeXrdu3aXb582fLtpEmTJk2aZPk2IiIiNjZWKZWcnJycnJyXlzdixIgZM2ZER0fry5VSixYt0r+w/M74pnL/oE7pb41YsPxQ9umSrrf6zZ589/2DOkkPCgDQTBoW4IbauXNnXFycUiogIGDy5MnR0dFNurtGi5oyW2S/9w/qdDNEV+rwAoAra9oAx8bGGr/NykVETXlZegg3Mg4vANjjb0EDACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIIAAAwAggAADACCAAAMAIMBNegAOebdt+8HKVdKjAG5YnF9A0/H2bnPVy7hugB8a+/t6l3+wctUfJj3SzINBgzBHro85+lVgmlzftcwRL0EDACCAAAMAIIAAAwAggAADACCAAAMAIMBkNpujoqKkhwEAwE0kKyuLZ8AAAAggwAAACCDAAAAIcOkAr1279tZbbw0LC3v33XedX4Vm5mguSkpKTFYyMjKkRojz588vXbrUz8/PfhWnkotwNEecR66jrKzsqaeeCg4ODgkJeeutt2zWNuZUMpvNmksqLCxs165dRkbGiRMnOnTocOzYMWdWoZkZzEVxcXF0dLTg2GBx6623PvLIIx4eHjbLOZVch6M54jxyHV9++eULL7yQn5//n//8p0OHDgcPHrSsasSpZDabXfcZ8NatW4cMGdKvX7+IiIjx48dv2LDBmVVoZszFr8KPP/74z3/+03450+c6HM0RXMd99933+uuvBwcHd+vWLTo6+scff7Ssatyp5LoBzs/PDw8P17/u1KlTXl6eM6vQzAzmomXLlsePH/fx8enQocPChQuFBggjnEquj/PIBZWWlh44cCAmJsaypHGnkuv+N6TLly+bTCbLt7W1tc6sQjMzmAtvb++ff/5Z07QffvghISGhZ8+eo0ePlhgjHOJUcn2cR66murr6oYceWrhwYWBgoGVh404l130GHBYWdvr0af3rnJycsLAwZ1ahmV11LkwmU/fu3ceMGWM2m5t7cLgaTqVfC84jF1FWVvbAAw88/PDDDz74oPXyRp5KLvsmrNzcXD8/v4yMjJMnT3bs2PHw4cPOrEIzM5iL1NTU999/v6io6MiRI507d96yZYvgOKFpmv0bfDiVXI39HHEeuY6CgoLBgwfXOwWNOJXMZrPrBljTtI8//rhTp04+Pj6vvfaapmlVVVVdu3YtLS21XwVBjqbpxx9//P3vf9+uXbuwsLBFixZJDxP//+DOqeSy7OeI88h1zJw50/rp6/z586/lVDKbzfwtaAAAmht/CxoAABkEGAAAAQQYAAABBBgAAAEEGAAAAQQYAAABBBgAAAEEGHB17777bvfu3T08PIKDg5988sni4mKbC3z//fcRERHOLLRRVVVl+Ueznp6ePXv2XLNmjcHlCwsL9X9Ye/Lkyfvuu6/hNwXA/yPAgEubM2dOSkpKamrq+fPnd+zYkZ+fP3To0Orq6uu4i/Lyck3TiouLFy1a9NRTTx06dOiqV4mIiNiyZct1HANwEyLAgOs6d+7cG2+8sX79+hEjRvj4+HTr1m39+vWXLl3S/3HsJ5980rFjx86dO2dmZlquYr9Q07Q//elPAQEBgYGB8+fPd/R/Wry8vIYPH96nTx89wJcvX/bz89OfGQ8ePPjMmTNKqdjY2NLSUpPJtH379q5du+pX3LFjR1RUlK+vb0JCwvnz55v0gAA3EgIMuK4dO3Z06dKlb9++liVubm4PPfTQ1q1bc3Jy/vjHP65evXr//v1r167V19a78Msvv9y7d292dvahQ4eOHj1aVlZW776qqqo2btx44MCBfv36KaXc3d1LSko0Tbtw4UK3bt3mz5+vlNq5c6evr6+mae3bt9evVVhYmJSUlJycfPbs2fDw8MnWTg8AAAL6SURBVMcff7zpjgZwgyHAgOsqKiqy/79moaGhhYWFGzduHD58eGxsbFBQ0Isvvqivqnehr69vfn7+/v3727dvv3btWn9/f5sNent7m0wmLy+vp59+etWqVT179rRe27p167Fjxx47dqzeEW7YsCEmJiY+Pt7X1/f111/fvn17SUnJdbjlwE2AAAOu65ZbbsnLy7NZmJeXFxQUdP78+dDQUH1JQECA/kW9CwcMGLBkyZIPPvigQ4cOM2fOrKmpsdmg/jvg5cuXX7lyJS4uTl+oadrbb789cODA4ODgUaNGXb58ud4R5uXlhYeH6197eXkFBQXl5uZe020GbhoEGHBdQ4YMOX369HfffWdZUldXt3bt2pEjR4aGhlr+AfiFCxf0L+pdqJSKj4/fsGFDdnb2wYMHV69eXe++Hn/88b59+/7hD3/Qv12zZs3SpUtfe+21o0ePGrzfKjQ09L///a/+9aVLl86dO+fsvyIHbnoEGHBdgYGBc+fOTUpK2rp1a3l5eXZ29oMPPtiuXbuHH3541KhR27Zt27x5c25u7quvvqpfvt6FO3bsmDVr1k8//dSiRQsvL69WrVo52t3SpUu/+eabf/zjH0qpn376qVevXr179z579uy8efP0t255e3tXVFQUFRVZrjJ69Ojdu3enpaWVlJT8+c9/HjJkiP45JQBXZzabm+y/FwO4DpYvXx4ZGdmqVavg4OCnn35a/+/fmqatW7cuPDy8Y8eOK1euvO222xwtLCsrmz59ekhIiK+v75QpUy5fvmzZcmVlpfrlJWjdV1995ePjc+LEidzc3H79+rVp0yYmJubTTz/19/evqanRNG3y5Mlubm6rVq268847LVfp2bOnj49PfHx8QUFB8xwT4NfObDabzGZzVFSU9I8BAADcRLKysngJGgAAAQQYAAABBBgAAAEEGAAAAQQYAAABBBgAAAEEGAAAAQQYAAABBBgAAAEEGAAAAQQYAAABBBgAAAEEGAAAAW5KqaysLOlhAABwc/k/gdogsztEPFcAAAAASUVORK5CYII="/>
</div>
</div>
<div id="IDX10" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Predicted Probabilities for Unsafe=1 by Weight, with 95% Confidence Limits." src="data:image/png;base64,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xo2vvvqqyXkQt23btmTJkhdffDEvL+/69evTpk1bsmQJ3artvv7668uXL//www/tOiOr6t27d1sK08a3AQgCAQxgCcMAPnbs2IwZM9gAPnfu3Pjx4zMyMui0lOPGjauoqJBIJA8ePGhqalq3bp2vr++jjz5KZydmHT9+PDo6esyYMT4+Phs2bKDPhDDp/v37vXv37tKlS6dOnYqKigoLCy9dujRjxozm7ywtLX399de//vrr+fPne3l5de3adf78+WfOnKFzgJw+fZo+WiAuLo7Ol5mWltavXz+jErq7u5eUlISGhq5atYqeESFk3759AQEBPXr0SE5OZg937ty5wYMHe3p6Lly4kNbgTe6QEJKcnDxy5EgPD4+YmJjc3FyT25rHXt60tLS+ffu++uqrXl5eo0ePPnv27PDhwz08PNauXWv4NvZTyMvLe+mll7y8vLy9vd999129Xt/qsQCsBAEMYIlBgwbpdLp79+4RQn788cfVq1e7uLjQJ+idP39+/Pjx7DvPnDlDnxTr4+OTmZnp4eFx69atmTNnvvHGG4Y7NEyCkJCQ/Px8mkMuLi6dO3f28vJauHBhWVkZISQgICArK+vBgwelpaWdO3d+7733Vq5cabKQp0+f9vX1NTkBcnFx8cyZM99777379+8HBgYuXryYrm9eQq1W6+HhodFo5syZQ9+Tl5f3/PPP7969+8qVK/TpT3SH06dPf+utt3Jycurq6tasWdPSDktLS6dMmfLss8/ev3//qaeeOn78eEvbttGdO3ceffTRrKyshoaGBQsWfPrpp+fPn9+wYYPhLNzsp3Djxo2LFy/eunUrJSXlxo0blZWV7ToWAJcwFSWAZWJjY7/66qsbN250796dYZilS5e+//771dXVXl5eDQ0N169fDw4OZhimqKiIfvWnpqb279+fbnvjxo1HHnnEcG+//vqrSqU6c+ZMWVnZ008/TQhRq9XsqwUFBVOnTp0zZw79cfHixR4eHhs3bszNzR0/fnxJSUl4eLifn9+lS5cM9/nvf/87KirKZOF37tw5Y8YMulxTU6NQKMrKyloqIQ1g9ox27Njx1FNP0ZfOnDnTq1cvusOYmBi68t69ez4+Pi2d8ueff04fUGhYmObbsug/RKqqqgxXsoUxPMTf/va3VatW0eV+/fpdvXq1+adw8eJFf3//I0eO1NbWmrwyAPxI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"/>
</div>
</div>
</div>
</div>
</body>
</html>




2. Do you reject or fail to reject the null hypothesis that all regression coefficients of the model are 0? Solution: The p-value for the Likelihood Ratio test is <.0001, and therefore, the global null hypothesis is rejected.

3. Write the logistic regression equation. Solution:The regression equation is as follows: Logit(Unsafe) = 3.5422 + (-1.3901) * Weight

4. Interpret the odds ratio for Weight. Solution: The odds ratio for Weight (0.249) says that the odds for being unsafe (having a Below Average safety rating) are 75.1% lower for each thousand-pound increase in weight. The confidence interval (0.102 , 0.517) does not contain 1,which indicates that the odds ratio is statistically significant.

#### Logistic Regression with Categorical Predictors
* we can also include several predictors, both continuous and categorical, into our logistic regression model.
* we want to consider a more complex model with many possible predictors to model the relationship jointly, and account for possible interactions between the effects. 


#### Specifying a Parameterization Method

* PROC LOGISTIC does not work directly with the categorical predictor variables in the CLASS statement.
* PROC LOGISTIC uses the design variables, and not the original variables, in model calculations.
* There are various methods of parameterizing the classification variables. 
* Understanding the parameterization method will help you to interpret your results accurately.
* Effect coding is also known as deviation from the mean coding. 
* It compares the effect of each level of the variable to the average effect of all levels.
* β0 is the average value of the logit across all income levels. 
* β1 is the difference between the logit for income level 1, or low income, and the average logit across all income levels. 
* β2 is the difference between the logit for income level 2, or medium income, and the average logit across all income levels.


#### Demo: Fitting a Multiple Logistic Regression Model with Categorical Predictors Using PROC LOGISTIC
we'll fit a multiple logistic regression model that characterizes the relationship between the response Bonus, and the variables Basement_Area, Lot_Shape_2, and Fireplaces.


```sas
ods graphics on;
proc logistic data=STAT1.ameshousing3 plots(only)=(effect oddsratio);
    class Fireplaces(ref='0') Lot_Shape_2(ref='Regular') / param=ref;
    model Bonus(event='1')=Basement_Area Fireplaces Lot_Shape_2 / clodds=pl;
    units Basement_Area=100;
    title 'LOGISTIC MODEL (2):Bonus= Basement_Area Fireplaces Lot_Shape_2';
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">LOGISTIC MODEL (2):Bonus= Basement_Area Fireplaces Lot_Shape_2</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The LOGISTIC Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Model Information">
<caption aria-label="Model Information"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Model Information</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Data Set</th>
<td class="data">STAT1.AMESHOUSING3</td>
<td class="data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Response Variable</th>
<td class="data">Bonus</td>
<td class="data">Sale Price &gt; $175,000</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Response Levels</th>
<td class="data">2</td>
<td class="data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Model</th>
<td class="data">binary logit</td>
<td class="data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Optimization Technique</th>
<td class="data">Fisher&apos;s scoring</td>
<td class="data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX1" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Observations Summary">
<caption aria-label="Observations Summary"></caption>
<colgroup><col/><col/></colgroup>
<tbody>
<tr>
<th class="rowheader" scope="row">Number of Observations Read</th>
<td class="r data">300</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Observations Used</th>
<td class="r data">299</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Response Profile">
<caption aria-label="Response Profile"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Response Profile</th>
</tr>
<tr>
<th class="r b header" scope="col">Ordered<br/>Value</th>
<th class="b header" scope="col">Bonus</th>
<th class="r b header" scope="col">Total<br/>Frequency</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="data">0</td>
<td class="r data">255</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="data">1</td>
<td class="r data">44</td>
</tr>
</tbody>
</table>
<div class="proc_note_group">
<p class="c proctitle">Probability modeled is Bonus=&apos;1&apos;.</p>
</div>
</div>
<div class="proc_note_group">
<p class="c note"><span class="c notebanner">Note:</span><span class="c notecontent">1 observation was deleted due to missing values for the response or explanatory variables.</span></p>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Class Level Information">
<caption aria-label="Class Level Information"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Class Level Information</th>
</tr>
<tr>
<th class="b header" scope="col">Class</th>
<th class="b header" scope="col">Value</th>
<th class="c b header" colspan="2" scope="colgroup">Design Variables</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Fireplaces</th>
<th class="rowheader" scope="row">0</th>
<td class="r data">0</td>
<td class="r data">0</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<th class="rowheader" scope="row">1</th>
<td class="r data">1</td>
<td class="r data">0</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<th class="rowheader" scope="row">2</th>
<td class="r data">0</td>
<td class="r data">1</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lot_Shape_2</th>
<th class="rowheader" scope="row">Irregular</th>
<td class="r data">1</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<th class="rowheader" scope="row">Regular</th>
<td class="r data">0</td>
<td class="r data">&#160;</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Convergence Status">
<caption aria-label="Convergence Status"></caption>
<colgroup><col/></colgroup>
<thead>
<tr>
<th class="c b header" scope="col">Model Convergence Status</th>
</tr>
</thead>
<tbody>
<tr>
<td class="c data">Convergence criterion (GCONV=1E-8) satisfied.</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX5" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Fit Statistics">
<caption aria-label="Fit Statistics"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Model Fit Statistics</th>
</tr>
<tr>
<th class="b header" scope="col">Criterion</th>
<th class="r b header" scope="col">Intercept Only</th>
<th class="r b header" scope="col">Intercept and Covariates</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">AIC</th>
<td class="r data">251.812</td>
<td class="r data">140.499</td>
</tr>
<tr>
<th class="rowheader" scope="row">SC</th>
<td class="r data">255.513</td>
<td class="r data">159.001</td>
</tr>
<tr>
<th class="rowheader" scope="row">-2 Log L</th>
<td class="r data">249.812</td>
<td class="r data">130.499</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX6" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Global Tests">
<caption aria-label="Global Tests"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Testing Global Null Hypothesis: BETA=0</th>
</tr>
<tr>
<th class="b header" scope="col">Test</th>
<th class="r b header" scope="col">Chi-Square</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio</th>
<td class="r data">119.3133</td>
<td class="r data">4</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Score</th>
<td class="r data">91.7250</td>
<td class="r data">4</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Wald</th>
<td class="r data">49.8671</td>
<td class="r data">4</td>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX7" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Type 3 Tests">
<caption aria-label="Type 3 Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Type 3 Analysis of Effects</th>
</tr>
<tr>
<th class="b header" scope="col">Effect</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Wald<br/>Chi-Square</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Basement_Area</th>
<td class="r data">1</td>
<td class="r data">38.1356</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Fireplaces</th>
<td class="r data">2</td>
<td class="r data">5.2060</td>
<td class="r data">0.0741</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lot_Shape_2</th>
<td class="r data">1</td>
<td class="r data">16.9421</td>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX8" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Parameter Estimates">
<caption aria-label="Parameter Estimates"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="7" scope="colgroup">Analysis of Maximum Likelihood Estimates</th>
</tr>
<tr>
<th class="b header" scope="col">Parameter</th>
<th class="b header" scope="col"> &#160;</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Estimate</th>
<th class="r b header" scope="col">Standard<br/>Error</th>
<th class="r b header" scope="col">Wald<br/>Chi-Square</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Intercept</th>
<th class="rowheader" scope="row">&#160;</th>
<td class="r data">1</td>
<td class="r data" style="white-space: nowrap">-11.0882</td>
<td class="r data">1.5384</td>
<td class="r data">51.9467</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Basement_Area</th>
<th class="rowheader" scope="row">&#160;</th>
<td class="r data">1</td>
<td class="r data">0.00744</td>
<td class="r data">0.00120</td>
<td class="r data">38.1356</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Fireplaces</th>
<th class="rowheader" scope="row">1</th>
<td class="r data">1</td>
<td class="r data">0.8810</td>
<td class="r data">0.4658</td>
<td class="r data">3.5770</td>
<td class="r data">0.0586</td>
</tr>
<tr>
<th class="rowheader" scope="row">Fireplaces</th>
<th class="rowheader" scope="row">2</th>
<td class="r data">1</td>
<td class="r data" style="white-space: nowrap">-0.7683</td>
<td class="r data">0.9654</td>
<td class="r data">0.6335</td>
<td class="r data">0.4261</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lot_Shape_2</th>
<th class="rowheader" scope="row">Irregular</th>
<td class="r data">1</td>
<td class="r data">1.9025</td>
<td class="r data">0.4622</td>
<td class="r data">16.9421</td>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX9" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Association Statistics">
<caption aria-label="Association Statistics"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Association of Predicted Probabilities and Observed Responses</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Percent Concordant</th>
<td class="r data">92.9</td>
<th class="rowheader" scope="row">Somers&apos; D</th>
<td class="r data">0.859</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Discordant</th>
<td class="r data">7.0</td>
<th class="rowheader" scope="row">Gamma</th>
<td class="r data">0.860</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Tied</th>
<td class="r data">0.1</td>
<th class="rowheader" scope="row">Tau-a</th>
<td class="r data">0.216</td>
</tr>
<tr>
<th class="rowheader" scope="row">Pairs</th>
<td class="r data">11220</td>
<th class="rowheader" scope="row">c</th>
<td class="r data">0.930</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX10" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="95% Clodds=PL">
<caption aria-label="95% Clodds=PL"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Odds Ratio Estimates and Profile-Likelihood Confidence Intervals</th>
</tr>
<tr>
<th class="b header" scope="col">Effect</th>
<th class="r b header" scope="col">Unit</th>
<th class="r b header" scope="col">Estimate</th>
<th class="c b header" colspan="2" scope="colgroup">95% Confidence Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Basement_Area</th>
<th class="r data">100.0</th>
<td class="r data">2.105</td>
<td class="r data">1.696</td>
<td class="r data">2.727</td>
</tr>
<tr>
<th class="rowheader" scope="row">Fireplaces    1 vs 0</th>
<th class="r data">1.0000</th>
<td class="r data">2.413</td>
<td class="r data">0.973</td>
<td class="r data">6.127</td>
</tr>
<tr>
<th class="rowheader" scope="row">Fireplaces    2 vs 0</th>
<th class="r data">1.0000</th>
<td class="r data">0.464</td>
<td class="r data">0.054</td>
<td class="r data">2.703</td>
</tr>
<tr>
<th class="rowheader" scope="row">Lot_Shape_2   Irregular vs Regular</th>
<th class="r data">1.0000</th>
<td class="r data">6.703</td>
<td class="r data">2.786</td>
<td class="r data">17.301</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX11" style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Odds Ratios with 95% Profile-Likelihood Confidence Limits" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAIAAAC6s0uzAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO3de1xU5d7//2sUD4gcUkQOCqaYGQrbM4pbUVHUtPD2+HBr4YEU063m7r5L3R624OlOs0xu8UQq7RuzGykoLSIQFRFPgPJILRUwARUU0BQUWL8/1rf5TTMwAgIXyuv518y11lzXZ11rZr1nLdaoJiUlRQAAgLplIoRwdXWVXQYAAA1IampqI9k1AADQEBHAAABIQAADACABAQwAgAQEMAAAEhDAAABIQAADACABAQwAgAQEMAAAEhDAAABIQAADACABAQwAgAQEMGrLw4cP16xZ061bN1NTU0tLS09Pz/DwcCPr29raajSa3377rUqLytW8eXPNH0xMTF5++eVZs2bdvHmzSvWXlZX169evY8eOeXl5VXph9RgfzsrKSqPR5OTkGO8kKytr/PjxFhYWVlZWs2fPLiwsVNu7deum+TO1/eOPP7a2tra1td24caO2kw0bNlhYWFS01bpz26RJk86dO7/33nv37t2rxiYXFhZOnDjR0tJSo9Fs2bJFd/Mrub2Ghf3666967XoTW9Wetes/Yz9VZeQ9X1ZWtmvXrgEDBlhYWLRo0aJHjx6BgYH5+fnPMpyRfVH5wmpbJXdxZdTxp7siBDBqxYMHDwYPHrxixYq0tLSioqLCwsKjR4+OHz9+6dKldVxJaWlpenr6nj17+vfvf//+feMre3p6ajSaH3/8UftaIYSiKLVepcFwepVUhqIo48aNCw8Pv3//fkFBwe7du6dMmWJk/Z9//nnJkiWLFy9esmTJf/3Xf507d04IUVhYuHHjxsWLF7du3fqpI5aUlPz6668ff/yxl5eXWnyVbNq06auvvlK/Jbi5udXebNdUz3X8fihXSUmJj4+Pn5/fyZMn79+//+jRo+Tk5OXLl7/22mt3796tdrd1ti9qSTUKfsaPW40ggFErPvzwwzNnzlhaWu7fvz8vL+/atWsLFiwQQqxbt+6nn36qmxp++eUXRVEeP358/Pjx1q1b37hxw/gpuJ5GjRqdOXPm2rVr1tbWtVdkDQ4XHx+flJRkY2Nz5cqV1NTU1q1bHz58+NixY+rStm3bKjqEECdOnFAUpX///oMGDRJCqGtu2rRJUZT33nvP+Fjq3BYVFYWHhzdt2vTcuXPHjx+vasGXLl0SQqxcuVJRlCFDhtTSbNfUfqzj90NFAgICIiMjmzRpsnnz5tzc3IKCgjNnzixdutTFxaVVq1bV7rZu9kUtqcauqSd7U6SkpChAjXr06JGpqakQYt++fbrto0ePFkKMGzdOfXrnzp3x48ebmpo6ODhs3769bdu2QogbN24YX3Tq1CkvL69WrVpZWloOHDgwNDS0pKREr4BmzZqJP0JCNX78eCHEunXr1KdxcXETJkywtrZu2bLlgAEDEhMTFUXp1auX9nMxbNgwRVEsLS2FENnZ2YqiFBcXr1ix4uWXX27SpImdnd28efPu3bun9vbUktQz0fDwcEVR1Gt3Q4YMURdNnjxZCPHNN9/oDldRJSEhIb169TIzM+vVq9eZM2f0tnrHjh1CiDfeeEN9unDhQiHEBx98oCiKi4uLXgArihISEiKEiImJOXnypBBiy5Ytubm55ubma9euNbJzDee2Z8+eQogvvvhCW2d8fHzHjh27detmZN7UNVWWlpZ6s637+OHDh4sWLbK1tW3WrJmHh8fZs2crWZhWuT3fv3+/f//+Qojt27cbGaWiqozsESNvFSOLjLzntR4/fqyOGxgYWNEOMjJERTUb3xdGCjM+aeVOTmlp6aZNm1xcXJo1a9auXbtp06ZduXKlknu5Srt4x44drq6u5ubmnp6eZ8+enT59uo2Nja2tbXBwsN5LDD9ulTnIPLuUlBQCGDUvMTFRCNG4cePHjx/rtoeFhQkh7O3t1adqHms1atRI+8GuaFFRUZGVlZXel0jDD6TuB7WkpOTs2bNt2rQRQhw8eFBRlNLSUt0jjhDCxsamsLDQeABPmDBBb9wePXo8fvy4MiXt2rVLCLF48WJFUXbv3i2EaNq06YMHDxRFsbe3NzExKSwsVCoRwLo6duyot9VRUVHqtly+fPnGjRuDBw8WQkyYMEFRFBcXF41G07x5czs7u/Hjx//666+Koly+fLlRo0YrV6786KOPhBBnzpz5xz/+YWNjoxZWEd25Vc+AmzRpIoQ4fvy4tk53d3chxLRp04zMW+UDeOzYsbovt7KyysvLM16YHsOer127NmTIECHEp59+qq5T0SjGA7jcPVLRJhtfZOTjoHX69GkhhEajuX//fkU7yMgQFdVsfF8YKcz4pJU7Ob6+vnqL1LdoZfZylXZxRZo0aXLz5k2l4o9bJQ8yz44ARq04cuSIMLjmqShKfHy8EMLU1FRRlIsXL6of5oiIiHv37gUFBTVu3Fj9YBtZlJWVJYSwsLDYvXt3VlZWVFSUp6dnWVmZ3kDqB1WPi4tLcXGxusLMmTODgoLu3r2blZX1yiuvCCGOHTumKIoaWtHR0epq2o9ocnKyWtKXX3754MGDn376ycLCQgjx73//uzIlpaenCyF69+6tKMrkyZPV10ZFRf3yyy9CiAEDBugNV1ElU6dOzczMTExMVA+C6ppaDx8+fPnll/W2euzYsYqi+Pj4tGjRQtvYqlUr9Rj02Wef2dnZ2djYrFu3Lisry9TUdPPmzT/++KOzs7OFhcX06dMfPXpUmbl1d3dXN1mt097e/vLly4qiGJk35Y/LEvv37zfcfO3j8+fPCyGsra1Pnz6t3tYnhFixYoXhu65KR+d+/foJnfNII6MYD2DDPWJkk40sMvKe190Q9ZPVpk0bw21UGZ9wteaJEyfm5OTovYsq2hdGCnvqpBkOlJaWpr5hNm7cmJ+fn5GRsXDhwhUrVlRyL1dpF0+fPj0nJ+f9998XQrRo0SIsLCw3N9fR0VEI8f333ysVf9wqeZB5dgQwasWpU6dExWfADg4O2seDBw/WLtVe2jKySFGU1atXm5iYCCFat269cuXKgoICwwIMQ2LUqFG5ubnaFTIyMhYsWODq6qr9snzo0CGl4gBWT1s9PT21PcybN08I8d5771WypE6dOjVu3LigoKB169YLFiywsbFZsGCBemasPdA8NYC1iWtvb1/ukejKlSujRo2ysLDo1KmTt7e3EOKtt97SLi0pKTlz5ox6DPrXv/6l99p58+bZ29s/ePDAzs7Oy8tL3Ynqn4QrmtsmTZo4Ozu///77+fn5unVqj+PG560yAaz2oOf1119ftmyZ9umyZcuUap0evfvuu7p1Go5SUVVG9oiRTTayyPh7XkvdKRqNRr1kYsj4hKs1Z2Vl6dVsZF8YKeypk2Y40J49e4TON07V77//bqQrXVX9K4Pyx3FG29XIkSPFHx92Ix+3ynyin11KSgo3YaHmubm5tWzZsrS09Msvv9RtDw0NFUJ4eHgIIYqLi4UQ6rdpPUYWCSFWrFih3r5bVla2evXqrl27queRhtQPqvqXzlOnTmlvgb5161avXr22bt2amppaUFBQ+e1SdO6xLCsrq1JJw4YNKy0t/eyzz/Ly8ry9vb28vH744Qf1koCXl1fla1CpV30Nde7c+bvvvisoKPj111/bt28vhHjttde0Sxs3btyrV68333xTCKH3M5L09PRdu3YtX748KysrOzu7T58+ffv2bd68ufYeLj3aG9x++eWXjRs36l3009uiiuatMtSTJz3P/huYd955x8bGZvv27eq517OPordHjGxyuYuMv+e13NzczMzMFEX57//+byOrGZ9w7Y/QKnoX6TJS2FMnraKBFIN7lWtpLwuDyp86w6rKH2SeEQGMmtesWTP1e/eCBQv+93//9969exkZGYsXL46KitJoNOrNQa+++qoQIj4+/vDhw/n5+Zs3b75z5476ciOLbt686e3tfePGjRUrVly7dm3YsGFZWVnqzUcV8fX1feedd+7evTthwgT1aPLDDz/k5uaOHDny3LlzmzZtat68uXZl9WuvelDW1bt3byHEsWPHDhw48PDhw5iYGPXLRO/evStZkppJH330UZMmTQYPHjx8+PDLly9HRka2bNlS/YupnooqMc7f3//gwYMFBQXffffdF198odFoxo4dm5CQMG3atLNnzz58+DApKUm9FdzZ2Vn3hatXr7a3t589e7Z6rFQPkYqiaI+h1WNk3irZgzo5rVq1Onz48KNHj9LT0zdv3uzj4xMQEKA9kwgICKhqYatXrw4MDCwtLZ03b56iKBWNUtVuhdFNNrLIyHtel/aTFRgYuHTp0oyMjPv376ekpGzYsKFnz55FRUXPPuF6jBRWjUlT73o7efLkxo0bCwoKsrOzV69e/Y9//KMG5796dD9u1TjIVB+XoFEbHj16pF7V0aN7h+3AgQN1F+n+0auiRd99951hn3v27NEbXe9SVXFxcd++fYUQs2bNUhSl3N9BHThwQFEU9bdS4o/r5JW5CauSJeXm5qphpl7N0367Hz16tHYd3eGMVKIoipOTkzC4FvfkyRNzc3PdMvz8/BRF2bx5s1559vb2une4XLp0qXHjxmrNJSUljo6OgwcPVq92bt682fjc6tGr08i8KZW7BK0oyuzZs/V60L0iqleYnrfffruinktLS9X7t3ft2mVklEpegtbdI9W7CcvIx0FXUVFRuZdMzMzMLly4YHwIIzUb2RdGCqvMpOkNZPiSgQMHVnIvV3UXK4py8OBBoXMJ+vXXXxflXYLW/bhV8hP97Pgb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0SIvLy8oKCgyMrKi/m/duhUcHNynTx91/mu7TkAIEbBb/wKSYQuAajCp9iujo6NnzJjRuXNnIcTChQujo6P/8pe/GFl/9OjRo0aNiomJCQ4O3rRp07///W8hhJeXl/onyUGDBuXm5paWlgYEBISHh2dmZhYUFGRnZ5uZmQ0dOtTT01MI4e/vHxsbm5GRERsba2dnp3Y7YMCAYcOGlTticXHx1KlT161bZ21tXe4Kbm5uEydO1HscHR2t139ZWdnbb7/t5OQkhBg/fryRbSy3ft1RVD4+PkuXLi0uLg4NDZ02bZo6D59++uno0aPnz59veFqfkZGh0WjUxzNnzlRXqIM6tbKzs6vUXg012FW1hbqbyi6hPkotWS/En2Ym9UIGcwVoGR6+zM3NK/PC6gewEEJ7IqteGX4qjUbj5eXl5eW1ffv2FStWqNmjatSokaIowcHB8fHxe/fu7dSp09y5c7X9q8rKypo2bdqoUaOVK1euWrXK+FiFhYWTJk166623Jk2aVNE6VlZWho8N+1+zZk1ZWZnea7UtT5480TaWW7/uKCpTU1MvL6/IyMjQ0NCoqCghhKOjY3JyckJCwieffBISEqJ3Euzk5JSenq4oytSpU1u2bGlmZlY3dWppY15XdnZ2ue3VU4NdVdu0xEeyS3iKmp3zSto2IyLxwm3dFtfuTtNC6vtc1RQpc47naNpD3U2rXWr1L0F7eXnt3Lnz559//u233zZv3uzl5dWsWbPs7Ozi4mLDlS9fvjx+/PiEhITff//9+vXrUVFR6omanpycHHd3986dO3/zzTfaK9VxcXGJiYm3b98OCgoaOnSot7f3rl27zp49W1BQEBISsm7dOsN+bt26NXbs2CVLlkydOrWq22XY/1//+teQkJBr165duHDhq6++EkJYW1snJSXl5OTExMSEhYUZr79cvr6+y5Yta9OmjToPERER69at69q164YNG06ePFnuCzUazeeff37+/Hn1vu66qRNYPqvnU1sAVEMVAli9EKpyd3cfMGDAokWLhg0b1qNHjxEjRkyZMsXJycne3r5Vq1aG52FdunT5+9///v7771tbW//1r3/t2rXrBx98YDiEr6/v119/7ejoGBsbO3369GvXrgkhevfuHRAQ0KVLl759+44fP75Pnz5r1qyZPHmyo6PjoUOHyr1qumHDhvj4+BEjRqjVBgRU4Xdahv17enpOnDixT58+77zzzoABAzQaTa9evTw8PDp16hQcHKxbQLn1l8vDw0O9Yqw+HThwYFpaWseOHT08PNauXau94KynWbNmERERO3bsCA8Pr5s6gdcHOkZtGene3cbKvKl7d5uoLSNfH+gouyjghZCSkqLUY7GxsW+++absKv6fmzdvdu/e/fjx47ILeYqarXP7nr3ltmdlZdVI/0aGqEv7+zWXXcLT1eCco5KYcymeo2mv6NDx1MNaSkpKzf8OOD8/X2NA+8uZ53G4uLg4tVtXV9dRo0Z5eHjUYOc16Hmps35ynb1cdgkAnj/Pcuh4ppuwymVlZaXU3N8UPT091Vug62a4imqo7SFqxPNSZ/3kOpt/3gRAlT3LoYN/CxoAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJDCRXQDqO/OWLYND9tX2KHUwBADUGXNzs6euQwDjKaZO/I9y24ND9s2Z8VYdF9PAMed1jzmXooFMO5egAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQQJOSkuLq6iq7DAAAGpDU1FTOgAEAkIAABgBAAgIYAAAJCGBUWVhYWIcOHRwcHLZt2ya7lgYhPz9foyMxMVF2RS+yO3fu7Nixw8rKStvCG74O6E17A3nP809Romry8vLmzZt3+PDh1q1bDxkyZPjw4a+88orsol58Hh4ex48fl11Fg9C3b99BgwYVFRWpT3nD1w29aRcN4z3PGTCqJjo6eujQof369XN2dp4yZUpkZKTsioCadP369b1792qf8oavG3rT3kAQwKia7OxsJycn9bGjo2NWVpbcehqCxo0bX7lyxcLCol27duvWrZNdTsPCG16KBvKe5xI0qubJkycajUb7tKSkRGIxDYS5ufnt27cVRfn55599fHy6d+8+ZswY2UU1FLzhpWgg73nOgFE1Dg4O6enp6uMbN244ODhILacB0Wg0r7322rhx41JSUmTX0oDwhpfohX/PE8ComiFDhsTExJw6derq1athYWHe3t6yK3rxffzxx9u3b7979+7FixcPHjzYt29f2RU1ILzhpWgg73kCGFVjb28fFBQ0adKknj17+vv7u7m5ya7oxTdu3Ljo6GhnZ+eRI0e+++67w4cPl11RA8IbXooG8p7n34IGAKCu8W9BAwAgBwEMAIAEBDAAABIQwAAASEAAAwAgAQEMAIAEBDAAABIQwADqwrZt21577bVmzZrZ2tr6+/vfu3dPb4WLFy86OztXplFPUVGR9j+Obd68effu3UNDQ42sn5ubq/6/s7/++uuIESOqvilAzSCAAdS6FStWbNy4cfPmzXfu3ImNjc3Ozh42bFhxcXENDnH//n1FUe7du/fRRx+9++67586de+pLnJ2df/jhhxqsAagSAhhA7bp169aGDRu++uqrkSNHWlhYdO3a9auvvvr999/V///1wIED7du3f/nll8+cOaN9iWGjoih///vfW7dubW1tvWbNmor+VyJTU1Nvb+/evXurAfzkyRMrKyv1zHjQoEEZGRlCCE9Pz4KCAo1GExMT8+qrr6ovjI2NdXV1tbS09PHxuXPnTq1OCKAigAHUrtjY2I4dO/bp00fbYmJiMnXq1Ojo6Bs3bsydO3f//v2nTp0KCwtTl5bb+P333yckJFy6dOncuXNpaWmFhYXljlVUVPTdd9+dPn26X79+QogmTZrk5+crinL37t2uXbuuWbNGCBEXF2dpaakoStu2bdVX5ebmTpgwITAwMDMz08nJaebMmbU3G4AWAQygduXl5Rn+L3729va5ubnfffedt7e3p6enjY3Nhx9+qC4qt9HS0jI7O/vUqVNt27YNCwtr1aqVXofm5uYajcbU1HT+/Pn79u3r3r277tIWLVpMnDjx8uXL5VYYGRk5ePDgsWPHWlparl+/PiYmJj8/vwa2HDCKAAZQu9q0aZOVlaXXmJWVZWNjc+fOHXt7e7WldevW6oNyG/v37799+/bg4OB27dotXrz48ePHeh2qfwPevXt3WVnZkCFD1EZFUbZu3TpgwABbW9vRo0c/efKk3AqzsrKcnJzUx6ampjY2Njdv3nymbQYqgQAGULuGDh2anp5+/vx5bUtpaWlYWNioUaPs7e21/9393bt31QflNgohxo4dGxkZeenSpbNnz+7fv7/csWbOnNmnT585c+aoT0NDQ3fs2LF27dq0tDQj91vZ29tfvXpVffz777/funXL8JQdqHEEMIDaZW1tvXLlygkTJkRHR9+/f//SpUuTJk166aWX/va3v40ePfrHH388cuTIzZs3//Wvf6nrl9sYGxv73nvv/fbbb40aNTI1NW3atGlFw+3YsePEiROff/65EOK3335zc3Pr1atXZmbm6tWr1Vu3zM3NHz58mJeXp33JmDFjjh07Fh4enp+f/5//+Z9Dhw5Vf6cE1K6UlBQFAGrZ7t27XVxcmjZtamtrO3/+/IKCArX94MGDTk5O7du3DwkJ6dSpU0WNhYWFCxYssLOzs7S0nD179pMnT7Q9P3r0SPxxCVr1008/WVhY/PLLLzdv3uzXr5+ZmdngwYO//PLLVq1aPX78WFGUWbNmmZiY7Nu3r0uXLtqXdO/e3cLCYuzYsTk5OXUzJ2jIUlJSNCkpKa6urrK/BgAA0ICkpqZyCRoAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAkIYAAAJCCAAQCQgAAGAEACAhgAAAlMhBCpqamyywAAoGH5/wBf65WxVWzhYwAAAABJRU5ErkJggg=="/>
</div>
</div>
<div id="IDX12" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Predicted Probabilities for Bonus=1 by Basement_Area, sliced by Fireplaces*Lot_Shape_2." src="data:image/png;base64,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"/>
</div>
</div>
</div>
</div>
</body>
</html>





In the PROC LOGISTIC statement, we specify the ameshousing3 data, and the PLOTS= option specifies an effect plot and an odds ratio plot. The CLASS statement specifies the categorical predictors Fireplaces and Lot_Shape_2 and the parameterization method. By default, PROC LOGISTIC uses effect coding. To specify reference cell coding, you use the PARAM= option.

As the default reference level for either effect coding or reference cell coding, PROG LOGISTIC uses the last level in alphanumeric order. To specify a reference level, you use the REF= variable option. You can specify the actual value, or level, in quotation marks, or the keyword FIRST or LAST. In this example, Fireplaces has a reference level of 0, and Lot_Shape_2 has a reference level of Regular.

The MODEL statement is the same as the previous demonstration, but it now specifies all three predictor variables.

The UNITS statement enables you to obtain customized odds ratio estimates for a specified unit of change in one or more continuous predictor variables. By default, PROC LOGISTIC finds odds ratios for a one-unit change in the continuous predictors. However, for a variable like Basement_Area, it doesn't make sense to find the odds ratios between two homes where one has only a single square foot larger basement area. Instead, we might want to find the odds ratios for homes with a difference of 100 square feet in basement area, because it's more interpretable. For each continuous predictor, you specify the variable name, an equal sign, and a list of one or more units of change, separated by spaces. In this example, we specify the number 100 as the unit of change for the continuous predictor Basement_Area.

The Model Information and Response Profile are the same as for the binary logistic regression model that we ran in the previous demonstration. It's useful to look at this information to make sure that your model is set up as you intended. The statement below the table indicates that, once again, we're modeling the probability of being bonus eligible (Bonus=1).

The Class Level Information table includes the predictor variables in the CLASS statement. Because we used the PARAM=REF and REF='Regular' options, this table reflects our choice of Lot_Shape_2='Regular' as the reference level. The design variable is 1 when Lot_Shape_2='Irregular' and 0 when Lot_Shape_2='Regular'. The reference level for Fireplaces is 0, so there are two design variables, each coded 0 for observations where Fireplaces=0.

The SC value in the Basement_Area only model was 169.246. Here in the Fit Statistics table, it's 159.001. Recalling that smaller values imply better fit, you can conclude that this model fits better.

In the Global Tests table, Testing Global Null Hypothesis: Beta=0, we see that this model is statistically significant, indicating at least one of the predictors in the model is significantly different from zero.

The Type 3 Analysis of Effects table is generated when you use the CLASS statement. This table displays the significance of each of the effects individually, adjusting for other predictors included in the model. Fireplaces is not statistically significant at the 0.05 level, but the other remaining predictors are statistically significant. Notice for Fireplaces, there are two degrees of freedom. This is because Fireplaces has three levels and two dummy variables, or effects in the model. This table tests for the significance of Fireplaces, and therefore, tests for the significance of both of its effects jointly. The continuous predictor Basement_Area only has one degree of freedom, and Lot_Shape_2 has two levels, and therefore, only 1 dummy variable and degree of freedom.

Next let's look at the Parameter Estimates table, Analysis of Maximum Likelihood Estimates. For CLASS variables, effects are displayed for each of the design variables. Because reference cell coding was used, each effect is measured against the reference level. For example, the estimate for Lot_Shape_2 | Irregular shows the difference in logits between houses with Irregular and Regular lot shapes, which is 1.9025. Fireplaces | 1 shows the logit difference between houses with 1 fireplace and 0 fireplaces, while Fireplaces | 2 shows the difference in logits between houses with 2 fireplaces and 0 fireplaces. Not all of these effects are statistically significant. Notice that the Wald Chi-Square values and p-values are the same in both tables for Basement_Area and Lot_Shape_2. This is because they only have one degree of freedom. Whereas each effect for Fireplaces is tested separately in this table, so the chi-square values are different than the type 3 analysis of effects.

In the Association of Predicted Probabilities and Observed Responses table, the c statistic value is 0.930, and the percent concordant is approximately 93% for this model, indicating that 93% of the positive and negative response pairs are correctly sorted using Basement_Area, Fireplaces, and Lot_Shape_2.

The Odds Ratio Estimates table shows that, adjusting for other predictor variables, homes with Irregular lots had 6.703 times the odds of being bonus eligible than homes with Regular lots. Homes with 1 fireplace had nearly 2.5 times the odds of being bonus eligible than homes with 0 fireplaces, and homes with 2 fireplaces had less than half the odds than the homes with 0 fireplaces. The table shows that for each 100-square-foot increase in basement area, the bonus eligibility odds increase by 110.5%. Notice that the confidence intervals for the Basement_Area and Lot_Shape_2 odds ratios do not cover a value of 1, indicating the odds ratios are statistically significant for these two variables. However, the odds ratios for Fireplaces both cover 1, and therefore, they are not statistically significant.

The ODDSRATIO plot displays these confidence intervals graphically, and you can see which intervals cover the vertical line at a value of 1.

The final plot is an effect plot of Predicted Probablities for Bonus=1. It shows the estimated probability of a bonus eligible home across different basement areas, given the different combinations of the categorical variables Lot_Shape_2 and Fireplaces. For example, we can see that the left most probability curve corresponds to homes with 1 fireplace and an irregular lot shape. This means that as the values of Basement_Area increase, the probability of being bonus eligible increases faster than any other combination of the categorical variables. However, as the Basement_Area increases past 1500 square feet, each curve shows a high probability of the home selling for more than $175,000.

#### Practice: Using PROC LOGISTIC to Perform a Multiple Logistic Regression Analysis with Categorical Variables
The insurance company wants to model the relationship between three of a car's characteristics, weight, size, and region of manufacture, and its safety rating. The stat1.safety data set contains the data about vehicle safety.

1. Use PROC LOGISTIC to fit a multiple logistic regression model with Unsafe as the response variable and Weight, Size, and Region as the predictor variables.
Use the EVENT= option to model the probability of Below Average safety scores.
Specify Region and Size as classification variables and use reference cell coding. Specify Asia as the reference level for Region, and 3 (large cars) as the reference level for Size.
Request profile likelihood confidence limits, an odds ratio plot, and the effect plot.
Submit the code and view the results.


```sas
title 'First lets check the data';
proc print data=STAT1.safety(obs=3);
run;
title;

ods graphics on;
proc logistic data=STAT1.safety plots(only)=(effect oddsratio);
   class Region (param=ref ref='Asia')
         Size (param=ref ref='3');
   model Unsafe(event='1')=Weight Region Size / clodds=pl;
   title 'LOGISTIC MODEL (2):Unsafe=Weight Region Size';
run;
```




<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>SAS Output</title>
<style>
/*<![CDATA[*/
.body.c > table, .body.c > pre, .body.c div > table,
.body.c div > pre, .body.c > table, .body.c > pre,
.body.j > table, .body.j > pre, .body.j div > table,
.body.j div > pre, .body.j > table, .body.j > pre,
.body.c p.note, .body.c p.warning, .body.c p.error, .body.c p.fatal,
.body.j p.note, .body.j p.warning, .body.j p.error, .body.j p.fatal,
.body.c > table.layoutcontainer, .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.layoutregion.l table, .layoutregion.l pre, .layoutregion.l p.note,
.layoutregion.l p.warning, .layoutregion.l p.error, .layoutregion.l p.fatal { margin-left: 0 }
.layoutregion.c table, .layoutregion.c pre, .layoutregion.c p.note,
.layoutregion.c p.warning, .layoutregion.c p.error, .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r table, .layoutregion.r pre, .layoutregion.r p.note,
.layoutregion.r p.warning, .layoutregion.r p.error, .layoutregion.r p.fatal { margin-right: 0 }
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section { display: block }
html{ font-size: 100% }
.body { margin: 1em; font-size: 13px; line-height: 1.231 }
sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
ul, ol { margin: 1em 0; padding: 0 0 0 40px }
dd { margin: 0 0 0 40px }
nav ul, nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
img { border: 0; vertical-align: middle }
svg:not(:root) { overflow: hidden }
figure { margin: 0 }
table { border-collapse: collapse; border-spacing: 0 }
.layoutcontainer { border-collapse: separate; border-spacing: 0 }
p { margin-top: 0; text-align: left }
h1.heading1 { text-align: left }
h2.heading2 { text-align: left }
h3.heading3 { text-align: left }
h4.heading4 { text-align: left }
h5.heading5 { text-align: left }
h6.heading6 { text-align: left }
span { text-align: left }
table { margin-bottom: 1em }
td, th { text-align: left; padding: 3px 6px; vertical-align: top }
td[class$="fixed"], th[class$="fixed"] { white-space: pre }
section, article { padding-top: 1px; padding-bottom: 8px }
hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.stacked-value { text-align: left; display: block }
.stacked-cell > .stacked-value, td.data > td.data, th.data > td.data, th.data > th.data, td.data > th.data, th.header > th.header { border: 0 }
.stacked-cell > div.data { border-width: 0 }
.systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.systitleandfootercontainer > p { margin: 0 }
.systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.batch { display: table }
.toc { display: none }
.proc_note_group, .proc_title_group { margin-bottom: 1em }
p.proctitle { margin: 0 }
p.note, p.warning, p.error, p.fatal { display: table }
.notebanner, .warnbanner, .errorbanner, .fatalbanner,
.notecontent, .warncontent, .errorcontent, .fatalcontent { display: table-cell; padding: 0.5em }
.notebanner, .warnbanner, .errorbanner, .fatalbanner { padding-right: 0 }
.body > div > ol li { text-align: left }
.beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.c { text-align: center }
.r { text-align: right }
.l { text-align: left }
.j { text-align: justify }
.d { text-align: right }
.b { vertical-align: bottom }
.m { vertical-align: middle }
.t { vertical-align: top }
.accessiblecaption {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
a:active { color: #800080 }
.aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.batch > tbody, .batch > thead, .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.batch { border: hidden; }
.batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.bylinecontainer > col, .bylinecontainer > colgroup > col, .bylinecontainer > colgroup, .bylinecontainer > tr, .bylinecontainer > * > tr, .bylinecontainer > thead, .bylinecontainer > tbody, .bylinecontainer > tfoot { border: none; }
.bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.cell, .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.contentfolder, .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.contentproclabel, .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.data, .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.graph > tbody, .graph > thead, .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.graph { border: hidden; }
.graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.heading1, .heading2, .heading3, .heading4, .heading5, .heading6 { font-family: Arial, Helvetica, sans-serif }
.index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.indexaction, .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.layoutcontainer, .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:link { color: #0000ff }
.list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.list3, .list4, .list5, .list6, .list7, .list8, .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.listitem3, .listitem4, .listitem5, .listitem6, .listitem7, .listitem8, .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.output > tbody, .output > thead, .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.output { border: hidden; }
.output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    }
.pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.pagesproclabel, .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: bold;
}
.paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.parskip > col, .parskip > colgroup > col, .parskip > colgroup, .parskip > tr, .parskip > * > tr, .parskip > thead, .parskip > tbody, .parskip > tfoot { border: none; }
.parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
    }
.prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: italic;
    font-weight: normal;
}
.rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.systemfooter, .systemfooter10, .systemfooter2, .systemfooter3, .systemfooter4, .systemfooter5, .systemfooter6, .systemfooter7, .systemfooter8, .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.systemtitle, .systemtitle10, .systemtitle2, .systemtitle3, .systemtitle4, .systemtitle5, .systemtitle6, .systemtitle7, .systemtitle8, .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.systitleandfootercontainer > col, .systitleandfootercontainer > colgroup > col, .systitleandfootercontainer > colgroup, .systitleandfootercontainer > tr, .systitleandfootercontainer > * > tr, .systitleandfootercontainer > thead, .systitleandfootercontainer > tbody, .systitleandfootercontainer > tfoot { border: none; }
.systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.table > col, .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.table > tr, .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.table { border: hidden; }
.table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.titleandnotecontainer > col, .titleandnotecontainer > colgroup > col, .titleandnotecontainer > colgroup, .titleandnotecontainer > tr, .titleandnotecontainer > * > tr, .titleandnotecontainer > thead, .titleandnotecontainer > tbody, .titleandnotecontainer > tfoot { border: none; }
.titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
a:visited { color: #800080 }
.warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: bold;
}
.warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
.warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size:  normal;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="l body">
<div style="padding-bottom: 8px; padding-top: 1px">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">First lets check the data</span> </p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Data Set STAT1.SAFETY">
<caption aria-label="Data Set STAT1.SAFETY"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="r header" scope="col">Obs</th>
<th class="r header" scope="col">Unsafe</th>
<th class="r header" scope="col">Size</th>
<th class="r header" scope="col">Weight</th>
<th class="header" scope="col">Region</th>
<th class="header" scope="col">Type</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="r data">0</td>
<td class="r data">2</td>
<td class="r data">3</td>
<td class="data">N America</td>
<td class="data">Medium</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="r data">0</td>
<td class="r data">3</td>
<td class="r data">4</td>
<td class="data">N America</td>
<td class="data">Sport/Utility</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3</th>
<td class="r data">0</td>
<td class="r data">2</td>
<td class="r data">3</td>
<td class="data">N America</td>
<td class="data">Medium</td>
</tr>
</tbody>
</table>
</div>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<hr class="pagebreak"/>
<div id="IDX1" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">LOGISTIC MODEL (2):Unsafe=Weight Region Size</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">The LOGISTIC Procedure</p>
</div>
<div style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Model Information">
<caption aria-label="Model Information"></caption>
<colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">Model Information</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Data Set</th>
<td class="data">STAT1.SAFETY</td>
</tr>
<tr>
<th class="rowheader" scope="row">Response Variable</th>
<td class="data">Unsafe</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Response Levels</th>
<td class="data">2</td>
</tr>
<tr>
<th class="rowheader" scope="row">Model</th>
<td class="data">binary logit</td>
</tr>
<tr>
<th class="rowheader" scope="row">Optimization Technique</th>
<td class="data">Fisher&apos;s scoring</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX2" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Observations Summary">
<caption aria-label="Observations Summary"></caption>
<colgroup><col/><col/></colgroup>
<tbody>
<tr>
<th class="rowheader" scope="row">Number of Observations Read</th>
<td class="r data">96</td>
</tr>
<tr>
<th class="rowheader" scope="row">Number of Observations Used</th>
<td class="r data">96</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX3" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Response Profile">
<caption aria-label="Response Profile"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Response Profile</th>
</tr>
<tr>
<th class="r b header" scope="col">Ordered<br/>Value</th>
<th class="b header" scope="col">Unsafe</th>
<th class="r b header" scope="col">Total<br/>Frequency</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="data">0</td>
<td class="r data">66</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="data">1</td>
<td class="r data">30</td>
</tr>
</tbody>
</table>
<div class="proc_note_group">
<p class="c proctitle">Probability modeled is Unsafe=1.</p>
</div>
</div>
<div id="IDX4" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Class Level Information">
<caption aria-label="Class Level Information"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Class Level Information</th>
</tr>
<tr>
<th class="b header" scope="col">Class</th>
<th class="b header" scope="col">Value</th>
<th class="c b header" colspan="2" scope="colgroup">Design Variables</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Region</th>
<th class="rowheader" scope="row">Asia</th>
<td class="r data">0</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<th class="rowheader" scope="row">N America</th>
<td class="r data">1</td>
<td class="r data">&#160;</td>
</tr>
<tr>
<th class="rowheader" scope="row">Size</th>
<th class="rowheader" scope="row">1</th>
<td class="r data">1</td>
<td class="r data">0</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<th class="rowheader" scope="row">2</th>
<td class="r data">0</td>
<td class="r data">1</td>
</tr>
<tr>
<th class="rowheader" scope="row">&#160;</th>
<th class="rowheader" scope="row">3</th>
<td class="r data">0</td>
<td class="r data">0</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX5" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Convergence Status">
<caption aria-label="Convergence Status"></caption>
<colgroup><col/></colgroup>
<thead>
<tr>
<th class="c b header" scope="col">Model Convergence Status</th>
</tr>
</thead>
<tbody>
<tr>
<td class="c data">Convergence criterion (GCONV=1E-8) satisfied.</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX6" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Fit Statistics">
<caption aria-label="Fit Statistics"></caption>
<colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="3" scope="colgroup">Model Fit Statistics</th>
</tr>
<tr>
<th class="b header" scope="col">Criterion</th>
<th class="r b header" scope="col">Intercept Only</th>
<th class="r b header" scope="col">Intercept and Covariates</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">AIC</th>
<td class="r data">121.249</td>
<td class="r data">94.004</td>
</tr>
<tr>
<th class="rowheader" scope="row">SC</th>
<td class="r data">123.813</td>
<td class="r data">106.826</td>
</tr>
<tr>
<th class="rowheader" scope="row">-2 Log L</th>
<td class="r data">119.249</td>
<td class="r data">84.004</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX7" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Global Tests">
<caption aria-label="Global Tests"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Testing Global Null Hypothesis: BETA=0</th>
</tr>
<tr>
<th class="b header" scope="col">Test</th>
<th class="r b header" scope="col">Chi-Square</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Likelihood Ratio</th>
<td class="r data">35.2441</td>
<td class="r data">4</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Score</th>
<td class="r data">32.8219</td>
<td class="r data">4</td>
<td class="r data">&lt;.0001</td>
</tr>
<tr>
<th class="rowheader" scope="row">Wald</th>
<td class="r data">23.9864</td>
<td class="r data">4</td>
<td class="r data">&lt;.0001</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX8" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Type 3 Tests">
<caption aria-label="Type 3 Tests"></caption>
<colgroup><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Type 3 Analysis of Effects</th>
</tr>
<tr>
<th class="b header" scope="col">Effect</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Wald<br/>Chi-Square</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Weight</th>
<td class="r data">1</td>
<td class="r data">2.1176</td>
<td class="r data">0.1456</td>
</tr>
<tr>
<th class="rowheader" scope="row">Region</th>
<td class="r data">1</td>
<td class="r data">0.4506</td>
<td class="r data">0.5020</td>
</tr>
<tr>
<th class="rowheader" scope="row">Size</th>
<td class="r data">2</td>
<td class="r data">15.3370</td>
<td class="r data">0.0005</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX9" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Parameter Estimates">
<caption aria-label="Parameter Estimates"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="7" scope="colgroup">Analysis of Maximum Likelihood Estimates</th>
</tr>
<tr>
<th class="b header" scope="col">Parameter</th>
<th class="b header" scope="col"> &#160;</th>
<th class="r b header" scope="col">DF</th>
<th class="r b header" scope="col">Estimate</th>
<th class="r b header" scope="col">Standard<br/>Error</th>
<th class="r b header" scope="col">Wald<br/>Chi-Square</th>
<th class="r b header" scope="col">Pr&#160;&gt;&#160;ChiSq</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Intercept</th>
<th class="rowheader" scope="row">&#160;</th>
<td class="r data">1</td>
<td class="r data">0.0500</td>
<td class="r data">1.8008</td>
<td class="r data">0.0008</td>
<td class="r data">0.9778</td>
</tr>
<tr>
<th class="rowheader" scope="row">Weight</th>
<th class="rowheader" scope="row">&#160;</th>
<td class="r data">1</td>
<td class="r data" style="white-space: nowrap">-0.6678</td>
<td class="r data">0.4589</td>
<td class="r data">2.1176</td>
<td class="r data">0.1456</td>
</tr>
<tr>
<th class="rowheader" scope="row">Region</th>
<th class="rowheader" scope="row">N America</th>
<td class="r data">1</td>
<td class="r data" style="white-space: nowrap">-0.3775</td>
<td class="r data">0.5624</td>
<td class="r data">0.4506</td>
<td class="r data">0.5020</td>
</tr>
<tr>
<th class="rowheader" scope="row">Size</th>
<th class="rowheader" scope="row">1</th>
<td class="r data">1</td>
<td class="r data">2.6783</td>
<td class="r data">0.8810</td>
<td class="r data">9.2422</td>
<td class="r data">0.0024</td>
</tr>
<tr>
<th class="rowheader" scope="row">Size</th>
<th class="rowheader" scope="row">2</th>
<td class="r data">1</td>
<td class="r data">0.6582</td>
<td class="r data">0.9231</td>
<td class="r data">0.5085</td>
<td class="r data">0.4758</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX10" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="Association Statistics">
<caption aria-label="Association Statistics"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Association of Predicted Probabilities and Observed Responses</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Percent Concordant</th>
<td class="r data">81.9</td>
<th class="rowheader" scope="row">Somers&apos; D</th>
<td class="r data">0.696</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Discordant</th>
<td class="r data">12.3</td>
<th class="rowheader" scope="row">Gamma</th>
<td class="r data">0.739</td>
</tr>
<tr>
<th class="rowheader" scope="row">Percent Tied</th>
<td class="r data">5.8</td>
<th class="rowheader" scope="row">Tau-a</th>
<td class="r data">0.302</td>
</tr>
<tr>
<th class="rowheader" scope="row">Pairs</th>
<td class="r data">1980</td>
<th class="rowheader" scope="row">c</th>
<td class="r data">0.848</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX11" style="padding-bottom: 8px; padding-top: 1px">
<table class="table" style="border-spacing: 0" aria-label="95% Clodds=PL">
<caption aria-label="95% Clodds=PL"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Odds Ratio Estimates and Profile-Likelihood Confidence Intervals</th>
</tr>
<tr>
<th class="b header" scope="col">Effect</th>
<th class="r b header" scope="col">Unit</th>
<th class="r b header" scope="col">Estimate</th>
<th class="c b header" colspan="2" scope="colgroup">95% Confidence Limits</th>
</tr>
</thead>
<tbody>
<tr>
<th class="rowheader" scope="row">Weight</th>
<th class="r data">1.0000</th>
<td class="r data">0.513</td>
<td class="r data">0.201</td>
<td class="r data">1.260</td>
</tr>
<tr>
<th class="rowheader" scope="row">Region N America vs Asia</th>
<th class="r data">1.0000</th>
<td class="r data">0.686</td>
<td class="r data">0.225</td>
<td class="r data">2.081</td>
</tr>
<tr>
<th class="rowheader" scope="row">Size   1 vs 3</th>
<th class="r data">1.0000</th>
<td class="r data">14.560</td>
<td class="r data">3.018</td>
<td class="r data">110.732</td>
</tr>
<tr>
<th class="rowheader" scope="row">Size   2 vs 3</th>
<th class="r data">1.0000</th>
<td class="r data">1.931</td>
<td class="r data">0.343</td>
<td class="r data">15.182</td>
</tr>
</tbody>
</table>
</div>
<div id="IDX12" style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Odds Ratios with 95% Profile-Likelihood Confidence Limits" src="data:image/png;base64,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rShKy5Yt1bXy8vKGDRu2aNGizMxMV1fX119//cHtDeDeEcAAaiU/P7/qf/Tm5OSUl5f3448/BgQE+Pn52dvbv/fee+qiahutra1zcnKOHj3asmXLLVu2NG/eXG+DlpaWGo3GzMxs4sSJmzZt6tixo+5Sc3PzkJCQM2fOVFthbGxs7969Bw8ebG1t/cEHH+zdu7ewsPA+zBx4MAhgALXSokWL7Oxsvcbs7Gx7e/urV686OTmpLba2tuqDaht79OixevXqNWvWtGrVasqUKeXl5XobVH8D3rBhQ2VlZZ8+fdRGRVFWrlzp7e3t4OAQFBR0+/btaivMzs52dXVVH5uZmdnb22dlZd3TnIEHiQAGUCt9+/bNyMj49ddftS0VFRVbtmwJDAx0cnLS/o/o165dUx9U2yiEGDx4cGxs7OnTp5OTk7/66qtqx3r99de7dev297//XX0aFRW1du3axYsXp6WlGbjfysnJ6Y8//lAf37hx48qVK4/T/82OhocABlArdnZ2c+fOHTZsWHx8fElJyenTp4cPH96sWbORI0cGBQXt2bNn165dWVlZ//73v9X+1Tbu27dv6tSply9fNjIyMjMza9y4cU3DrV279vDhw1988YUQ4vLly506dfL09MzMzJw/f75665alpWVpaWl+fr52lUGDBh08eDAmJqawsPCf//xn37591b9TAh5RKSkpMv9LYgCPlQ0bNri7uzdu3NjBwWHixIlFRUVqe3R0tKura+vWrSMjI5955pmaGouLiydNmuTo6GhtbT1u3Ljbt29rt3zz5k3x1yVo1c8//2xlZXXu3LmsrKzu3btbWFj07t37u+++a968eXl5uaIoY8eONTY23rRpU/v27bWrdOzY0crKavDgwbm5uQ9nnwD1kJKSoklJSfHw8JD9NQAAgAYkNTWVS9AAAEhAAAMAIAEBDACABAQwAAASEMAAAEhAAAMAIAEBDACABAQwAAASEMAAAEhAAAMAIAEBDACABAQwAAASEMAAAEhgLIRITU2VXQYAAA3L/wcgMrKYNxyqmgAAAABJRU5ErkJggg=="/>
</div>
</div>
<div id="IDX13" style="padding-bottom: 8px; padding-top: 1px">
<div style="padding-bottom: 8px; padding-top: 1px">
<div class="c">
<img style="height: 480px; width: 640px" alt="Plot of Predicted Probabilities for Unsafe=1 by Weight, sliced by Region*Size." src="data:image/png;base64,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"/>
</div>
</div>
</div>
</div>
</body>
</html>




2. Do you reject or fail to reject the null hypothesis that all regression coefficients of the model are 0?

Solution:
The p-value for the Likelihood Ratio test is <.0001, and therefore, you reject the null hypothesis.

3. If you reject the global null hypothesis, then which predictors significantly predict safety outcome?

Solution:
Only Size is significantly predictive of Unsafe.

4. Interpret the odds ratio for significant predictors.

Solution:
Only Size is significant. The design variables show that Size=1 (Small or Sports) cars have 14.560 times the odds of having a Below Average safety rating compared to the reference category 3 (Large or Sport/Utility). The 95% confidence interval (3.018, 110.732) does not contain 1, implying that the contrast is statistically significant at the 0.05 level.

The contrast from the second design variable is 1.931 (Medium versus Sport/Utility), implying a trend toward greater odds of low safety as size decreases. However, the 95% confidence interval (0.343, 15.182) contains 1, and therefore, the contrast is not statistically significant.

#### Stepwise Selection with Interactions and Predictions
