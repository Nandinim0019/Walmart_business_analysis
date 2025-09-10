# 🛒 Walmart Sales Data Analysis (MySQL Project)

## 📌 Project Overview
This project analyzes **10,000+ Walmart transactional records** using **MySQL**.  
The dataset includes details such as branch, city, category, unit price, quantity, date, time, payment method, ratings, and profit margins.  

The project demonstrates:
- **Data Cleaning with SQL**  
- **Business Problem Solving with Advanced Queries**  
- **Exploratory Data Analysis (EDA)** using MySQL

---

## 🧹 Data Cleaning Steps
- Removed `$` symbol from `unit_price` and converted it into `DECIMAL(10,2)`.  
- Converted `date` column (text) into `DATE` format using `STR_TO_DATE()`.  
- Converted `time` column (text) into proper `TIME` format.  
- Ensured consistency across all records for accurate analysis.

---

## ❓ Business Problems Solved with SQL
1. **Payment Method Analysis** → Find different payment methods, number of transactions, and quantity sold.  
2. **Category Ratings** → Identify the highest-rated category in each branch.  
3. **Busiest Day** → Find the busiest day for each branch based on transactions.  
4. **Category Ratings by City** → Determine average, minimum, and maximum ratings of categories per city.  
5. **Profitability** → Calculate total profit for each category.  
6. **Payment Trends** → Identify the most common payment method for each branch.  
7. **Sales Shifts** → Categorize sales into Morning, Afternoon, and Evening shifts.  
8. **Revenue Decline Analysis** → Identify branches with the highest revenue decrease ratio (e.g., 2022 vs 2023).  

---

## 🛠️ Technologies Used
- **MySQL 8.0** for data cleaning and queries  
- **SQL Window Functions** (RANK, DENSE_RANK, LAG)  
- **Aggregate Functions** (SUM, AVG, COUNT, MAX, MIN)  
- **CTEs & Subqueries**  

---

## 📊 Key Insights
- **E-wallet** is the most preferred payment method across branches.  
- **Health & Beauty** category shows consistently high profits.  
- Sales peak mostly in the **Afternoon shift**.  
- Certain branches show **significant revenue decline** year-over-year.

Author: Nandini
