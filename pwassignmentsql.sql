-- QUE1
Create database assignment;
use assignment;
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000
);


/* 
Que 2. Purpose of Constraints and How They Maintain Data Integrity
Constraints ensure the validity, consistency, and reliability of data in a database. They enforce rules that prevent invalid or inconsistent data entry. 
For example, the NOT NULL constraint ensures critical fields always have values, while UNIQUE prevents duplicate entries in a column. The PRIMARY KEY uniquely 
identifies each row, combining NOT NULL and UNIQUE. FOREIGN KEY maintains relationships between tables, ensuring referential integrity. CHECK validates data against
 specific conditions, and DEFAULT assigns default values to columns if no value is provided. These rules collectively maintain the accuracy and reliability of the data.
 
 Que3. Why Use NOT NULL, and Can Primary Keys Be NULL?
The NOT NULL constraint ensures a column cannot contain missing or undefined values, which is essential for critical fields like names or IDs. 
Primary keys cannot be NULL because they uniquely identify rows in a table, and NULL represents an unknown value, contradicting this purpose. 
For example, in an employees table, if emp_id (the primary key) is NULL, it fails to uniquely identify the record. Thus, primary keys inherently 
combine NOT NULL and UNIQUE constraints to maintain data integrity and uniqueness.

Que4. Adding and Removing Constraints on an Existing Table
To add a constraint, use the ALTER TABLE command with ADD. For example, to add a UNIQUE constraint:
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);
To remove a constraint, use ALTER TABLE with DROP CONSTRAINT. For example, to remove the UNIQUE constraint:
ALTER TABLE employees DROP CONSTRAINT unique_email;
Adding constraints ensures data integrity; removing them requires caution to avoid compromising database reliability.

Que5. Consequences of Violating Constraints
Violating constraints in a database prevents the execution of operations that do not adhere to predefined rules. For example, 
attempting to insert a duplicate value into a column with a UNIQUE constraint or a NULL value into a NOT NULL column will result in an error.
 These constraints ensure data integrity and consistency by rejecting invalid data. Such violations can disrupt application workflows and indicate the need
 to correct the data or logic before proceeding. They also act as safeguards against unintended or harmful changes to the database.
*/

-- QUE 6
CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

-- QUE 7
CREATE TABLE classes (
    class_id INT PRIMARY KEY, -- Unique identifier for each class
    class_name VARCHAR(50) NOT NULL -- Name of the class
);
CREATE TABLE students (
    student_id INT PRIMARY KEY, -- Unique identifier for each student
    student_name VARCHAR(50) NOT NULL, -- Name of the student
    class_id INT, -- Foreign key linking to the classes table
    FOREIGN KEY (class_id) REFERENCES classes(class_id) -- Ensures referential integrity
);
SELECT 
    students.student_name, 
    classes.class_name
FROM 
    students
INNER JOIN 
    classes
ON 
    students.class_id = classes.class_id;

-- QUE8
/*
SELECT 
    orders.order_id, 
    customers.customer_name, 
    products.product_name
FROM 
    products
LEFT JOIN 
    orders
ON 
    products.product_id = orders.product_id
LEFT JOIN 
    customers
ON 
    orders.customer_id = customers.customer_id;
    
    
QUE 9

SELECT 
    products.product_name, 
    SUM(sales.quantity * sales.price_per_unit) AS total_sales_amount
FROM 
    sales
INNER JOIN 
    products
ON 
    sales.product_id = products.product_id
GROUP BY 
    products.product_name;

QUE 10:

SELECT 
    orders.order_id, 
    customers.customer_name, 
    order_details.quantity
FROM 
    orders
INNER JOIN 
    customers ON orders.customer_id = customers.customer_id
INNER JOIN 
    order_details ON orders.order_id = order_details.order_id;

*/


