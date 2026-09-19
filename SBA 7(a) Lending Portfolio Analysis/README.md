# Applied Analytics Portfolio

This repository contains practical data-analysis projects built with Python, SQL/MySQL, and Tableau. The first project is an SBA 7(a) loan portfolio analysis for fiscal years 2020–2025. More projects can be added as new top-level folders, such as `customer-churn/`, `sales-analysis/`, or `public-health/`.

## Current project: SBA 7(a) loan portfolio analysis

- `notebooks/SBA_Loan_Analysis.ipynb` — Python cleaning and analysis
- `sql/SBA_Lending_Requirement_Analysis.sql` — MySQL table and analysis queries
- `sql/sba_7a_analysis.sql` — supporting SQL analysis script
- `tableau/SBA_7a_Portfolio_Complete.twbx` — Tableau workbook
- `data/sba_7a_complete_fy_2020_2025_sample.csv` — 5,000-row sample for easy repository browsing
- `outputs/` — audit report and summary tables used by Tableau
- `docs/` — presentation guide and notes

## Quick start

1. Open the notebook in Jupyter and run the cells from top to bottom.
2. Create a MySQL database and run the SQL script. Update the CSV path for your computer.
3. Open the `.twbx` file in Tableau Public or Tableau Desktop.
4. Use the audit report to compare row counts, years, unique IDs, and total approved dollars.

## Audit control totals

- Rows: 347,145
- Unique loan records: 347,145
- Fiscal years: 2020–2025
- Total gross approval: $180,601,190,600.00

The complete cleaned CSV is provided in the separate ZIP package. It is larger than GitHub's normal 100 MB single-file limit, so this GitHub repository uses a 5,000-row sample. If you later need the full file online, use Git LFS or a GitHub release/artifact.

## Data source

U.S. Small Business Administration 7(a) loan data. This project is for learning and portfolio demonstration; confirm the source terms before redistributing the raw data.

