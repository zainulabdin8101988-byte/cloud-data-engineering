-- ============================================================
--  ASSIGNMENT 01 — Querying, Sorting & Filtering
--  Database : BikeStores
--  Topics   : SELECT, WHERE, ORDER BY, TOP/OFFSET-FETCH,
--             DISTINCT, AND / OR
-- ============================================================


-- ============================================================
--  Question 1 — SELECT & WHERE
--  Retrieve the first name, last name, city, and phone number
--  of all customers who live in the state of 'CA' (California)
--  and have a phone number on record.
-- ============================================================

-- Write your query below:

SELECT first_name, last_name, city,phone
FROM   sales.customers
where state = 'CA' AND phone is not null




-- ============================================================
--  Question 2 — ORDER BY (Multiple Columns)
--  Fetch the product_id, product_name, model_year, and
--  list_price of all products.
--  Sort the results by model_year in descending order, and
--  within the same year sort by list_price in ascending order.
-- ============================================================

-- Write your query below:

SELECT product_id, product_name, model_year, list_price
FROM production.products
ORDER BY model_year Desc, list_price Asc

-- ============================================================
--  Question 3 — TOP N & TOP PERCENT
--  a) Return the top 5 most expensive products showing only
--     product_name and list_price.
--  b) Return the top 5% of cheapest products (all columns).
--     How many rows does the 5% result return? Add the row
--     count as a comment in your answer.
-- ============================================================

-- Total number of 5% is 17 rows

-- Part a:
SELECT TOP 5 product_name, list_price
FROM production.products
ORDER BY list_price Desc

-- Part b:

SELECT TOP 5 percent * 
FROM production.products
order by list_price Asc



-- ============================================================
--  Question 4 — OFFSET & FETCH (Pagination)
--  The sales team wants to browse products page by page,
--  10 products per page, sorted by list_price descending.
--  Write queries to return:
--    a) Page 1  (rows  1 – 10)
--    b) Page 2  (rows 11 – 20)
--    c) Page 3  (rows 21 – 30)
-- ============================================================

-- Page 1:

SELECT *
From production.products
ORDER BY list_price Desc
OFFSET 0 rows
Fetch next 10 rows only;

-- Page 2:

SELECT *
FROM production.products
Order by list_price Desc
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Page 3:

SELECT *
FROM production.products
ORDER BY list_price DESC
OFFSET 20 ROWS
FETCH NEXT 10 ROWS ONLY;


-- ============================================================
--  Question 5 — DISTINCT
--  a) List all unique states in which BikeStores has customers.
--     Sort the result alphabetically.
--  b) List every unique combination of state and city,
--     sorted by state then city (both ascending).
--  c) How many unique model years exist in the products table?
--     (Retrieve the distinct values; count them manually or
--     use COUNT — your choice.)
-- ============================================================

-- Part a:
SELECT distinct state
FROM sales.customers
ORDER BY state Asc

-- Part b:
SELECT distinct state, city
FROM sales.customers
ORDER BY state ASC, city ASC

-- Part c:
--TOTAL MODEL YEAR IS 4

SELECT count(distinct model_year)
FROM production.products

SELECT distinct model_year
FROM production.products
ORDER BY model_year


-- ============================================================
--  Question 6 — Logical Operators (AND / OR)
--  Write a single query that returns the product_id,
--  product_name, brand_id, category_id, and list_price for
--  products that meet ALL of the following conditions:
--    • list_price is between $500 and $1500 (inclusive)
--    • model_year is 2019 OR 2020
--  Sort the results by list_price ascending.
--  Hint: use parentheses to control the order of evaluation.
-- ============================================================

SELECT product_id, product_name, brand_id, category_id, list_price, model_year
FROM production.products
where list_price BETWEEN 500 and 1500
AND model_year between 2018 and 2019
ORDER BY list_price Asc



SELECT product_id, product_name, brand_id, category_id, list_price, model_year
FROM production.products
where (list_price BETWEEN 500 and 1500)
AND (model_year between 2016 and 2017)
ORDER BY list_price


-- ============================================================
--  ASSIGNMENT 02 — Joins
--  Database : BikeStores
-- ============================================================


