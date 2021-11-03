#Lab | SQL Queries - Join Two Tables

# Import the database 
USE sakila

#1. Which actor has appeared in the most films
SELECT actor.actor_id, COUNT(*) 
FROM actor
INNER JOIN film
USING actor.actor_id = film.film_id
GROUP BY actor_id
ORDER BY COUNT(*);

#2. Most active customer (the customer that has rented the most number of films)
SELECT rental.rental_id, COUNT(rental_id) 
FROM rental 
INNER JOIN customer 
USING rental.rental_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY COUNT(*) desc
LIMIT 1; 

#3. List number of films per category.
SELECT name, COUNT(*) 
FROM category
INNER JOIN film_category
GROUP BY name
ORDER BY num_films desc;

#4. Display the first and last names, as well as the address, of each staff member.
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address
USING staff-address_id = address.address_id;

#5. Display the total amount rung up by each staff member in August of 2005.
SELECT concat(staff.first_name,' ', staff.last_name), sum(payment.amount)
FROM payment
INNER JOIN staff
USING payment.staff_id = staff.staff_id
WHERE payment_date like '2005-08%'
GROUP BY payment.staff_id;

#6. List each film and the number of actors who are listed for that film.
#There is a many to many relationship so they break it down to an intermediary table

SELECT title, COUNT(*) number_of_actors
FROM film
INNER JOIN film_actor
USING film.film_id = film_actor.film_id
GROUP BY title
ORDER BY number_of_actors desc; 

#7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name. Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.
