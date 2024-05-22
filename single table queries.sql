-- Virtual Art Gallery Application Queries
USE v_Art;

SELECT * FROM artist;

-- 1. Insert Johannes Vermeer as an artist
INSERT INTO artist (artist_id, fname, mname, lname, dob, dod, country, local)
VALUES (9, 'Johannes', NULL, 'Vermeer', 1632, 1674, 'Netherlands', 'n');

-- 2. List all artist records sorted by the last name
SELECT artist_id, fname, mname, lname, dob, dod, country, local
FROM artist
ORDER BY lname ASC;

-- 3. Update Johannes Vermeer's death year to 1675
UPDATE artist
SET dod = 1675
WHERE artist_id = 9;

-- 4. Delete Johannes Vermeer from the database
DELETE FROM artists
WHERE artist_id = 9;

-- Bike Shop Queries
USE bike;

-- 5. List of customers from Houston, Texas
SELECT first_name, last_name, phone
FROM customer
WHERE city = 'Houston';

-- 6. List of high-end bikes with discounted prices
SELECT 
    product_name, 
    list_price, 
    (list_price - 500) AS 'Discount Price'
FROM product
WHERE list_price >= 5000
ORDER BY list_price DESC;

-- 7. List of staff not from my store
SELECT first_name, last_name, email
FROM staff
WHERE store_id <> 1;

-- 8. List of bikes with the word 'spider' in the name
SELECT product_name, model_year, list_price
FROM product
WHERE product_name LIKE '%spider%';

-- 9. List of bike names priced between $500 and $550
SELECT product_name, list_price
FROM product
WHERE list_price BETWEEN 500 AND 550
ORDER BY list_price ASC;

-- 10. List of specific customers based on phone number, city, or last name
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM customer
WHERE phone IS NOT NULL
  AND (city LIKE '%ach%' OR city LIKE '%och%' OR last_name = 'William')
LIMIT 5;

-- 11. List of products without the year at the end of the product_name
SELECT product_id, 
       REGEXP_REPLACE(product_name, ' -.*$', '') AS product_name
FROM product
ORDER BY product_id
LIMIT 14;

-- 12. List of 2019 model year bikes with price divided into 3 equal payments
SELECT 
    product_name, 
    CONCAT('$', FORMAT(list_price / 3, 2)) AS 'Payment'
FROM product
WHERE model_year = 2019;

-- Magazine Database
USE magazine;

-- 13. List the magazine name and take 3% off the magazine price, rounded to 2 decimal places
SELECT 
    magazineName, 
    ROUND(magazinePrice * 0.97, 2) AS 'Discount Price'
FROM magazine;

-- 14. Show the subscriber key and the number of years since their subscription started
SELECT 
    subscriber.subscriberKey,
    ROUND(TIMESTAMPDIFF(YEAR, subscription.subscriptionStartDate, '2020-12-20')) AS 'Years since subscription'
FROM 
    subscriber
JOIN 
    subscription ON subscriber.subscriberKey = subscription.subscriberKey;

-- 15. Show the subscriptionStartDate and subscriptionLength, and the formatted end date of the subscription
SELECT 
    subscription.subscriptionStartDate, 
    subscription.subscriptionLength, 
    DATE_FORMAT(DATE_ADD(subscription.subscriptionStartDate, INTERVAL subscription.subscriptionLength MONTH), '%M %d, %Y') AS 'Subscription end'
FROM 
    subscription;