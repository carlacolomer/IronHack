## sql_Multiple_Tables 

USE sakila

## 1. Query displaying each store with its store ID, city, and country:

SELECT store_id, city, country
FROM store
# Join 1
JOIN (address 
# Join 2
JOIN (city 
# Join 3
JOIN country) 
USING (city_id)) 
USING (address_id);

## 2. Query displaying how much business, in dollars, each store brought in:

# Round to display in dollars 
SELECT store.store_id, 
round(sum(amount), 2)
FROM store join (customer 
JOIN (payment join rental 
USING (rental_id)) 
ON customer.customer_id = payment.customer_id) 
USING (store_id)
GROUP BY store.store_id;

## 3 The average running time(length) of films by category:

SELECT category.name, avg(length)
FROM film 
# Join 1
JOIN film_category 
USING (film_id)
# Join 2
JOIN category 
USING (category_id)
# Group By
GROUP BY category.name
# Order
ORDER BY avg(length) desc;

## 4. Film categories with the longest(length):

SELECT category.name, avg(length)
FROM film 
# Join 1
JOIN film_category 
USING (film_id)
# Join 2
JOIN category 
USING (category_id)
# Group By
GROUP BY category.name
# Order
ORDER BY avg(length) desc;

## 5. The most frequently(number of times) rented movies in descending order:

SELECT title, count(*) as "rental frequency"
FROM sakila.film
JOIN (sakila.inventory join sakila.rental using (inventory_id))
USING (film_id)
GROUP BY title
ORDER BY "rental frequency" desc;

## 6. The top five genres in gross revenue in descending order:

SELECT name, category_id, SUM(amount) #Calculates gross revenue
FROM payment
# Four Joins 
JOIN (rental 
JOIN (inventory 
JOIN (film_category 
JOIN category 
USING (category_id)) 
USING (film_id)) 
USING (inventory_id)) 
USING (rental_id)
# GROUP BY 
GROUP BY category_id
# Top 5 results 
ORDER BY SUM(amount) desc
limit 5;
