# LAB 2.08

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
#Select only columns title, length and rank in your output.

USE sakila;
SHOW TABLES;

SELECT title, length, RANK() OVER (ORDER BY length) AS 'rank'
FROM film
WHERE length IS NOT NULL AND length != 0;


# 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
#In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS 'rank'
FROM film
WHERE length IS NOT NULL AND length != 0
ORDER BY rating, 'rank';




# 3. How many films are there for each of the categories in the category table? 
#Hint: Use appropriate join between the tables "category" and "film_category".

# revisar:

SELECT category.name, COUNT(film_category.film_id) AS num_films
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name;



# 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" 
#and count the number of times an actor appears.

SELECT actor.first_name, actor.last_name, COUNT(*) as num_films
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY num_films DESC
LIMIT 1;


# 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate 
#join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT first_name, last_name, COUNT(*) as rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY rental_count DESC
LIMIT 1;





# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
#This query might require using more than one join statement. Give it a try. We will talk about queries with multiple 
#join statements later in the lessons.
# Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.


SELECT f.title AS film_title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 1;




