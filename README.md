# Sales-Analytics-Project-using-MySQL
This project is a MySQL-based Sales Analytics system built to analyze product sales, customer performance, market trends, and forecast accuracy using real-world business metrics. The project demonstrates strong SQL fundamentals along with advanced analytical techniques commonly used in data analytics and business intelligence roles.

The database follows a star-schema-like structure with fact and dimension tables and focuses on sales performance analysis across customers, markets, regions, and fiscal years.

## 🧱 Database Structure

## Fact Tables

fact_sales_monthly – Monthly actual sales data

fact_forecast_monthly – Monthly forecasted quantities

fact_gross_price – Product-wise gross pricing

net_sales (view) – Net sales after discounts

## Dimension Tables

dim_product – Product and division details

dim_customer – Customer, market, and region information

## 🛠️ SQL Concepts & Features Used

Complex JOINs (INNER, LEFT, RIGHT)

Common Table Expressions (CTEs)

Window Functions (DENSE_RANK, SUM() OVER)

Aggregations & Grouping

User-defined functions (get_fiscal_year)

Views for reusable logic

Stored Procedures for reporting

Data cleaning with UPDATE

## Analytical calculations (market share, forecast accuracy)

## 📈 Key Analyses & Queries

1️⃣ Product-wise Sales Report (Fiscal Year 2021)

Generates detailed product-level sales for a specific customer, including total gross sales.

Key metrics:

Sold quantity

Gross price

Total gross revenue

2️⃣ Monthly Gross Sales Trend

Aggregates monthly gross sales to track performance trends over time.

3️⃣ Yearly Sales Summary

Provides total gross sales grouped by fiscal year to analyze year-over-year performance.

4️⃣ Market Badge Analysis

Calculates total quantity sold in a given market (India) for a specific fiscal year.

5️⃣ Top Markets by Net Sales

Identifies the top 5 markets based on net sales (in millions).

6️⃣ Global Market Share (%)

Uses CTEs and window functions to calculate customer-wise global market share percentages.

7️⃣ Regional Market Share (%)

Calculates customer contribution within each region using partitioned window functions.

8️⃣ Top N Products per Division

Ranks products within each division based on quantity sold using DENSE_RANK().

9️⃣ Forecast Accuracy Preparation

Creates a consolidated table combining actual vs forecasted sales, handling missing values for accurate analysis.

## 🗂️ Views Created

net_sales

sales_post_invoice_discount

sales_pre_invoice_discount

These views encapsulate complex logic and improve query reusability and performance.

## ⚙️ Stored Procedures

get_market_badge

get_monthly_gross_total_sales_for_customer

Top_Markets_by_NetSales

Stored procedures enable parameterized reporting and reusable business logic.

## 🎯 Skills Demonstrated

Advanced MySQL querying

Business-oriented data analysis

SQL performance optimization

Analytics-ready data modeling

Reporting logic using stored procedures

Real-world sales and market analysis
