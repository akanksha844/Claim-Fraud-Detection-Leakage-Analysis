# Claim-Fraud-Detection-Leakage-Analysis
Worked on a health insurance fraud detection problem where fraud claims were increasing claim ratio and loss ratio.
# Health Insurance Claim Fraud Detection & Leakage Analysis

An end-to-end analytics project to detect fraudulent health insurance claims, quantify financial leakage, and recommend a machine learning–driven fraud prevention strategy using **SQL, Python, Machine Learning(Random Forest) and Tableau**.

---

# Project Summary

Health insurance companies process thousands of claims every month. Even a relatively small share of fraudulent claims can significantly inflate:

* Claim Ratio
* Loss Ratio
* Fraud Loss Amount
* Settlement Leakage

In this project, I built a complete fraud analytics solution to identify suspicious hospitals and customers, analyze where fraud leaks through the claims workflow, and prioritize high-risk claims using machine learning.

The final output includes three interactive Tableau dashboards and actionable business recommendations to reduce fraud and improve underwriting profitability.

---

# Business Problem

The insurer observed rising claim payouts and deteriorating profitability.

# Key Business Questions

1. Which hospitals are contributing disproportionately to fraud?
2. Which customers repeatedly submit suspicious claims?
3. At which stage are fraudulent claims getting approved?
4. Which diseases and cities drive the highest fraud exposure?
5. Can machine learning improve fraud detection before payment?

---

# Tech Stack

| Layer                            | Tools Used                         |
| -------------------------------- | ---------------------------------- |
| Data Extraction & KPI Analysis   | SQL                                |
| Exploratory & Advanced Analytics | Python (Pandas, NumPy, Matplotlib) |
| Machine Learning                 | Scikit-learn Random Forest         |
| Data Visualization               | Tableau                            |
| Version Control                  | Git & GitHub                       |

---

# Dataset Overview

This project uses three datasets:

### `claims.csv`

Claim-level transaction data:

* claim id
* customer id
* policy id
* hospital id
* claim amount
* claim status
* disease category
* days hospitalized
* fraud flag
* claim_date
* stage
* submitted timestamp
* verified timestamp
* approved timestamp
* paid timestamp
* premium amount


### `customers.csv`

Customer attributes:
* customer id
* age
* gender
* city
* income_band

### `hospitals.csv`

Hospital metadata:
* hospital id
* hospital name
* hospital city
* network hospital
* onboarding date


---

# 📊 SQL KPI Analysis

I first used SQL to calculate business-critical metrics and identify suspicious entities.

## Core KPIs

| KPI                        |        Value |
| -------------------------- | -----------: |
| Total Claims               |        2,120 |
| Fraud Claims               |          223 |
| Fraud Rate                 |       10.52% |
| Fraud Loss Amount          | ₹1,60,78,534 |
| Avg Fraud Claim            |      ₹72,101 |
| Leakage Rate               |       46.64% |
| Claim Ratio                |       69.12% |
| Loss Ratio                 |       79.12% |
| Successful Settlement Rate |       52.22% |

---

## Top Suspicious Hospitals (by Fraud Loss)

| Hospital ID | Fraud Loss |
| ----------- | ---------: |
| HOSP030     |  ₹4,33,414 |
| HOSP040     |  ₹4,14,750 |
| HOSP096     |  ₹4,13,360 |
| HOSP039     |  ₹3,57,585 |
| HOSP082     |  ₹3,53,279 |

---

## Top Suspicious Customers (by Fraud Loss)

| Customer ID | Fraud Loss |
| ----------- | ---------: |
| CUST0113    |  ₹3,38,836 |
| CUST0108    |  ₹3,31,132 |
| CUST0490    |  ₹3,29,703 |
| CUST0308    |  ₹3,01,154 |
| CUST0012    |  ₹2,96,769 |

---

# Python Analysis

## 1. Exploratory Data Analysis (EDA)

Validated:

* Fraud distribution
* Fraud loss by disease
* Fraud rate by hospital city

---

## 2. Funnel Analysis

Claims funnel:

* Submitted
* Document Verified
* Approved
* Paid

### Key Finding

**46.64% of suspicious claims were still approved**, indicating substantial process leakage.

---

## 3. Cohort Analysis

Analyzed fraud by:

* Claim Month
* Hospital Onboarding Month

### Key Finding

Recently onboarded hospitals showed materially higher fraud rates.

Example:

* April 2025 hospital cohort → **16.16% fraud rate**
* Fraud loss → **₹13.5 lakh**

---

## 4. Retention Analysis

Measured repeat fraud behavior within:

* 30 days
* 60 days
* 90 days

### Key Finding

104 of 108 repeat fraud customers (96%+) submitted another suspicious claim within 30 days.

