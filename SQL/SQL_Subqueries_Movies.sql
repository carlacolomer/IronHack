#Lab | SQL Subqueries

#1. How many copies of the film Hunchback Impossible exist in the inventory system?

#Join
SELECT title, COUNT(inventory_id)
FROM film 
INNER JOIN inventory 
ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible";

#2. List all films whose length is longer than the average of all the films.
-- step 1: calculate the average
select avg(length) from sakila.film;

-- step 2 --> pseudo code the main goal of this step ....
select * from sakila.film
where length > "AVERAGE";

-- step 3 ... create the query
select * from sakila.film
where length > (
  select avg(length)
  from sakila.film
);

#3. Use subqueries to display all actors who appear in the film Alone Trip.

-- step 1: select all actors 
SELECT * 
FROM actor 
WHERE actor_id IN(
SELECT actor_id
FROM film
WHERE film_id IN (
SELECT film_id
FROM film 
WHERE title='Alone Trip'
)); 

#4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
# Identify all movies categorized as family films.
-- step 1: select all films 

SELECT * 
FROM film
WHERE film_id IN (
SELECT film_id
FROM film 
WHERE category_id IN (
SELECT category_id 
FROM category
WHERE name ='family'
)); 

#5a. Get name and email from customers from Canada using subqueries.

SELECT first_name, last_name, email 
FROM customer
WHERE address_id IN(
SELECT address_id
FROM address
WHERE city_id IN(
SELECT city_id
FROM city
WHERE country_id IN(
SELECT country_id 
FROM country
WHERE country ='Canada'
))); 

#5b. Do the same with joins. 
# Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT first_name, last_name, email 
FROM customer 
JOIN address 
ON (customer.address_id = address.address_id)
JOIN city 
ON (city.city_id = address.city_id)
JOIN country
ON (country.country_id = city.country_id)
WHERE country.country= 'Canada';

#6. Which are films starred by the most prolific actor? 

# First you will have to find the most prolific actor 
# Most prolific actor is defined as the actor that has acted in the most number of films. 
# sub-query to get actor_id of actor with most films
# sub-sub-query to count films by actor

SELECT actor_id  
FROM actor
WHERE actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id 
ORDER BY count(film_id) desc 
LIMIT 1);

# Then use that actor_id to find the different films that he/she starred.
# parent query to get films of actor with most films

SELECT title
FROM film
WHERE film_id IN (
SELECT film_id 
FROM film
WHERE actor_id IN (
SELECT actor_id 
FROM actor 
WHERE actor_id IN (
SELECT actor_id 
FROM film_actor 
GROUP BY film_id 
WHERE actor_id ='107')));

#7. Films rented by most profitable customer. 
# You can use the customer table and payment table to find the most profitable customer 
# ie the customer that has made the largest sum of payments

SELECT last_name, first_name, SUM(amount)
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY amount desc;

#8. Customers who spent more than the average payments.
-- step 1: calculate the average
select avg(amount) from sakila.payment;

-- step 2 --> pseudo code the main goal of this step ....
select * from sakila.payment
where amount > "AVERAGE";

-- step 3 ... create the query
select * from sakila.payment
where amount > (
  select avg(amount)
  from sakila.payment
);