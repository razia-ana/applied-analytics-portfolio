-- SBA 7(a) analysis queries for sba_7a_complete_fy_2020_2025.csv
-- Import the cleaned CSV into a table named sba_loans before running these queries.

CREATE DATABASE IF NOT EXISTS sba_lending;
USE sba_lending;

-- Create this table before using MySQL Workbench's Table Data Import Wizard.
CREATE TABLE IF NOT EXISTS sba_loans (
    loan_record_id INT PRIMARY KEY,
    AsOfDate DATE,
    Program VARCHAR(10),
    LocationID VARCHAR(20),
    BorrName VARCHAR(255),
    BorrStreet VARCHAR(255),
    BorrCity VARCHAR(100),
    BorrState VARCHAR(10),
    BorrZip VARCHAR(20),
    BankName VARCHAR(255),
    BankFDICNumber VARCHAR(20),
    BankNCUANumber VARCHAR(20),
    BankStreet VARCHAR(255),
    BankCity VARCHAR(100),
    BankState VARCHAR(10),
    BankZip VARCHAR(20),
    GrossApproval DECIMAL(15,2),
    SBAGuaranteedApproval DECIMAL(15,2),
    ApprovalDate DATE,
    ApprovalFY INT,
    FirstDisbursementDate DATE,
    ProcessingMethod VARCHAR(100),
    InitialInterestRate DECIMAL(8,4),
    FixedorVariableInterestInd VARCHAR(10),
    TermInMonths INT,
    NaicsCode VARCHAR(20),
    NaicsDescription VARCHAR(255),
    FranchiseCode VARCHAR(30),
    FranchiseName VARCHAR(255),
    ProjectCounty VARCHAR(100),
    ProjectState VARCHAR(10),
    SBADistrictOffice VARCHAR(150),
    CongressionalDistrict VARCHAR(20),
    BusinessType VARCHAR(50),
    BusinessAge VARCHAR(100),
    LoanStatus VARCHAR(30),
    PaidInFullDate DATE,
    ChargeOffDate DATE,
    GrossChargeOffAmount DECIMAL(15,2),
    RevolverStatus VARCHAR(10),
    JobsSupported INT,
    CollateralInd VARCHAR(10),
    SoldSecMrktInd VARCHAR(10),
    approval_year INT,
    approval_month INT,
    approval_quarter INT,
    guarantee_pct DECIMAL(10,6),
    charge_off_flag TINYINT,
    paid_in_full_flag TINYINT
);

-- 1. Basic quality check
SELECT
    COUNT(*) AS rows_loaded,
    COUNT(DISTINCT loan_record_id) AS unique_record_ids,
    MIN(ApprovalFY) AS first_fiscal_year,
    MAX(ApprovalFY) AS last_fiscal_year,
    MIN(GrossApproval) AS smallest_approval,
    MAX(GrossApproval) AS largest_approval
FROM sba_loans;

-- 2. Python annual_summary equivalent
SELECT
    ApprovalFY,
    COUNT(*) AS loan_count,
    SUM(GrossApproval) AS total_approval,
    ROUND(AVG(GrossApproval), 2) AS average_loan_amount,
    ROUND(100 * AVG(charge_off_flag), 2) AS charge_off_rate_pct,
    ROUND(100 * AVG(paid_in_full_flag), 2) AS paid_in_full_rate_pct
FROM sba_loans
GROUP BY ApprovalFY
ORDER BY ApprovalFY;

-- 3. Annual growth in total approved dollars
WITH annual AS (
    SELECT ApprovalFY, SUM(GrossApproval) AS total_approval
    FROM sba_loans
    GROUP BY ApprovalFY
)
SELECT
    ApprovalFY,
    total_approval,
    LAG(total_approval) OVER (ORDER BY ApprovalFY) AS prior_year_approval,
    ROUND(
        100 * (total_approval - LAG(total_approval) OVER (ORDER BY ApprovalFY))
        / NULLIF(LAG(total_approval) OVER (ORDER BY ApprovalFY), 0), 2
    ) AS approval_growth_pct
FROM annual
ORDER BY ApprovalFY;

-- 4. Top states by total approved dollars
SELECT
    BorrState,
    COUNT(*) AS loan_count,
    SUM(GrossApproval) AS total_approval,
    ROUND(AVG(GrossApproval), 2) AS average_loan_amount,
    ROUND(100 * AVG(charge_off_flag), 2) AS charge_off_rate_pct
FROM sba_loans
GROUP BY BorrState
ORDER BY total_approval DESC
LIMIT 10;

-- 5. Top lenders by total approved dollars
SELECT
    BankName,
    COUNT(*) AS loan_count,
    SUM(GrossApproval) AS total_approval,
    ROUND(AVG(GrossApproval), 2) AS average_loan_amount,
    ROUND(100 * AVG(charge_off_flag), 2) AS charge_off_rate_pct
FROM sba_loans
GROUP BY BankName
ORDER BY total_approval DESC
LIMIT 10;

-- 6. Top industries by total approved dollars
SELECT
    NaicsDescription,
    COUNT(*) AS loan_count,
    SUM(GrossApproval) AS total_approval,
    ROUND(AVG(GrossApproval), 2) AS average_loan_amount
FROM sba_loans
WHERE NaicsDescription IS NOT NULL
GROUP BY NaicsDescription
ORDER BY total_approval DESC
LIMIT 10;

-- 7. Loan outcome mix
SELECT
    LoanStatus,
    COUNT(*) AS loan_count,
    SUM(GrossApproval) AS total_approval,
    ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM sba_loans), 2) AS loan_share_pct
FROM sba_loans
GROUP BY LoanStatus
ORDER BY loan_count DESC;

-- 8. Lender risk comparison. A minimum of 500 loans avoids tiny samples.
SELECT
    BankName,
    COUNT(*) AS loan_count,
    ROUND(100 * AVG(charge_off_flag), 2) AS charge_off_rate_pct,
    SUM(GrossChargeOffAmount) AS total_charge_off_amount
FROM sba_loans
GROUP BY BankName
HAVING COUNT(*) >= 500
ORDER BY charge_off_rate_pct DESC;

-- 9. Year-by-year state trend for the largest states
SELECT
    ApprovalFY,
    BorrState,
    COUNT(*) AS loan_count,
    SUM(GrossApproval) AS total_approval
FROM sba_loans
WHERE BorrState IN ('CA', 'TX', 'FL', 'GA', 'NY')
GROUP BY ApprovalFY, BorrState
ORDER BY ApprovalFY, total_approval DESC;

-- 10. Charge-off detail
SELECT
    LoanStatus,
    COUNT(*) AS loan_count,
    SUM(GrossChargeOffAmount) AS total_charge_off_amount,
    AVG(GrossChargeOffAmount) AS average_charge_off_amount
FROM sba_loans
GROUP BY LoanStatus
ORDER BY total_charge_off_amount DESC;
