# E-commerce-sale-analysis-using-sql-project
# 🛍️ Sales & Customer Analytics Dashboard (SQL + Power BI)

This project is a comprehensive **Retail Sales & Customer Analytics System** built using **PostgreSQL** for backend queries and **Power BI** for interactive dashboards. It focuses on delivering real business insights from structured sales data, including customer behavior, product performance, returns, and churn analysis.

---

## 📊 Project Overview

The goal of this project is to simulate a real-world e-commerce business scenario and derive actionable insights using **complex SQL queries** and **data visualization techniques**.

---

## 📁 Dataset

The project contains the following CSV-based relational tables:

- `customer.csv` – Customer demographics & registration data  
- `products.csv` – Product details, categories, prices  
- `orders.csv` – Transaction-level data for each order  
- `order_details.csv` – Product-level details in each order  
- `returns.csv` – Returned product records and reasons  

All data is mock/generated for educational purposes.

---

## 🧱 Database Schema

```text
customer(customer_id, name, email, gender, city, registration_date)  
products(product_id, name, category, price, cost_price, stock_quantity)  
orders(order_id, customer_id, order_date, payment_mode, total_amount)  
order_details(order_detail_id, order_id, product_id, quantity, unit_price, discount)  
returns(return_id, order_id, product_id, return_date, reason)

🧠 Key SQL Insights
Here are some of the major queries used in the analysis:

🔍 Top 5 Returned Products

🔁 Top Customers with Highest Returns

📉 Customer Churn Analysis – inactive for 90+ days

📦 Top 5 Best-Selling Products

💸 Profit Calculation by Product

👥 Customer Lifetime Value (CLV)

🏙️ Sales by City

📅 Monthly Revenue Trend

All SQL queries are available in sql_queries.sql.

🚀 Tools Used
PostgreSQL – SQL querying and relational database

Power BI – Dashboard creation and DAX calculations

CSV – Flat files for dataset import and portability

📬 Contact
Made with 💡 by Keshav
📧 Feel free to connect on LinkedIn for feedback or collaboration.

📜 License
This project is open-source and free to use under the MIT License.