/* SQL COMMANDS 

QUE 1-23

1. **Primary Keys and Foreign Keys in Maven Movies DB**
Primary keys uniquely identify each record in a table, while foreign keys create relationships between tables by referencing primary keys in other tables. In the Maven Movies database:
- **Primary Keys**: These are usually present in tables like `customer_id`, `actor_id`, `film_id`, and `rental_id` to ensure uniqueness within each table.
- **Foreign Keys**: These exist in tables like `rental` (which references `customer_id`), `film_actor` (which references `actor_id` and `film_id`), and `payment` (which references `rental_id`).  
The key difference is that primary keys enforce entity uniqueness within a table, while foreign keys ensure data integrity and relationships between tables.

---

2. **List All Details of Actors**
To list all details of actors, you would query the `actors` table:

SELECT * FROM actors;

This query fetches all columns and rows from the `actors` table, providing information such as `actor_id`, `first_name`, `last_name`, and potentially other actor-related details.

---

3. **List All Customer Information from DB**
To list all customer information, use:
```sql
SELECT * FROM customers;
```
This command retrieves all records from the `customers` table, providing details such as `customer_id`, `first_name`, `last_name`, `email`, `address`, and other customer-related fields.

---

4. **List Different Countries**
To list all unique countries, use:
```sql
SELECT DISTINCT country FROM customers;
```
This query returns all distinct countries where customers are located, ensuring no duplicate country names are shown.

---

5. **Display All Active Customers**
Assuming there's a field like `is_active` in the `customers` table:
```sql
SELECT * FROM customers WHERE is_active = 1;
```
This will display all customers marked as active, based on the `is_active` flag (1 for active, 0 for inactive).

---

6. **List of All Rental IDs for Customer with ID 1**
To find all rental IDs for a customer with `customer_id = 1`:
```sql
SELECT rental_id FROM rentals WHERE customer_id = 1;
```
This query retrieves all rental IDs associated with customer 1 from the `rentals` table.

---

7. **Display All Films Whose Rental Duration Is Greater Than 5**
To find films with a rental duration greater than 5:
```sql
SELECT * FROM films WHERE rental_duration > 5;
```
This query lists all films with a rental duration longer than 5 days.

---

8. **List the Total Number of Films with Replacement Cost Greater than $15 and Less than $20**
To count films with a replacement cost in the specified range:
```sql
SELECT COUNT(*) FROM films WHERE replacement_cost > 15 AND replacement_cost < 20;
```
This query returns the total number of films whose replacement cost is greater than $15 and less than $20.

---

9. **Display the Count of Unique First Names of Actors**
To count unique first names of actors:
```sql
SELECT COUNT(DISTINCT first_name) FROM actors;
```
This query returns the count of distinct first names in the `actors` table, avoiding duplicates.

---

10. **Display the First 10 Records from the Customer Table**
To display the first 10 records from the `customers` table:
```sql
SELECT * FROM customers LIMIT 10;
```
This query retrieves the first 10 rows from the `customers` table.

---

11. **Display the First 3 Records from the Customer Table Whose First Name Starts with ‘B’**
To filter customers with first names starting with 'B':
```sql
SELECT * FROM customers WHERE first_name LIKE 'B%' LIMIT 3;
```
This query fetches the first 3 customers whose `first_name` starts with 'B'.

---

12. **Display the Names of the First 5 Movies Rated 'G'**
To find the first 5 movies with a 'G' rating:
```sql
SELECT film_name FROM films WHERE rating = 'G' LIMIT 5;
```
This query lists the first 5 films with a 'G' rating from the `films` table.

---

13. **Find All Customers Whose First Name Starts with 'A'**
To find customers whose first name starts with 'A':
```sql
SELECT * FROM customers WHERE first_name LIKE 'A%';
```
This query retrieves all customers whose `first_name` begins with the letter 'A'.

---

14. **Find All Customers Whose First Name Ends with 'A'**
To find customers whose first name ends with 'A':
```sql
SELECT * FROM customers WHERE first_name LIKE '%A';
```
This query fetches customers whose `first_name` ends with the letter 'A'.

---

15. **Display the List of the First 4 Cities Which Start and End with ‘A’**
To find cities that start and end with 'A':
```sql
SELECT city FROM customers WHERE city LIKE 'A%A' LIMIT 4;
```
This query retrieves the first 4 cities from the `customers` table that start and end with 'A'.

---

16. **Find All Customers Whose First Name Has 'NI' in Any Position**
To find customers whose first name contains 'NI':
```sql
SELECT * FROM customers WHERE first_name LIKE '%NI%';
```
This query returns customers whose `first_name` contains 'NI' at any position.

---

17. **Find All Customers Whose First Name Has 'R' in the Second Position**
To find customers whose first name has 'R' in the second position:
```sql
SELECT * FROM customers WHERE first_name LIKE '_R%';
```
This query lists customers whose `first_name` has 'R' as the second character.

---

18. **Find All Customers Whose First Name Starts with 'A' and Are at Least 5 Characters in Length**
To find customers with a first name starting with 'A' and at least 5 characters long:
```sql
SELECT * FROM customers WHERE first_name LIKE 'A____%';
```
This query retrieves customers whose `first_name` starts with 'A' and has at least 5 characters.

---

19. **Find All Customers Whose First Name Starts with 'A' and Ends with 'O'**
To find customers whose first name starts with 'A' and ends with 'O':
```sql
SELECT * FROM customers WHERE first_name LIKE 'A%O';
```
This query finds customers whose `first_name` starts with 'A' and ends with 'O'.

---

20. **Get the Films with 'PG' and 'PG-13' Rating Using IN Operator**
To find films with 'PG' and 'PG-13' ratings:
```sql
SELECT * FROM films WHERE rating IN ('PG', 'PG-13');
```
This query retrieves all films with either a 'PG' or 'PG-13' rating.

21. **Get the Films with Length Between 50 to 100 Using `BETWEEN` Operator**
To retrieve films with a length between 50 and 100 minutes, use the `BETWEEN` operator:

```sql
SELECT * FROM films WHERE length BETWEEN 50 AND 100;
```
This query fetches all films where the `length` of the film is between 50 and 100 minutes (inclusive).

---

22. **Get the Top 50 Actors Using `LIMIT` Operator**
To get the top 50 actors (assuming 'top' refers to any selection, as it might need a specific sorting criterion such as popularity or appearance count), use:

```sql
SELECT * FROM actors LIMIT 50;
```
This query retrieves the first 50 rows from the `actors` table. To customize the selection, you can add an `ORDER BY` clause (e.g., to get the top actors by appearance or ratings).

---

23. **Get the Distinct Film IDs from the Inventory Table**
To retrieve all distinct `film_id` values from the `inventory` table:

```sql
SELECT DISTINCT film_id FROM inventory;
```
This query returns all unique `film_id`s from the `inventory` table, ensuring no duplicates.

*/