-- ============================================================
--  Question 1
--  Retrieve the product_name, list_price, and category_name
--  for every product.
--  Use production.products and production.categories.
--  Sort the results by product_name ascending.
-- ============================================================

-- Write your query below:

SELECT product_name, list_price, category_name
FROM production.products,  production.categories
ORDER BY product_name


-- ============================================================
--  Question 2
--  Show the customer full name (as full_name), order_id,
--  and order_date for all customers who have placed an order.
--  Use sales.customers and sales.orders.
--  Sort by order_date descending.
-- ============================================================

-- Write your query below:

SELECT first_name+ '' +last_name, order_id, order_date
FROM sales.customers, sales.orders
ORDER BY order_date desc


-- ============================================================
--  Question 3
--  Retrieve product_name, list_price, category_name, and
--  brand_name for every product.
--  Use production.products, production.categories,
--  and production.brands.
--  Sort by brand_name then product_name (both ascending).
-- ============================================================

-- Write your query below:

SELECT product_name, list_price, category_name, brand_name
FROM production.products, production.categories, production.brands
ORDER BY brand_name asc, product_name asc
-- ============================================================
--  Question 4
--  List all products along with their order_id and item_id.
--  Make sure products that have NEVER been ordered also appear
--  in the result (those rows will have NULL for order_id
--  and item_id).
--  Use production.products and sales.order_items.
--  Sort by order_id ascending.
-- ============================================================

-- Write your query below:

SELECT p.product_name, o.order_id, o.item_id
FROM  production.products p
Left join sales.order_items o
on p.product_id = o.product_id
order by o.order_id Asc

-- ============================================================
--  Question 5
--  Using your answer from Question 4 as a base, filter the
--  results to show ONLY the products that have never been
--  ordered.
--  Display only product_id and product_name.
-- ============================================================

-- Write your query below:

SELECT p.product_name, p.product_id
FROM  production.products p
Left join sales.order_items o
on p.product_id = o.product_id
where o.order_id is null
order by p.product_id


-- ============================================================
--  Question 6
--  Show all stores along with any orders placed at each store.
--  Display store_name, store_id (from stores), order_id,
--  and order_date.
--  Every store must appear in the result, even if it has
--  no orders yet.
--  Use sales.orders and sales.stores.
-- ============================================================

-- Write your query below:
SELECT s.store_name, s.store_id, o.order_id, o.order_date
FROM sales.stores s
LEFT JOIN sales.orders o
on s.store_id = o.store_id




-- ============================================================
--  Question 7
--  List every staff member alongside their manager's name.
--  Display:
--    • staff full name   (as staff_name)
--    • manager full name (as manager_name)
--  Use only the sales.staffs table.
--  Staff who have no manager should NOT appear in the result.
-- ============================================================

-- Write your query below:

SELECT first_name+ '' +last_name, staff_name, manager_name
FROM sales.staffs



-- ============================================================
--  Question 8
--  Generate every possible combination of store name and
--  brand name.
--  Display store_name and brand_name.
--  Use sales.stores and production.brands.
--  How many total rows do you expect?
--  Write the expected count as a comment next to your query.
-- ============================================================

-- Write your query below:

SELECT 
    s.store_name,
    b.brand_name
FROM sales.stores s
CROSS JOIN production.brands b;


-- ============================================================
--  Question 9
--  Retrieve the customer full name (as full_name), order_id,
--  order_date, product_name, and list_price for every order
--  that has been placed.
--  Use sales.customers, sales.orders, sales.order_items,
--  and production.products.
--  Sort by order_date ascending, then full_name ascending.
-- ============================================================

-- Write your query below:

SELECT 
    c.first_name + ' ' + c.last_name AS full_name, o.order_id, o.order_date, p.product_name, oi.list_price
FROM sales.customers c
INNER JOIN sales.orders o
    ON c.customer_id = o.customer_id
INNER JOIN sales.order_items oi
    ON o.order_id = oi.order_id
INNER JOIN production.products p
    ON oi.product_id = p.product_id
ORDER BY o.order_date ASC,
         full_name ASC;