---

# Machine Learning Model

## Model Used

### Random Forest Classifier

### Why Random Forest?

* Handles nonlinear fraud patterns
* Works well with mixed categorical and numeric features
* Robust to overfitting
* Provides fraud probabilities for risk scoring

---

## Features Used

* claim_amount
* claim_per_day
* days_hospitalized
* customer_age
* previous_claim_count
* disease_category
* policy_type
* network_hospital
* hospital_city
* agent_channel

---

## Model Performance

| Metric            | Value |
| ----------------- | ----: |
| Accuracy          |   94% |
| Precision (Fraud) |   88% |
| Recall (Fraud)    |   52% |
| ROC-AUC           | 0.784 |

---

## Fraud Risk Segmentation

| Risk Segment | Action                     |
| ------------ | -------------------------- |
| Low Risk     | Auto-approve               |
| Medium Risk  | Additional validation      |
| High Risk    | Manual fraud investigation |

Example:

* Claim `CLM00005` received a fraud probability of 96% and was categorized as High Risk.

---

# Tableau Dashboards

## 1. Executive Fraud Overview

Provides a one-page summary of fraud exposure and profitability.

### KPIs

* Total Claims
* Fraud Claims
* Fraud Rate
* Fraud Loss Amount
* Avg Fraud Claim
* Leakage Rate
* Claim Ratio
* Loss Ratio

### Key Visuals

* Fraud vs Non-Fraud Claims  
* Fraud Loss by Disease   
* Fraud Rate by Hospital City 

---

## 2. Suspicious Hospital & Customer Deep Dive

* Top suspicious hospitals
* Top suspicious customers
* Average claim per day
* Fraud rate by network status

---

## 3. Funnel, Cohort & ML Risk Dashboard

* Claims funnel
* Fraud leakage by stage
* Hospital onboarding cohort heatmap
* ML risk segmentation

---

# 📈 Executive Dashboard Insights

Based on the Tableau dashboard:

### Fraud Distribution

* 223 out of 2,120 claims were flagged as suspicious.
* Fraud Rate = **10.52%**

### Financial Exposure

* Total fraud loss = **₹1.61 Cr**

### Disease-Level Insight

* **Cancer** generated the highest fraudulent payouts:

  * **₹36.36 lakh**

### Geographic Hotspot

* **Bengaluru** had the highest city-level fraud rate:

  * **13.27%**

### Process Leakage

* Nearly half of suspicious claims were still approved.

---

#  Key Business Findings

1. Fraud affects approximately 1 in 10 claims.
2. Suspicious claims represent ₹1.61 Cr in financial exposure.
3. 46.64% leakage indicates weaknesses in current approval controls.
4. Cancer and Cardiac claims account for the highest fraud loss.
5. Bengaluru and Jaipur are key fraud hotspots.
6. Recently onboarded hospitals exhibit elevated fraud rates.
7. Repeat fraud occurs rapidly, usually within 30 days.

---

#  Business Recommendations

## Operational Recommendations

* Route High Risk claims to manual review.
* Auto-approve Low Risk claims.
* Monitor new hospitals for the first 90 days.
* Trigger alerts for repeat suspicious claims within 30 days.
* Strengthen controls for Cancer and Cardiac claims.

## Product Recommendations

* Build a real-time fraud risk score API in the claims workflow.
* Create investigator queues sorted by fraud probability.
* Develop provider and customer risk profiles.
* Implement SLA monitoring for manual review turnaround.

---

#  A/B Testing Recommendation

### Variant A: Current Rule Engine

* Static thresholds
* Manual reviews

### Variant B: ML-Based Fraud Scoring

* Fraud probability
* Repeat fraud behavior
* Hospital risk patterns

### Success Metrics

* Fraud caught rate
* False positive rate
* Approval turnaround time
* Fraud loss reduction

---

# 📈 Expected Impact

| Metric              | Current | Target |
| ------------------- | ------: | -----: |
| Fraud Caught Rate   |     62% |    78% |
| Approval Time       |  18 hrs | 12 hrs |
| False Positive Rate |     14% |    10% |
| Fraud Loss Amount   |    ₹50L |   ₹32L |

---

#  Summary

> Built an end-to-end health insurance fraud detection and leakage analysis solution using SQL, Python, Random Forest, and Tableau. Identified ₹1.61 Cr in suspicious payouts, found that 46.64% of fraudulent claims were still approved, uncovered repeat fraud patterns within 30 days, and developed an ML-based fraud scoring model to prioritize high-risk claims before payment.

---

## Author

**Akanksha Sharma**
Business Analyst | Data Analyst | Product Analyst
SQL • Python • Machine Learning • Tableau • Product Analytics