-- AGGREGATE FUNCTIONS

/*
Basic Aggregate Functions:

Question 1: **Retrieve the total number of rentals made in the Sakila database.**
```sql
SELECT COUNT(*) AS total_rentals FROM rentals;
```
This query uses the `COUNT()` function to count all the rows in the `rentals` table, representing the total number of rentals.

---

Question 2: **Find the average rental duration (in days) of movies rented from the Sakila database.**
```sql
SELECT AVG(rental_duration) AS avg_rental_duration FROM films;
```
This query calculates the average rental duration for movies using the `AVG()` function on the `rental_duration` column in the `films` table.

---



String Functions:

Question 3: **Display the first name and last name of customers in uppercase.**
```sql
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name
FROM customers;
```
This query uses the `UPPER()` function to convert the first and last names of customers to uppercase.

---

 Question 4: **Extract the month from the rental date and display it alongside the rental ID.**
```sql
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rentals;
```
This query uses the `MONTH()` function to extract the month from the `rental_date` and displays it alongside the `rental_id`.

---

GROUP BY:

uestion 5: **Retrieve the count of rentals for each customer (display customer ID and the count of rentals).**
```sql
SELECT customer_id, COUNT(*) AS rental_count
FROM rentals
GROUP BY customer_id;
```
This query uses the `COUNT()` function in combination with `GROUP BY` to count the number of rentals for each customer. The result shows `customer_id` and the corresponding rental count.

---

 Question 6: **Find the total revenue generated by each store.**
```sql
SELECT store_id, SUM(payment.amount) AS total_revenue
FROM payment
GROUP BY store_id;
```
This query calculates the total revenue for each store by summing the `amount` from the `payment` table and grouping the results by `store_id`.

---

Question 7: **Determine the total number of rentals for each category of movies.**
```sql
SELECT category.name AS category_name, COUNT(*) AS total_rentals
FROM rental
JOIN film_category ON rental.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;
```
This query calculates the total number of rentals for each movie category. It joins the `film_category`, `film`, and `rental` tables, and then uses `COUNT()` with `GROUP BY` to group by category name.

---

Question 8: **Find the average rental rate of movies in each language.**
```sql
SELECT languages.name AS language_name, AVG(films.rental_rate) AS avg_rental_rate
FROM films
JOIN languages ON films.language_id = languages.language_id
GROUP BY languages.name;
```
This query calculates the average rental rate of movies, grouped by language, using `AVG()` and joining the `films` and `languages` tables. 
*/


