# SBA 7(a) Lending: Tableau Client Presentation Guide

## Recommended source

Use `sba_7a_complete_fy_2020_2025.csv` for the presentation. It contains complete fiscal years only. Keep FY2026 out of year-over-year comparisons because the extract is partial.

## Tableau calculated fields

Create these calculated fields once:

```text
Approval Amount ($M) = SUM([GrossApproval]) / 1000000
Approval Count = COUNT([loan_record_id])
Average Loan Amount = AVG([GrossApproval])
SBA Guarantee Rate = SUM([SBAGuaranteedApproval]) / SUM([GrossApproval])
Charge-off Rate = SUM([charge_off_flag]) / COUNT([loan_record_id])
Paid-in-full Rate = SUM([paid_in_full_flag]) / COUNT([loan_record_id])
Average Jobs Supported = AVG([JobsSupported])
```

Format the two rate fields as percentages and the approval measure as currency.

## Dashboard 1: Executive overview

Purpose: answer “How large is the program, how is it changing, and where is activity concentrated?”

Place these KPI cards across the top:

- Total approval amount
- Number of loans
- Average loan amount
- SBA guarantee rate
- Charge-off rate

Add:

1. A line chart of approval amount by fiscal year.
2. A bar chart of the top 10 states by approval amount.
3. A status chart showing the loan-status mix.

Add filters for fiscal year, borrower state, bank name, and industry.

## Dashboard 2: Lending trend

Use a dual-axis or separate charts for:

- Loan count by fiscal year
- Total approval amount by fiscal year
- Average loan amount by fiscal year
- Average jobs supported by fiscal year

Add a parameter called `Trend metric` with values `Loan count`, `Approval amount`, `Average loan`, and `Jobs supported`. Use it to let the client change the trend measure without changing the dashboard.

Suggested client message: “The number of approvals and total dollars do not always move together, so we show both.”

## Dashboard 3: Geographic access

Create a filled map using `BorrState`.

Color: `Approval Amount ($M)`

Tooltip:

- State
- Loan count
- Approval amount
- Average loan amount
- Charge-off rate
- Paid-in-full rate

Place a ranked state table beside the map. Add a year filter so the audience can see whether geographic concentration changed.

## Dashboard 4: Lenders and concentration

Create:

1. Top 15 lenders by approval amount.
2. Top 15 lenders by loan count.
3. Scatter plot with loan count on the x-axis, average loan amount on the y-axis, and approval amount as size.

Use `BankName` as the detail field. Add a minimum-volume filter of 500 loans before interpreting charge-off rates. This prevents very small lenders from dominating the comparison.

## Dashboard 5: Industries and borrower profile

Create:

- Treemap of `NaicsDescription` by approval amount
- Bar chart of `BusinessType` by loan count
- Bar chart of `BusinessAge` by approval amount
- Table of the top industries with loan count, approval amount, average loan, and jobs supported

Keep the industry view limited to the top 15 categories for presentation readability.

## Dashboard 6: Loan outcomes and risk context

Create:

- Loan-status bar chart
- Charge-off amount by fiscal year
- Charge-off rate by state
- Charge-off rate by lender, with a 500-loan minimum
- Paid-in-full rate by business type

Add this footnote directly to the dashboard:

“Outcome rates are descriptive. Newer loans have had less time to reach paid-in-full or charge-off status, so they should not be interpreted as directly comparable performance cohorts.”

## Dashboard 7: Loan structure and program operations

Use the available operational fields:

- Processing method by fiscal year
- Fixed versus variable interest indicator
- Loan term distribution
- Collateral indicator
- Sold-to-secondary-market indicator
- Average interest rate by processing method

This dashboard explains how the program is being used, not only how many dollars were approved.

## Recommended story sequence

Create a Tableau Story with these points:

1. **Program scale:** how many loans and dollars were approved.
2. **Change over time:** whether volume and dollar approvals increased or decreased.
3. **Geographic reach:** which states received the most support.
4. **Lender concentration:** which institutions are most active.
5. **Business reach:** which industries and business types received funding.
6. **Loan outcomes:** how statuses and charge-offs are distributed.
7. **Actions for discussion:** where a lender, policymaker, or program manager may want deeper review.

## Presentation language

Use “approval amount” rather than “economic impact.” Use “charge-off rate” rather than “lender quality.” Use “descriptive pattern” rather than “cause.” The dataset shows approved loans and recorded statuses; it does not prove that lending caused employment or business growth.

## Final quality checks before presenting

- Confirm every dashboard is filtered to FY2020–FY2025.
- Check that dollar fields are formatted in millions or billions consistently.
- Verify that totals match the clean CSV: 347,145 rows and approximately $180.6 billion in gross approvals.
- Exclude borrower names and street addresses from client-facing views.
- Use a visible “Data through FY2025” subtitle.
- Keep detailed tables in a separate worksheet so the main dashboard remains readable.
