# E-Commerce Sales Analysis

## Project Overview
This project focuses on analyzing e-commerce sales data using Python, SQL, and MySQL. The objective is to identify sales trends, customer behavior, product performance, and payment patterns.

## Technologies Used
- Python
- MySQL
- SQL
- Pandas
- NumPy
- Matplotlib

## Project Structure
```text
ecommerce-sales-analysis/
│
├── data/
├── visualizations/
├── analysis.py
├── mysql_analysis.py
├── mysql_test.py
├── onlinestore.sql
├── sql_analysis.sql
├── dashboard.pbix
├── PROJECT_REPORT.md
├── requirements.txt
└── README.md


## Key Analysis
1. Customer and Orders Analysis using INNER JOIN
2. Category-wise Revenue Analysis
3. Payment Status Analysis
4. Customer-wise Order Analysis using HAVING
5. Above Average Orders using Subquery
6. Order Value Classification using CASE
7. Month-wise Sales Analysis
8. Customer and Orders Analysis using LEFT JOIN

## Python Analysis
- Data cleaning using Pandas
- Duplicate and missing value checks
- Descriptive statistics
- Revenue analysis
- Monthly sales analysis
- Data visualization using Matplotlib

## SQL Analysis
- Joins
- GROUP BY
- ORDER BY
- Aggregate Functions
- HAVING
- Subqueries
- CASE Statements
- Date Functions

## How to Run

### 1. Clone or download the project
Download the repository and open the project folder in VS Code.

### 2. Install dependencies
```bash
pip install -r requirements.txt
pip install mysql-connector-python
```

### 3. Setup MySQL
- Open MySQL Workbench.
- Execute `onlinestore.sql`.
- Verify that all seven tables are created.

### 4. Key Results

- Total Sales: ₹2,34,186
- Total Orders: 10
- Average Order Value: ₹23,418.60
- Top Revenue Category: Mobiles
- Mobiles Revenue: ₹1,39,998

Note: Results are based on the sample dataset included in this project.

### 5. Run Python Analysis
```bash
python analysis.py
```

### 6. Run MySQL Connection Test
```bash
python mysql_test.py
```

### 7. Run Python and MySQL Analysis
```bash
python mysql_analysis.py
```

## Project Outcomes
- Analyzed e-commerce sales and revenue.
- Identified top-performing product categories.
- Examined customer orders and payment status.
- Created visualizations to understand sales patterns.

## Author
Data Analytics Project | Python | SQL | MySQL