-- JOINS 
/*


Question 9: **Display the title of the movie, customer’s first name, and last name who rented it.**
```sql
SELECT films.title, customers.first_name, customers.last_name
FROM films
JOIN inventory ON films.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customers ON rental.customer_id = customers.customer_id;
```
This query joins the `films`, `inventory`, `rental`, and `customers` tables to retrieve the movie title, customer’s first name, and last name for each rental.

---

uestion 10: **Retrieve the names of all actors who have appeared in the film "Gone with the Wind."**
```sql
SELECT actors.first_name, actors.last_name
FROM actors
JOIN film_actor ON actors.actor_id = film_actor.actor_id
JOIN films ON film_actor.film_id = films.film_id
WHERE films.title = 'Gone with the Wind';
```
This query joins the `actors`, `film_actor`, and `films` tables to get the names of actors who have appeared in the film "Gone with the Wind."

---
 Question 11: **Retrieve the customer names along with the total amount they've spent on rentals.**
```sql
SELECT customers.first_name, customers.last_name, SUM(payment.amount) AS total_spent
FROM customers
JOIN payment ON customers.customer_id = payment.customer_id
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY customers.customer_id;
```
This query joins the `customers`, `payment`, and `rental` tables and uses the `SUM()` function to calculate the total amount spent by each customer on rentals.

---

 Question 12: **List the titles of movies rented by each customer in a particular city (e.g., 'London').**
```sql
SELECT customers.first_name, customers.last_name, films.title
FROM customers
JOIN address ON customers.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customers.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN films ON inventory.film_id = films.film_id
WHERE city.city = 'London';
```
This query joins the `customers`, `address`, `city`, `rental`, `inventory`, and `films` tables to list the titles of movies rented by customers located in 'London'.

*/

-- ADVANCED JOINS AND GROUP BY

