CREATE DATABASE financial_loan;
USE financial_loan;
-- view database
select * from financial_loan
-- total loan applications
select count(id) as Total_Loan_Application from financial_loan;
select count(id) as MTD_Total_Loan_Application from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;
-- total funded amount
select sum(loan_amount) as Total_Funded_Amount from financial_loan;
select sum(loan_amount) as MTD_Total_Funded_Amount from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;
select sum(loan_amount) as PMTD_Total_Funded_Amount from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;
-- total payments
select sum(total_payment) as Total_Payments from financial_loan;
select sum(total_payment) as MTD_Total_Payments from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;
select sum(total_payment) as PMTD_Total_Payments from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;
-- average interest rate
select Round(avg(int_rate)*100,2) as AVG_Interest_Rate from financial_loan;
select Round(avg(int_rate)*100,2) as MTD_AVG_Interest_Rate from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

select Round(avg(int_rate)*100,2) as PMTD_AVG_Interest_Rate from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;
-- average DTI
select Round(avg(dti)*100,2) as AVG_DTI from financial_loan;
select Round(avg(dti)*100,2) as MTD_AVG_dti from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;
select Round(avg(dti)*100,2) as PMTD_AVG_dti from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;
-- loan status
-- total loan_status percentage 
select
	(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
    / count(id) as Good_loan_percentage
from financial_loan;
-- total no of good loans 
select count(id) as Good_loan_Application from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current';   
-- BAD LOANS
-- total loan_status percentage 
select
    (count(case when loan_status = 'Charged Off' then id end)*100)
    / count(id) as Bad_loan_percentage
from financial_loan;
-- total no of bad loans 
select count(id) as Bad_loan_Application from financial_loan
where loan_status = 'Charged Off';
-- bad loan funded amount
select sum(loan_amount) as Bad_loan_Funded_Amt from financial_loan
where loan_status = 'Charged Off';
-- bad loan total received amount
select sum(total_payment) as Bad_loan_Recevied_Amt from financial_loan
where loan_status = 'Charged Off';
-- LOAN STATUS GRID

select
        loan_status,
        COUNT(id) as Total_Loan_Application,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
from
        financial_loan
group by
        loan_status;
-- MTD Loan Status

select 
	loan_status, 
	sum(total_payment) as MTD_Total_Amount_Received, 
	sum(loan_amount) as MTD_Total_Funded_Amount 
from financial_loan
where month(issue_date) = 12 
group by loan_status;
-- insignts wrt to monthly trend
select
	month(issue_date) as Month_Number,
	monthname(issue_date) as Month_Name,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from financial_loan   
group by monthname(issue_date) ,month(issue_date)
order by month(issue_date);
-- insights wrt to addres state
select
	address_state,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from financial_loan   
group by address_state
order by address_state;
-- wrt to term

select
	term,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from financial_loan   
group by term
order by term;
-- wrt to employee length

select
	emp_length,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from financial_loan   
group by emp_length
order by count(id) desc;
-- wrt to purpose
select
	purpose,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from financial_loan
group by purpose
order by count(id) desc;
-- wrt to home ownership
select
	home_ownership,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from financial_loan  
group by home_ownership
order by count(id) desc;

              