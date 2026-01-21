show databases;
use storeorders;
SET SQL_SAFE_UPDATES = 0;
show tables

#see what type of data
DESCRIBE orderdetails;

#transforming the date to its corresponding types
UPDATE orderdetails
SET order_date = CASE
    WHEN order_date LIKE '%/%' THEN STR_TO_DATE(order_date, '%m/%d/%Y')
    WHEN order_date LIKE '%-%' THEN STR_TO_DATE(order_date, '%m-%d-%Y')
END
WHERE order_date IS NOT NULL
  AND order_date <> '';
#overall data display
Select * from orderdetails;

# Q1 )Write an sql query to get all the orders where customers name has "a" as second character and "d" as fourth character 
SELECT * 
FROM orderdetails 
WHERE customer_name LIKE '_a_d%';

#Q2)write a sql to get all the orders placed in the month of dec 2020:question: 
SELECT *
FROM orderdetails
WHERE order_Date BETWEEN '2020-12-01' AND '2020-12-31';

#3. write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020:question:
SELECT *
 FROM orderdetails 
WHERE ship_mode NOT IN ('Standard Class','First Class') AND ship_date >='2020-11-01';

#4 write a query to get all the orders where customer name neither start with "A" and nor ends with "n":question: 
SELECT *
FROM orderdetails
WHERE customer_name NOT LIKE 'A%'  -- does NOT start with A
  AND customer_name NOT LIKE '%n'; -- does NOT end with n

#5  write a query to get all the orders where profit is negative:
SELECT * 
FROM orderdetails 
WHERE profit<0;

#6 write a query to get all the orders where either quantity is less than 3 or profit is 0:
SELECT * 
FROM orderdetails 
WHERE quantity<3 or profit=0;

#7 . your manager handles the sales for South region and he wants you to create a report of all the 
#orders in his region where some discount is provided to the customers:question:
SELECT *
 FROM orderdetails 
 WHERE region='south' and discount>0;

#8  write a query to find top 5 orders with highest sales in furniture category:
SELECT * 
FROM orderdetails 
WHERE category='Furniture' 
ORDER BY sales DESC limit 5;

#. write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only:
SELECT *
 FROM orderdetails
 WHERE category IN ('Furniture','Technology') and order_Date between '2020-01-01' and '2020-12-31';

#10. write a query to find all the orders where order date is in year 2020 but ship date is in 2021:question:
SELECT * 
FROM orderdetails 
WHERE order_Date BETWEEN '2020-01-01' AND '2020-12-31'
 AND ship_date BETWEEN '2021-01-01' AND '2021-12-31';

#11  write a update statement to update city as null for order ids : CA-2020-161389 , US-2021-156909
UPDATE orderdetails 
SET city=NULL  
WHERE order_id IN ('US-2021-156909','CA-2020-161389');

 #12 . write a query to find orders where city is null (2 rows)
 SELECT * FROM orderdetails 
 WHERE city IS NULL;
 
 #13 . write a query to get total profit, first order date and latest order date for each category 
 SELECT category, SUM(profit) AS total_profit,MIN(order_date) AS first_order_date,MAX(order_date) AS latest_order_date 
 FROM orderdetails 
 GROUP BY category;
 
 #14  write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category

SELECT sub_category
FROM orderdetails
GROUP BY sub_category
HAVING AVG(profit) > (MAX(profit) / 2)
ORDER BY sub_category;
 
 #15 create the exams table with below script; and write a query to find students who have got same marks in Physics and Chemistry.
 
 #17. write a query to find total number of products in each category.
 SELECT category, COUNT(prodcut_name) AS product_count 
 FROM orderdetails
 GROUP BY category;
 
 # 18 write a query to find top 5 sub categories in west region by total quantity sold
 SELECT sub_category 
 FROM orderdetails 
 WHERE region='west' 
 GROUP BY sub_category 
 HAVING SUM(quantity) LIMIT 5;
 
 #19. Write a query to find total sales for each region and ship mode combination for orders in year 2020    
 SELECT region,ship_mode, SUM(sales) AS total_sales
 FROM orderdetails 
 WHERE order_Date BETWEEN '2020-01-01' AND '2020-12-31'
 GROUP BY region,ship_mode 
 ORDER BY total_sales DESC;
 
 #20. Write a query to find total sales for each region 
 SELECT region, ROUND(SUM(sales),2) AS total_sales
 FROM orderdetails
 GROUP BY region
 ORDER BY total_sales DESC;

 
 