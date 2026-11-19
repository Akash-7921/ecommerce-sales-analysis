# Short Project Report

## Project
E-commerce Sales Analysis using MySQL, Python, and Power BI.

## Dataset summary
- Customers: 10
- Products: 10
- Categories: 6
- Orders: 10
- Order-item records: 16
- Payment records: 10

## Key sample metrics
- Order value total from the orders table: ₹234,186.00
- Average order value: ₹23,418.60
- Paid payment records: 8
- Pending payment records: 2
- Highest line-revenue category based on order-item prices: Mobiles (₹139,998.00)

## Important data quality note
The sample includes mismatches between some item prices, catalogue prices and order totals. Revenue by category is calculated from order-item price × quantity, while total order value uses the orders table. These metrics may not reconcile until the source data is corrected.

## Conclusion
The project shows how SQL tables can be combined into an analysis-ready dataset, checked with Pandas, and explored through charts and a Power BI dashboard. Since the dataset is synthetic and small, results are suitable for demonstrating the workflow rather than making operational decisions.
