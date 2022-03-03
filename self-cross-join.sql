USE sakila;

# 1. Get all pairs of actors that worked together.
SELECT * FROM film_actor;

SELECT first.actor_id AS actor_1, second.actor_id AS actor_2, title
FROM film_actor AS first
JOIN film_actor AS second ON first.actor_id = second.film_id
JOIN film ON first.film_id = film.film_id;
 
# 2. Get all pairs of customers that have rented the same film more than 3 times.
WITH rental_count AS (
	SELECT COUNT(*) AS number_of_rentals, film_id, customer_id
	FROM rental
	JOIN inventory 
	ON rental.inventory_id = inventory.inventory_id
	GROUP BY customer_id, film_id
    HAVING number_of_rentals > 3)
SELECT first.customer_id AS first_customer, second.customer_id AS second_customer
FROM rental_count AS first
CROSS JOIN rental_count AS second; 

# 3. Get all possible pairs of actors and films.
SELECT table1.actor_id, table1.film_id, title, first_name, last_name
FROM film_actor AS table1
CROSS JOIN film_actor AS table2
LEFT JOIN film ON table1.film_id = film.film_id
LEFT JOIN actor ON table1.actor_id = actor.actor_id
ORDER BY actor_id ASC;