/*


Question 13: **Display the top 5 rented movies along with the number of times they've been rented.**
```sql
SELECT films.title, COUNT(rental.rental_id) AS rental_count
FROM films
JOIN inventory ON films.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY films.film_id
ORDER BY rental_count DESC
LIMIT 5;
```
This query joins the `films`, `inventory`, and `rental` tables to count how many times each movie has been rented. The results are ordered by the rental count in descending order, and only the top 5 rented movies are displayed using `LIMIT 5`.

---

 Question 14: **Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).**
```sql
SELECT customers.first_name, customers.last_name
FROM customers
JOIN rental ON customers.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY customers.customer_id
HAVING COUNT(DISTINCT inventory.store_id) = 2;
```
This query joins the `customers`, `rental`, and `inventory` tables to identify customers who have rented movies from both stores (store ID 1 and store ID 2).
 The `HAVING COUNT(DISTINCT inventory.store_id) = 2` ensures that only those customers who rented from both stores are selected.
 
 */
 
 
 -- WINDOWS FUNCTION
 
 /*


1. **Rank the customers based on the total amount they've spent on rentals.**
```sql
SELECT customer_id, first_name, last_name, SUM(payment.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(payment.amount) DESC) AS rank
FROM customers
JOIN payment ON customers.customer_id = payment.customer_id
GROUP BY customer_id
ORDER BY rank;
```
This query uses the `RANK()` window function to rank customers based on their total spending on rentals, ordered by the total amount in descending order.

---

2. **Calculate the cumulative revenue generated by each film over time.**
```sql
SELECT film_id, rental_date, SUM(payment.amount) AS cumulative_revenue,
       SUM(payment.amount) OVER (PARTITION BY film_id ORDER BY rental_date) AS cumulative_revenue_over_time
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
ORDER BY film_id, rental_date;
```
This query uses the `SUM()` window function with `PARTITION BY` and `ORDER BY` to calculate the cumulative revenue generated by each film over time, ordered by rental date.

---

3. **Determine the average rental duration for each film, considering films with similar lengths.**
```sql
SELECT film_id, rental_duration, AVG(rental_duration) OVER (PARTITION BY rental_duration) AS avg_duration_per_length
FROM films;
```
This query uses the `AVG()` window function with `PARTITION BY` to calculate the average rental duration for each film, grouped by the `rental_duration`.

---

4. **Identify the top 3 films in each category based on their rental counts.**
```sql
SELECT category_id, film_id, title, COUNT(rental.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY category_id ORDER BY COUNT(rental.rental_id) DESC) AS rank
FROM film_category
JOIN rental ON film_category.film_id = rental.film_id
JOIN films ON rental.film_id = films.film_id
GROUP BY category_id, film_id
HAVING rank <= 3;
```
This query uses `RANK()` within each category (`PARTITION BY category_id`) to rank films based on rental count and filters out films with a rank higher than 3.

---

5. **Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.**
```sql
SELECT customer_id, COUNT(rental.rental_id) AS customer_rentals,
       AVG(COUNT(rental.rental_id)) OVER () AS avg_rentals,
       COUNT(rental.rental_id) - AVG(COUNT(rental.rental_id)) OVER () AS rental_diff
FROM rental
GROUP BY customer_id;
```
This query calculates the rental count for each customer and the average rental count across all customers, then computes the difference between them.

---

6. **Find the monthly revenue trend for the entire rental store over time.**
```sql
SELECT EXTRACT(YEAR FROM rental_date) AS rental_year, EXTRACT(MONTH FROM rental_date) AS rental_month,
       SUM(payment.amount) AS monthly_revenue,
       SUM(payment.amount) OVER (ORDER BY EXTRACT(YEAR FROM rental_date), EXTRACT(MONTH FROM rental_date)) AS cumulative_revenue
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;
```
This query uses the `SUM()` window function to calculate the monthly revenue and cumulative revenue over time by year and month.

---

7. **Identify the customers whose total spending on rentals falls within the top 20% of all customers.**
```sql
WITH customer_spending AS (
    SELECT customer_id, SUM(payment.amount) AS total_spent
    FROM customers
    JOIN payment ON customers.customer_id = payment.customer_id
    GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM customer_spending
WHERE total_spent >= (SELECT PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_spent) FROM customer_spending);
```
This query uses `PERCENTILE_CONT()` to identify customers whose spending falls within the top 20% based on the total amount spent.

---

8. **Calculate the running total of rentals per category, ordered by rental count.**
```sql
SELECT category_id, COUNT(rental.rental_id) AS rental_count,
       SUM(COUNT(rental.rental_id)) OVER (PARTITION BY category_id ORDER BY COUNT(rental.rental_id)) AS running_total
FROM rental
JOIN film_category ON rental.film_id = film_category.film_id
GROUP BY category_id
ORDER BY rental_count DESC;
```
This query calculates the running total of rentals for each category, ordered by rental count, using `SUM()` as a window function.

---

9. **Find the films that have been rented less than the average rental count for their respective categories.**
```sql
SELECT film_category.category_id, films.title, COUNT(rental.rental_id) AS rental_count,
       AVG(COUNT(rental.rental_id)) OVER (PARTITION BY film_category.category_id) AS avg_category_rental_count
FROM rental
JOIN film_category ON rental.film_id = film_category.film_id
JOIN films ON rental.film_id = films.film_id
GROUP BY film_category.category_id, films.film_id
HAVING COUNT(rental.rental_id) < AVG(COUNT(rental.rental_id)) OVER (PARTITION BY film_category.category_id);
```
This query finds films rented fewer times than the average rental count for their respective categories, using `AVG()` and `HAVING`.

---

10. **Identify the top 5 months with the highest revenue and display the revenue generated in each month.**
```sql
SELECT EXTRACT(YEAR FROM rental_date) AS rental_year, EXTRACT(MONTH FROM rental_date) AS rental_month,
       SUM(payment.amount) AS monthly_revenue
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY rental_year, rental_month
ORDER BY monthly_revenue DESC
LIMIT 5;
```
This query calculates the total revenue for each month and orders it by descending revenue, limiting the results to the top 5 months with the highest revenue.

*/


-- NORMALISATION & CTE
use mavenmovies;

