use sakila;
#How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, COUNT(inventory.inventory_id)
FROM sakila.film
INNER JOIN sakila.inventory  
ON film.film_id = inventory.film_id
WHERE film.title= "Hunchback Impossible";

#List all films whose length is longer than the average of all the films
SELECT fl.title, fl.length, ct.name
FROM film fl JOIN film_category fc ON fl.film_id=fc.film_id
             JOIN category ct ON ct.category_id=fc.category_id
WHERE fl.length > (SELECT AVG(fl.length) 
                   FROM film fl JOIN film_category fc ON fl.film_id = fc.film_id
                   JOIN category cat ON cat.category_id=fc.category_id
                   WHERE cat.name=ct.name);
                   
#Use subqueries to display all actors who appear in the film Alone Trip.
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
        
#	Get name and email from customers from Canada using subqueries.
SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';

#Which are films starred by the most prolific actor?
#Most prolific actor is defined as the actor that has acted in the most number of films
# find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT count(film_actor.actor_id), actor.first_name, actor.last_name 
FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id ;

#Films rented by most profitable customer. 
#use the customer table and payment table to find the most profitable customer 
#ie the customer that has made the largest sum of payments
SELECT customer.last_name, customer.first_name, SUM(payment.amount) 
FROM sakila.payment
INNER JOIN sakila.customer 
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name ASC;

     

        
