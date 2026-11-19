from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data"
OUT = ROOT / "visualizations"
OUT.mkdir(exist_ok=True)

def load(name):
    return pd.read_csv(DATA / f"{name}.csv")

customers = load("customer")
categories = load("category")
products = load("product")
orders = load("orders")
items = load("order_items")
invoices = load("invoice")
payments = load("payment")

# Data inspection and basic cleaning
for name, df in [("customers", customers), ("products", products), ("orders", orders),
                 ("order_items", items), ("payments", payments)]:
    print(f"\\n{name}: rows={len(df)}, duplicate rows={df.duplicated().sum()}")
    print(df.isna().sum())

for df in [customers, categories, products, orders, items, invoices, payments]:
    df.drop_duplicates(inplace=True)

orders["order_date"] = pd.to_datetime(orders["order_date"], errors="coerce")
items["quantity"] = pd.to_numeric(items["quantity"], errors="coerce")
items["price"] = pd.to_numeric(items["price"], errors="coerce")
products["price"] = pd.to_numeric(products["price"], errors="coerce")
products["stock"] = pd.to_numeric(products["stock"], errors="coerce")

# Create an analysis-ready order-line table from the relational CSV files
analysis = (items.merge(orders, on="order_id", how="left")
    .merge(customers, on="cust_id", how="left")
    .merge(products[["product_id", "product_name", "category_id", "stock"]], on="product_id", how="left")
    .merge(categories, on="category_id", how="left")
    .merge(invoices[["inv_no", "order_id", "amount"]], on="order_id", how="left")
    .merge(payments[["inv_no", "payment_mode", "payment_status"]], on="inv_no", how="left"))

analysis["line_revenue"] = analysis["quantity"] * analysis["price"]
analysis["customer_name"] = analysis["f_name"].fillna("") + " " + analysis["l_name"].fillna("")
analysis = analysis.dropna(subset=["order_id", "product_id", "order_date", "line_revenue"])
analysis.to_csv(OUT / "ecommerce_analysis_dataset.csv", index=False)

print("\\n--- Descriptive statistics ---")
print(analysis[["quantity", "price", "line_revenue", "total_amount", "stock"]].describe())
print("\\n--- Payment status ---")
print(analysis[["order_id", "payment_status"]].drop_duplicates()["payment_status"].value_counts())
print("\\n--- Revenue by category ---")
print(analysis.groupby("category_name")["line_revenue"].sum().sort_values(ascending=False))
print("\\n--- Revenue by area ---")
print(analysis.groupby("area")["line_revenue"].sum().sort_values(ascending=False))
print("\\n--- Numeric correlation ---")
print(analysis[["quantity", "price", "line_revenue", "total_amount", "stock"]].corr(numeric_only=True).round(2))

# Five clear charts for the report
def save_chart(filename):
    plt.tight_layout()
    plt.savefig(OUT / filename, dpi=160, bbox_inches="tight")
    plt.close()

daily = orders.groupby("order_date", as_index=False)["total_amount"].sum()
plt.figure(figsize=(9, 4.8))
plt.plot(daily["order_date"], daily["total_amount"], marker="o")
plt.title("Daily Order Revenue")
plt.xlabel("Order Date"); plt.ylabel("Revenue (INR)"); plt.xticks(rotation=35)
save_chart("01_daily_revenue.png")

cat_rev = analysis.groupby("category_name")["line_revenue"].sum().sort_values()
plt.figure(figsize=(8, 5))
cat_rev.plot(kind="barh")
plt.title("Revenue by Product Category")
plt.xlabel("Revenue (INR)"); plt.ylabel("Category")
save_chart("02_revenue_by_category.png")

area_rev = analysis.drop_duplicates("order_id").groupby("area")["total_amount"].sum().sort_values(ascending=False)
plt.figure(figsize=(8, 4.8))
area_rev.plot(kind="bar")
plt.title("Order Revenue by Customer Area")
plt.xlabel("Area"); plt.ylabel("Revenue (INR)"); plt.xticks(rotation=30)
save_chart("03_revenue_by_area.png")

pay = payments["payment_status"].value_counts()
plt.figure(figsize=(6, 5))
plt.pie(pay.values, labels=pay.index, autopct="%1.1f%%", startangle=90)
plt.title("Payment Status Distribution")
save_chart("04_payment_status.png")

mode = payments["payment_mode"].value_counts()
plt.figure(figsize=(8, 4.8))
mode.plot(kind="bar")
plt.title("Orders by Payment Mode")
plt.xlabel("Payment Mode"); plt.ylabel("Number of Payments"); plt.xticks(rotation=25)
save_chart("05_payment_mode.png")

# Inventory snapshot chart
stock = products.sort_values("stock")
plt.figure(figsize=(8, 5))
plt.barh(stock["product_name"], stock["stock"])
plt.title("Current Stock by Product")
plt.xlabel("Units in Stock"); plt.ylabel("Product")
save_chart("06_stock_by_product.png")

print(f"\\nAnalysis complete. Dataset and charts saved in: {OUT}")
