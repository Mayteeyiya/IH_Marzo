# LAB_SQL_INTRO

# 1. Use sakila database.
USE Sakila;
SHOW TABLES;

# 2. Get all the data from tables actor, film and customer.
SELECT * FROM (actor, film, customer); 

# 3. Get film titles.
SELECT title FROM film;


# 4. Get unique list of film languages under the alias language. 
# Note that we are not asking you to obtain the language per each film, 
#but this is a good time to think about how you might get that information in the future.

SELECT name AS Language FROM language; # Distinct  --> unique

# 5a. Find out how many stores does the company have?
SELECT * FROM store; # Dos tiendas
SELECT count(store_id) FROM store;
SELECT count(*) FROM store;
SELECT count(distinct store_id) FROM store;

#5b. Find out how many employees staff does the company have?
SELECT * FROM staff; # parecido a lo de arriba.


#5c. Return a list of employee first names only?
SELECT first_name FROM staff;






