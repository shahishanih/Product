FILENAME ISHANI '/folders/myfolders/ishani/WorksheetForFinalProjectCaseStudy_C-SAS.xls';
* 1.Import the data of product file in SAS environment and create a Product Dataset ; 
PROC IMPORT DATAFILE=ISHANI
	DBMS=XLS replace
	OUT=WORK.Product;
	GETNAMES=YES;
RUN;


*2. Import only those records where Category is Fruit and Country is United States;

proc print data=Product;
where category ="Fruit" and country="United States";
run;


*3. Create a frequency table to display Country based Product information;
proc freq data=Product;
tables country*product;
run;


*4. Create a new Dataset which should have only those products which were ordered on or before 31st March 2012;
data new_product;
set work.product;
where Date <="31MAR2012"d;
run;


*5. Find out the countries which have highest and lowest Amount;
proc sql;
select country, amount
from product
where amount=(select min(amount)from product)
or amount=(select max(amount)from product);
quit;


*6. Write SAS code to create a report to have Country wise Category based sum of Amount;
proc means data=product sum;
var amount;
class Country Category;
run;

*/7. Create a new Dataset which should have a new variable Discount. Discount should be given as follows
8. If Amount is greater than $5000, Discount is 10% of the Amount
9. Else Discount is 5% of the Amount;
data new_product;
set product;
if amount>5000
then 
discount=0.15*amount ;
else
discount=0.05*amount;
run;


*10. Write a SAS code to create a new Dataset for every unique Country and it should have data of that specific countryproc sql;

proc sql;
select distinct country
from product;
quit;

data Aus Can Fra Ger NZ UK US;
set product;
if country="Australia"
then output Aus;
else if country="Canada"
then output Can;
else if country="France"
then output Fra;
else if country="Germany"
then output Ger;
else if country="New Zealand"
then output NZ;
else if country="United Kingdom"
then output UK;
else if country="United States" 
then output US;
run;

proc print data=aus;
run;