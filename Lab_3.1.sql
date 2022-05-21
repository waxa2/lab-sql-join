-- Instructions
use sakila;

-- 1. List the number of films per category.
create temporary table if not exists categ_and_film_cat
SELECT c.category_id, c.name, f.film_id, f.last_update
FROM category as c
JOIN film_category as f
ON c.category_id=f.category_id;

SELECT category_id,name, COUNT(DISTINCT (film_id)) as amoun_of_films
FROM categ_and_film_cat
GROUP BY category_id, name;

-- 2. Display the first and the last names, as well as the address, of each staff member.
create temporary table if not exists staff_address_id
SELECT s.first_name, s.last_name, a.address
FROM staff as s
JOIN address as a
ON s.address_id=a.address_id;

SELECT *
FROM staff_address_id;

-- 3. Display the total amount rung up by each staff member in August 2005.

create temporary table if not exists staff_pay_amounts
SELECT s.first_name,s.last_name,s.staff_id,p.amount
FROM staff as s
JOIN payment as p
ON s.staff_id=p.staff_id
WHERE LEFT(p.payment_date,7)='2005-08';

SELECT first_name,last_name,staff_id,SUM(amount)
FROM staff_pay_amounts
GROUP BY staff_id,first_name,last_name;



-- 4. List all films and the number of actors who are listed for each film.
create temporary table if not exists actors_per_film
SELECT film_id, COUNT(DISTINCT(actor_id)) as amount_of_actors
FROM film_actor 
GROUP BY film_id;

SELECT f.title,f.film_id, amount_of_actors
FROM film as f
JOIN actors_per_film apf
ON apf.film_id=f.film_id;

-- 5. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. 
-- List the customers alphabetically by their last names.

SELECT c.customer_id,c.first_name, c.last_name,SUM(p.amount) as paid_by_customer
FROM customer c
JOIN payment p
ON c.customer_id=p.customer_id
GROUP BY c.first_name, c.last_name,c.customer_id
ORDER BY c.last_name;

