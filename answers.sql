-- Question 1
-- Assumming that there is a table named ProductDetail
-- Using WITH RECURSIVE in MySQL to:

-- Split comma-separated strings into multiple rows and to Avoid creating helper tables
WITH RECURSIVE split_products AS (
    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS rest
    FROM ProductDetail

    UNION ALL

    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(rest, ',', 1)),
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2)
    FROM split_products
    WHERE rest != ''
)

SELECT 
    OrderID,
    CustomerName,
    Product
FROM split_products
ORDER BY OrderID;

-- Question 2
-- remove partial dependency of CustomerName on OrderID
-- without creating a separate table

-- Customers (one per OrderID)
SELECT DISTINCT
    OrderID,
    CustomerName
FROM OrderDetails;

-- Order details (excluding CustomerName)
SELECT 
    OrderID,
    Product,
    Quantity
FROM OrderDetails;