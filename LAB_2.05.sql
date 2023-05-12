# LAB_2.05


##### -->  SQL Queries <--- ####

# In this lab, you will be using the Sakila database of movie rentals.

## Instructions# #

# 1. Select all the actors with the first name ‘Scarlett’.

USE Sakila;
SHOW TABLES; # Ver cuántas tablas hay.
SELECT * FROM actor; # Ver qué campos tiene la tabla actors
SELECT first_name, actor_id FROM actor
WHERE first_name = 'Scarlett';



# 2. How many films (movies) are available for rent and how many films have been rented?

SELECT COUNT(film_id) FROM film; # Todas las películas que hay para que alguien las rente
SELECT COUNT(rental_id) FROM rental; # Todas las películas que se han rentado.



# 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT * FROM film_list;

SELECT title, length AS max_duration FROM film_list
ORDER BY length DESC LIMIT 1;

SELECT title, length AS min_duration FROM film_list
ORDER BY length LIMIT 1;


# 4. What's the average movie duration expressed in format (hours, minutes)?

SELECT CONCAT(FLOOR(AVG(length)/60), ':', LPAD( AVG(length)% 60, 2, '0')) AS AVG_movie_duration
FROM film_list;

# FLOOR() redondea un número hacia abajo al entero más cercano que sea menor o igual que el número original.

# La función LPAD() en MySQL está diseñada principalmente para trabajar con cadenas. Aunque sí se puede con info num.
# Rellena una cadena dada con un carácter específico hasta que la cadena resultante alcanza una longitud específica.

# 5. How many distinct (different) actors' last names are there?

SELECT distinct (last_name) FROM actor;



# 6. Since how many days has the company been operating (check DATEDIFF() function)?

SHOW TABLES;
SELECT * FROM rental;

SELECT DATE_FORMAT(rental_date, '%Y - %m - %d') AS formatted_date FROM rental
ORDER BY formatted_date LIMIT 1;

SELECT DATEDIFF(CURDATE(), MIN(rental_date)) AS days_has_the_company_operating FROM rental;



# 7. Show rental info with additional columns month and weekday. Get 20 results.

SELECT DAYNAME(rental_date), rental_date FROM rental;

SELECT * FROM rental;

SELECT rental_id, rental_date,
DATE_FORMAT(CONVERT(rental_date, datetime),'%M') AS 'Rental Month', DAYNAME(rental_date) AS 'Rental Weekday',
inventory_id, customer_id, 
DATE_FORMAT(CONVERT(return_date, datetime),'%M') AS 'Return Month', DAYNAME(return_date) AS 'Return Weekday',
staff_id FROM rental
LIMIT 20;



# 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT rental_id, rental_date,
DATE_FORMAT(CONVERT(rental_date, datetime),'%M') AS 'Rental Month', DAYNAME(rental_date) AS 'Rental Weekday',
CASE 
    WHEN WEEKDAY(rental_date) BETWEEN 0 AND 4 THEN 'Weekday' 
    ELSE 'Weekend'
  END as 'day_type',
inventory_id, customer_id, 
DATE_FORMAT(CONVERT(return_date, datetime),'%M') AS 'Return Month', DAYNAME(return_date) AS 'Return Weekday',
CASE 
    WHEN WEEKDAY(return_date) BETWEEN 0 AND 4 THEN 'Weekday'
    ELSE 'Weekend'
  END as 'day_type',
staff_id FROM rental;



# 9. How many rentals were in the last month of activity?

SELECT * FROM rental;

select date(max(rental_date))- INTERVAL 30 DAY, date(max(rental_date))
from rental; 

# Result 58