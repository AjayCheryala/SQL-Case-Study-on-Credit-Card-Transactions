# SQL Case Study on Credit Card Transactions

## Overview

This SQL case study analyzes a dataset of credit card transactions spanning from October 2013 to May 2015. The dataset includes transaction records with details like City, Date, Card Type, Expense Type, Gender, and Amount. Throughout the case study, SQL queries are designed and executed to achieve specific analytical objectives.

## Key SQL Functions Utilized

- Aggregate functions: SUM, COUNT, MIN, MAX
- Cast
- Round
- Window functions: SUM(), RANK(), DENSE_RANK(), ROW_NUMBER()
- Subqueries
- Date functions
- Multi-Table Joins
- Concatenate
- CASE WHEN statement
- WHERE clause
- Common Table Expression (CTE)

## SQL Challenge Questions

1. **Top 5 Cities with Highest Spends**
   - Print the top 5 cities with the highest spends and their percentage contribution to total credit card spends.

2. **Highest Spend Month by Card Type**
   - Identify the highest spending month and the amount spent for each card type.

3. **Transaction Details at $1,000,000 Spends**
   - Retrieve transaction details (all columns) for each card type when cumulative spends reach $1,000,000.

4. **City with Lowest Percentage Spend for Gold Card**
   - Find the city with the lowest percentage spend for gold card transactions.

5. **City with Highest and Lowest Expense Types**
   - List cities alongside their highest and lowest expense types (e.g., Delhi, bills, Fuel).

6. **Percentage Contribution of Spends by Females**
   - Calculate the percentage contribution of spends by females for each expense type.

7. **Highest Month-over-Month Growth in Jan-2014**
   - Identify the card and expense type combination that saw the highest month-over-month growth in January 2014.

8. **City with Highest Spend-to-Transaction Ratio on Weekends**
   - Determine which city had the highest total spend-to-transaction ratio during weekends.

9. **City with Least Days to 500th Transaction**
   - Find the city that took the least number of days to reach its 500th transaction after the first transaction.

## SQL Functions and Techniques

This case study demonstrates the use of various SQL functions and techniques to analyze and derive insights from credit card transaction data. Each query addresses specific analytical challenges to enhance understanding and decision-making based on the data.