/* 1. First Normal Form (1NF):
a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
In Sakila, consider the table film_actor. If a single record contains multiple actors for a film (i.e., multiple actor IDs in one row), 
it violates 1NF because 1NF requires atomic values.

To normalize it:

Split any repeating groups into separate rows.
Ensure each column contains atomic values (single value).
*/
-- Normalized table in 1NF:
SELECT film_id, actor_id
FROM film_actor;

/*
2. Second Normal Form (2NF):
a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
Consider the rental table, which has the following structure:
*/
SELECT rental_id, customer_id, rental_date, inventory_id, staff_id
FROM rental;
/*
To determine if it's in 2NF:

Ensure the table is already in 1NF (no repeating groups or multi-valued attributes).
Ensure there are no partial dependencies (non-key attributes depending on part of a composite key).
If customer_name and staff_name are dependent only on customer_id and staff_id, respectively, this violates 2NF because they depend only on part of the composite key.

To normalize the table to 2NF:

Split the table to remove partial dependencies by moving customer_name and staff_name into their respective tables.
*/
-- Normalized rental table:
SELECT rental_id, customer_id, staff_id, rental_date, inventory_id
FROM rental;

-- Create separate customer and staff tables:
CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(255)
);

CREATE TABLE staffs (
  staff_id INT PRIMARY KEY,
  staff_name VARCHAR(255)
);

/*


### 3. **Third Normal Form (3NF)**:
#### a. **Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.**

Consider the `payment` table:
```sql
*/
SELECT payment_id, amount, customer_id, staff_id, store_id, store_location
FROM payment;
/*

There is a transitive dependency: `payment → store_id → store_location`.

To normalize this to 3NF:
1. The table is already in 2NF, but `store_location` depends on `store_id`, which is a non-prime attribute.
2. To achieve 3NF, we need to remove this transitive dependency by placing `store_location` in a new `store` table and linking it via `store_id`.

```sql
*/
-- Normalized payment table (in 3NF):
SELECT payment_id, amount, customer_id, staff_id, store_id
FROM payment;

-- Create a separate store table:
CREATE TABLE store (
  store_id INT PRIMARY KEY,
  store_location VARCHAR(255)
);
/*

This removes the transitive dependency and ensures the table is in 3NF.

---

### 4. **Normalization Process**:
#### a. **Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.**

Let’s consider the `rental` table:

**Step 1: Unnormalized Form (UNF)**
The unnormalized table might look like this, where the customer and staff information is stored redundantly:

```sql
-- Unnormalized rental table:
*/
SELECT rental_id, customer_name, staff_name, inventory_id, rental_date
FROM rental;

/*
**Step 2: First Normal Form (1NF)**
Ensure atomicity (no repeating groups or multi-valued attributes):

```sql
-- Normalized to 1NF:
*/
SELECT rental_id, customer_id, staff_id, inventory_id, rental_date
FROM rental;
/*

**Step 3: Second Normal Form (2NF)**
Remove partial dependencies (attributes dependent on part of a composite key):

```sql
-- Normalized to 2NF:
*/
SELECT rental_id, customer_id, staff_id, rental_date, inventory_id, store_id
FROM rental;

-- Create separate customer and staff tables:
CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(255)
);

