
create database claims_db;
use claims_db;

create table claims(
claim_id VARCHAR(20),
customer_id VARCHAR(20),
policy_id VARCHAR(20),
hospital_id VARCHAR(20),
claim_amount INT,
claim_status VARCHAR(20),
diseaese_category VARCHAR(20),
days_hospitalized INT,
fraud_flag INT,
claim_date date,
stage VARCHAR(20),
submitted_timestamp datetime,
verified_timestamp datetime,
approved_timestamp datetime,
paid_timestamp datetime,
premium_amount INT
);
load data local infile 'C:/Business-Data-Projects/StarHealth/fraud_detection/data/claims_full_dataset.csv'
INTO TABLE claims FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

select * from claims;

create table customers(
customer_id VARCHAR(10),
age INT,
gender VARCHAR(10),
city VARCHAR(10),
income_band VARCHAR(10)
);

load data local infile 'C:/Business-Data-Projects/StarHealth/fraud_detection/data/customers_full_dataset.csv'
INTO TABLE customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

select * from customers;

create table hospitals(
hospital_id VARCHAR(10),
hospital_name VARCHAR(10),
hospital_city VARCHAR(10),
network_hospital VARCHAR(10)
);

load data local infile 'C:/Business-Data-Projects/StarHealth/fraud_detection/data/hospitals_full_dataset.csv'
INTO TABLE hospitals FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

select * from hospitals;
select * from claims;

-- 1. fraud rate :  fraud_claims/total_claims
select round(100 *sum(case when fraud_flag =1 then 1 else 0 end)/count(*), 2) as fraud_rate from claims;

-- 2. fraud loss amount : sum(claim_amount when fraud_flag=1)
select round(sum(claim_amount),2) as fraud_loss_amount from claims where  fraud_flag =1 ;

-- 3. claim ratio : total claims paid/ total premium_amount received
 select round(100 * sum( case when claim_status IN('Paid', 'Approved') then claim_amount else 0 end)/sum(premium_amount), 2) as claim_ratio from claims;

-- 4. loss ratio :  total claims paid + operating-cost/ total premium_amount received, assume operating-cost = 10 % premium amount
select round(100 * (SUM(case when claim_status IN ('Paid', 'Approved') then claim_amount else 0 end) + 0.10* SUM(premium_amount))/ SUM(premium_amount), 2) 
as loss_ratio from claims;

-- 5. Successful settlement rate = Approved claims / Submitted claims -> Approved claims/ Total claims 
-- In out dataset every claim is a submitted claim
select round(100 * SUM(case when claim_status IN('Paid', 'Approved') then 1 else 0 end)/count(*), 3) as successful_settlement_rate from claims;

-- 6.  Leakage Rate =  Fraud Paid Amount​/Total Paid Claim Amount ×100

select round(100* sum(case when fraud_flag =1 and claim_status = 'Paid' then claim_amount else 0 end)/sum(case when claim_status ='Paid' then claim_amount else 0 end) 
,2) as leakage_rate from claims;

-- 7. Top suspicious hospitals
select hospital_id,  SUM(claim_amount) as fraud_claim from claims where fraud_flag=1 and claim_status IN ('Approved', 'Paid')  group by hospital_id order by 
fraud_claim desc;

-- 8 . Top suspicious customers
select customer_id,  SUM(claim_amount) as fraud_claim from claims where fraud_flag=1 and claim_status IN ('Approved', 'Paid')  group by  customer_id order by 
fraud_claim desc;

 
 