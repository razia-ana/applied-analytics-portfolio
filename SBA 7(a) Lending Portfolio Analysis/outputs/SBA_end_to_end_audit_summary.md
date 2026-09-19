# SBA 7(a) End-to-End Audit

Audit date: 2026-09-18

## Result: GREEN LIGHT

The Python notebook, cleaned CSV, live MySQL table, and Tableau workbook are synchronized on the audited control totals. The missing MySQL partition was identified by loan-record ID bucket and loaded in four smaller pieces to avoid Workbench timeouts.

## Automated checks

- Python notebook: all 17 code cells executed successfully after correction.
- Clean CSV: 347,145 rows, fiscal years 2020–2025, total GrossApproval $180,601,190,600.
- Live MySQL: 347,145 rows, 347,145 unique loan_record_id values, fiscal years 2020–2025, total GrossApproval $180,601,190,600.
- Tableau summary CSVs: all five tested summaries match the clean CSV (maximum numerical difference below 1e-6).
- Tableau TWBX: valid package; contains the SBA CSV datasource, Hyper extract, five dashboards, and the expected SBA fields.
- SQL script: contains database/table DDL, quality checks, annual analysis, growth, state, lender, industry, outcome, risk, trend, and charge-off queries.

## Final control totals

```
rows = 347,145
unique loan_record_id = 347,145
years = 2020–2025
total GrossApproval = 180,601,190,600
```