CREATE TABLE staff (
  staff_id INT PRIMARY KEY,
  staff_name VARCHAR(255)
);
/*
```

---

### 5. **CTE Basics**:
#### a. **Write a query using a CTE to retrieve the distinct list of actor names and the number of films 
they have acted in from the actor and film_actor tables.**

```sql
*/
WITH actor_films AS (
    SELECT actor_id, COUNT(film_id) AS num_films
    FROM film_actor
    GROUP BY actor_id
)
SELECT a.first_name, a.last_name, af.num_films
FROM actor_films af
JOIN actor a ON af.actor_id = a.actor_id
ORDER BY af.num_films DESC;
/*
```

This query first creates a CTE `actor_films`, which counts the number of films each actor has acted in, and then joins it with the `actor` 
table to retrieve the actor names and their respective film counts.

---

These queries demonstrate the process of normalization and how to use CTEs to simplify complex queries in SQL. Let me know if you need further 
clarification on any of the steps!


### 6. **CTE with Joins**:

#### a. **Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.**

```sql
*/
WITH film_language AS (
    SELECT f.title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_language;
/*

This CTE, `film_language`, joins the `film` and `language` tables on the `language_id` column, and retrieves the film title, language name, and rental rate. The results are then selected from the CTE.

---

### 7. **CTE for Aggregation**:

#### a. **Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.**

```sql
*/
WITH customer_revenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT * FROM customer_revenue
ORDER BY total_revenue DESC;
/*
```

In this CTE, `customer_revenue`, we join the `customer` and `payment` tables to calculate the total revenue (`SUM(p.amount)`) for each customer. We then select the result ordered by the `total_revenue` in descending order.

---

### 8. **CTE with Window Functions**:

#### a. **Utilize a CTE with a window function to rank films based on their rental duration from the film table.**

```sql
*/
WITH ranked_films AS (
    SELECT f.title, f.rental_duration,
           RANK() OVER (ORDER BY f.rental_duration DESC) AS rank
    FROM film f
)
SELECT * FROM ranked_films
ORDER BY rank;
/*
```

This CTE, `ranked_films`, uses the `RANK()` window function to rank films based on their `rental_duration` in descending order. The result is then ordered by the rank.

---

### 9. **CTE and Filtering**:

#### a. **Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.**

```sql
*/
WITH frequent_customers AS (
    SELECT r.customer_id, COUNT(r.rental_id) AS rental_count
    FROM rental r
    GROUP BY r.customer_id
    HAVING COUNT(r.rental_id) > 2
)
SELECT c.customer_id, c.first_name, c.last_name, fc.rental_count
FROM frequent_customers fc
JOIN customer c ON fc.customer_id = c.customer_id
ORDER BY fc.rental_count DESC;
/*
```

In this query, the CTE `frequent_customers` finds customers who have made more than two rentals by counting the rentals for each customer. Then, the `customer` table is joined to the CTE to fetch additional details about these customers.

---





### 10. **CTE for Date Calculations**:

#### a. **Write a query using a CTE to find the total number of rentals made each month, considering the `rental_date` from the rental table.**

```sql
*/
WITH monthly_rentals AS (
    SELECT YEAR(rental_date) AS rental_year, MONTH(rental_date) AS rental_month, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY rental_year, rental_month
)
SELECT rental_year, rental_month, total_rentals
FROM monthly_rentals
ORDER BY rental_year, rental_month;
/*
```

This CTE, `monthly_rentals`, calculates the total number of rentals for each month by extracting the year and month from the `rental_date` column and counting the number of rentals in each group. The results are then ordered by year and month.

---

### 11. **CTE and Self-Join**:

#### a. **Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the `film_actor` table.**

```sql
*/
WITH actor_pairs AS (
    SELECT fa1.actor_id AS actor_1, fa2.actor_id AS actor_2, fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id < fa2.actor_id  -- To avoid duplicate pairs
)
SELECT a1.first_name AS actor_1_first_name, a1.last_name AS actor_1_last_name,
       a2.first_name AS actor_2_first_name, a2.last_name AS actor_2_last_name, ap.film_id
FROM actor_pairs ap
JOIN actor a1 ON ap.actor_1 = a1.actor_id
JOIN actor a2 ON ap.actor_2 = a2.actor_id
ORDER BY ap.film_id;
/*
```

This CTE, `actor_pairs`, creates pairs of actors who have appeared in the same film by joining the `film_actor` table to itself. The `WHERE` clause ensures that each pair is listed only once by comparing `actor_id` values. Then, it joins with the `actor` table to fetch the first and last names of the actors.

---

### 12. **CTE for Recursive Search**:

#### a. **Implement a recursive CTE to find all employees in the `staff` table who report to a specific manager, considering the `reports_to` column.**

```sql
*/
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: Find the manager (e.g., staff_id = 1)
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = 1  -- Replace with specific manager's staff_id
    
    UNION ALL
    
    -- Recursive case: Find employees who report to someone in the hierarchy
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM employee_hierarchy;
/*
```

This recursive CTE, `employee_hierarchy`, starts by selecting the manager (with a `staff_id` of 1 in this case, but this can be adjusted for any manager). Then, the recursive part selects employees who report to the current staff member, building the hierarchy of employees. The result is a list of all employees who report directly or indirectly to the specified manager.

---

*/