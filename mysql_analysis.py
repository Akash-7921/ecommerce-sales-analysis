from dotenv import load_dotenv
import os

load_dotenv()
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=os.getenv("MYSQL_PASSWORD"),
    database="onlinestore"
)

query = """
SELECT
    o.order_id,
    c.f_name,
    c.l_name,
    o.order_date,
    o.total_amount
FROM orders o
INNER JOIN customer c
ON o.cust_id = c.cust_id;
"""

df = pd.read_sql(query, conn)

print(df.head(10))
print("\nTotal Sales:")
print(df["total_amount"].sum())

print("\nAverage Order Value:")
print(df["total_amount"].mean())

print("\nTotal Orders:")
print(df["order_id"].nunique())

print("\nTop 5 Orders:")
print(df.nlargest(5, "total_amount")[
    ["order_id", "f_name", "total_amount"]
])

category_query = """
SELECT
    c.category_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
JOIN product p
    ON oi.product_id = p.product_id
JOIN category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
"""

category_df = pd.read_sql_query(category_query, conn)

print("\nCategory-wise Revenue:")
print(category_df)
plt.figure(figsize=(10, 6))

plt.bar(
    category_df["category_name"],
    category_df["total_revenue"]
)

plt.title("Category-wise Revenue Analysis")
plt.xlabel("Product Category")
plt.ylabel("Total Revenue")
plt.xticks(rotation=45)

plt.tight_layout()

plt.savefig("visualizations/category_revenue.png")
plt.show()
df["order_date"] = pd.to_datetime(df["order_date"])

df["month"] = df["order_date"].dt.to_period("M")

monthly_sales = df.groupby("month")["total_amount"].sum()

print("\nMonth-wise Sales:")
print(monthly_sales)

plt.figure(figsize=(10, 5))

monthly_sales.plot(kind="line", marker="o")

plt.title("Monthly Sales Analysis")
plt.xlabel("Month")
plt.ylabel("Total Sales")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig("visualizations/monthly_sales.png")
plt.show()
payment_query = """
SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payment
GROUP BY payment_status;
"""

payment_df = pd.read_sql_query(payment_query, conn)

print("\nPayment Status Analysis:")
print(payment_df)

plt.figure(figsize=(7, 5))

plt.pie(
    payment_df["total_payments"],
    labels=payment_df["payment_status"],
    autopct="%1.1f%%"
)

plt.title("Payment Status Distribution")
plt.savefig("visualizations/payment_status.png")
plt.show()
conn.close()