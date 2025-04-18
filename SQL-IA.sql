create database insurance_analytics;
use insurance_analytics;
select * from fees;
select * from individualbudgets;
drop table fees;
select * from invoice;
select * from meeting;
select * from opportunity;
select * from brokerage;
commit;
select * from fees;
##1st QUESTION
desc invoice;
alter table invoice change `Account Executive` Account_Executive text;
alter table meeting change `Account Executive` Account_Executive text;
alter table opportunity change `Account Executive` Account_Executive text;
alter table fees change `Account Executive` Account_Executive text;
alter table brokerage change `Account Executive` Account_Executive text;
##1st question
SELECT  ACCOUNT_EXECUTIVE,COUNT(INVOICE_NUMBER) AS NUMBER_INVOICE FROM INVOICE
group by ACCOUNT_EXECUTIVE ORDER BY NUMBER_INVOICE DESC;
##2nd question
SELECT * FROM MEETING;
DESC MEETING;
set sql_safe_updates=0;
SELECT YEAR(MEETING_DATE) AS YEAR,COUNT(MEETING_DATE) AS MEETING_COUNT FROM MEETING
GROUP BY 1;
UPDATE MEETING
SET MEETING_DATE = STR_TO_DATE(MEETING_DATE, '%d-%m-%Y');
ALTER TABLE MEETING MODIFY MEETING_DATE DATE;

 ## Q.3.1 ##
 ALTER TABLE BROKERAGE CHANGE `ACCOUNT EXECUTIVE` ACCOUNT_EXECUTIVE TEXT;
 ALTER TABLE FEES CHANGE `ACCOUNT EXECUTIVE` ACCOUNT_EXECUTIVE TEXT;
 alter table individualbudgets change `Cross sell bugdet` cross_sell_budget text;
 alter table individualbudgets change `New Budget` New_budget text;
 alter table individualbudgets change `renewal budget` renewal_budget text;
## Q.4 ##
SELECT * FROM OPPORTUNITY;
SELECT STAGE, SUM(REVENUE_AMOUNT) FROM OPPORTUNITY
GROUP BY 1;

## Q.5 ##
SELECT * FROM OPPORTUNITY;
SELECT ACCOUNT_EXECUTIVE,COUNT(MEETING_DATE) FROM MEETING
group by 1;

##Q.6 ##
SELECT OPPORTUNITY_NAME,REVENUE_AMOUNT FROM OPPORTUNITY
  order by 2 DESC LIMIT 10;
desc individualbudgets;

## Q.3.1 ##

SELECT (SELECT SUM(cross_sell_budget) FROM individualbudgets ) AS target_cross_sell,         -- TARGET AND INVOICE AMOUNT OF CROSS SELL
(SELECT SUM(amount) 
     FROM invoice 
     WHERE income_class='cross sell')AS invoice_cross_sell;
     
     SELECT SUM(amount) AS Cross_Sell_achievement     -- ACHIEVEMENT AMOUNT OF CROSS SELL
FROM (
    SELECT amount FROM fees
    WHERE income_class='cross sell' 
    UNION ALL
    SELECT amount FROM brokerage
    WHERE income_class='cross sell' )as combined;

     ALTER TABLE INDIVIDUALBUDGETS CHANGE `NEW BUDGET` NEW_BUDGET TEXT;
     ALTER TABLE INDIVIDUALBUDGETS CHANGE `CROSS SELL BUGDET` CROSS_SELL_BUDGET TEXT;
	ALTER TABLE INDIVIDUALBUDGETS CHANGE `RENEWAL BUDGET` RENEWAL_BUDGET TEXT;
	SELECT * FROM INDIVIDUALBUDGETS;
	DESC INDIVIDUALBUDGETS;
      
	ALTER TABLE INDIVIDUALBUDGETS MODIFY NEW_BUDGET  INT;
UPDATE INDIVIDUALBUDGETS
SET NEW_BUDGET = 0
WHERE  NEW_BUDGET IS NULL OR NEW_BUDGET = '';
        ALTER TABLE INDIVIDUALBUDGETS MODIFY CROSS_SELL_BUDGET  INT;
        UPDATE INDIVIDUALBUDGETS
SET CROSS_SELL_BUDGET = 0
WHERE  CROSS_SELL_BUDGET IS NULL OR CROSS_SELL_BUDGET = '';
          ALTER TABLE INDIVIDUALBUDGETS MODIFY RENEWAL_BUDGET INT;
          UPDATE INDIVIDUALBUDGETS
SET RENEWAL_BUDGET = 0
WHERE  RENEWAL_BUDGET IS NULL OR RENEWAL_BUDGET = '';
          
      UPDATE INDIVIDUALBUDGETS
SET NEW_BUDGET = REPLACE(NEW_BUDGET, 'non_numeric_string', '')
WHERE NEW_BUDGET NOT REGEXP '^[0-9]+$';

UPDATE INDIVIDUALBUDGETS
SET NEW_BUDGET = 0
WHERE  NEW_BUDGET IS NULL OR NEW_BUDGET = '';


## Q.3.2 ##
	DESC FEES;
  SELECT  (SELECT SUM(new_budget) FROM INDIVIDUALBUDGETS) AS target_new,         -- TARGET AND INVOICE AMOUNT OF NEW
    (SELECT SUM(COALESCE(amount, 0)) 
     FROM invoice 
     WHERE income_class='new') AS invoice_new;
     
     
   SELECT SUM(amount) AS New_achievement  FROM                      -- ACHIEVEMENT AMOUNT OF NEW
 ( SELECT amount FROM fees
    WHERE income_class='new' 
    UNION ALL
    SELECT amount FROM brokerage
    WHERE income_class='new' )as combined;
     
## Q.3.3 ##
   SELECT (SELECT SUM(renewal_budget)                   -- TARGET AND INVOICE AMOUNT OF RENEWAL
    FROM INDIVIDUALBUDGETS) AS target_renewal,
    (SELECT SUM(COALESCE(amount, 0)) FROM invoice 
     WHERE income_class='renewal') AS invoice_renewal;
     
 SELECT
    SUM(amount) AS Renewal_achievement                 -- ACHIEVEMENT AMOUNT OF RENEWAL
FROM (
    SELECT amount  FROM fees
    WHERE income_class='renewal' 
    UNION ALL
    SELECT amount FROM brokerage
    WHERE income_class='renewal'  
)as combined;

select (13041253.3/20083111*100) as Cross_sell_Placed_Achievement;
select (2853842/20083111*100) as Cross_sell_Invoice_Achievement;

select (3531629.31/19673793*100) as New_Placed_Achievement;
select (569815/19673793*100) as New_Invoice_Achievement;

select(18507270.64/12319455*100) as Renewal_Placed_Achievemnt;
select(8244310/12319455*100) as Renewal_Invoice_Achievement;
