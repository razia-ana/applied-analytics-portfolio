# Applied Analytics Portfolio

Practical, business-focused analytics projects using Python, SQL/MySQL, and Tableau.

## Featured project

### SBA 7(a) Lending Portfolio Analysis

**Business question:** What can lending trends, borrower outcomes, geography, industry, and loan size tell us about the SBA 7(a) portfolio from fiscal years 2020–2025?

**Why it matters:** A lender or program manager can use these findings to understand funding patterns, monitor outcomes, and identify areas that deserve closer review.

**Tools:** Python (`pandas`, Jupyter), MySQL, Tableau, Git/GitHub

**Control totals:** 347,145 loan records, 347,145 unique record IDs, fiscal years 2020–2025, and $180.6 billion in gross approvals.

## What this project demonstrates

- Cleaning and validating a large public dataset
- Creating useful fields such as approval year, quarter, guarantee percentage, and outcome flags
- Writing SQL for loading, quality checks, grouping, ranking, and trend analysis
- Building Tableau dashboards for non-technical stakeholders
- Comparing results across Python, MySQL, and Tableau
- Documenting assumptions, limitations, and reproducibility steps

## Repository guide

| Folder | Contents |
|---|---|
| `notebooks/` | Python cleaning and exploratory analysis notebook |
| `sql/` | MySQL table setup and analytical queries |
| `tableau/` | Tableau packaged workbook (`.twbx`) |
| `data/` | Small sample dataset for repository browsing |
| `outputs/` | Audit report and Tableau-ready summary tables |
| `docs/` | Presentation and interview notes |

## How to reproduce the analysis

1. Open `notebooks/SBA_Loan_Analysis.ipynb` in Jupyter and run the cells from top to bottom.
2. Load the cleaned sample or full local dataset into MySQL and run the scripts in `sql/`.
3. Open `tableau/SBA_7a_Portfolio_Complete.twbx` in Tableau Public or Tableau Desktop.
4. Compare the row count, unique ID count, year range, and approval total with the audit report.

## Data note

The repository contains a 5,000-row sample because the full cleaned CSV is larger than GitHub's normal 100 MB single-file limit. The complete file is kept separately for local analysis. Use Git LFS or a release artifact if the full file must be hosted online.

## Data source

U.S. Small Business Administration 7(a) loan data. This repository is an educational portfolio project. Please review the source terms before redistributing the raw data.

## Planned projects

Additional folders will be added for future analytics projects, such as customer behavior, sales performance, operations, and public-sector data.

