# LAB_2.06

# Lab | SQL Queries - Lesson 2.6

USE sakila;

# 1. Get release years.

SHOW TABLES;
SELECT DISTINCT release_year FROM film;
SELECT release_year FROM film;

#Solo hay un realese year.

# 2. Get all films with ARMAGEDDON in the title.

SELECT * FROM film
WHERE title REGEXP 'ARMAGEDDON';

# Resultado 4

# 3. Get all films which title ends with APOLLO.

SELECT * FROM film
WHERE title LIKE '%APOLLO';



# 4. Get 10 the longest films.

SELECT * FROM film
ORDER BY length DESC
LIMIT 10;



# 5. How many films include Behind the Scenes content?

SELECT * FROM film
WHERE special_features REGEXP 'Behind the Scenes';


# 6. Drop column picture from staff.

SELECT * FROM staff;

ALTER TABLE staff
DROP COlUMN picture;

# 7. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
#Update the database accordingly.

SELECT * FROM customer
WHERE first_name = 'TAMMY';

# customer_id = 75, store_id = 2, TAMMY SANDERS, email = TAMMY.SANDERS@sakilacustomer.org, address_id = 79,

SELECT * FROM staff;
# (3, TAMMY, SANDERS, 79, TAMMY.SANDERS@sakilacustomer.org, 2, 1, Tammy, ,¿?)

# Cuando no defino qué columnas voy a rellenar, tengo que poner Nulls en la info que no conozco.
# insert into staff values
# (3,'TAMMY','SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy',NULL,' ¿?¿?');


# Acá ya estoy definiendo las columnas con la info que tengo.  Lo hago así, porque no tengo last_update.
insert into sakila.staff(first_name, last_name, email, address_id, store_id, username)
values('TAMMY','SANDERS', 'TAMMY.SANDERS@sakilacustomer.org', 79, 2, 'Tammy');


# 8. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
#You can use current date for the rental_date column in the rental table. Hint: Check the columns in the 
#table rental and see what information you would need to add there. You can query those pieces of information. 
#For eg., you would notice that you need customer_id information as well. To get that you can use the following query:

SHOW TABLES;
SELECT * FROM staff;

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; # 130

# Use similar method to get inventory_id, film_id, and staff_id.

select film_id from film
where title = 'Academy Dinosaur'; # 1


select inventory_id from inventory
where film_id = 1; # Puedo elegir entre 1 de las 4 copias que tienen en las tienda store 1. 

select staff_id from staff
where first_name = 'Mike' AND last_name = 'Hillyer'; # 1


insert into sakila.rental(rental_date, inventory_id, customer_id, staff_id)
values(CURDATE(),2,130,1);



# 9. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, 
#and the date for the users that would be deleted. Follow these steps:

	# Check if there are any non-active users
	# Create a table backup table as suggested
	# Insert the non active users in the table backup table
	# Delete the non active users from the table customer

SHOW TABLES;
SELECT * FROM customer;

# Check if there are any non-active users

SELECT * FROM customer
WHERE active = 0;

# Create a table backup table as suggested
CREATE TABLE deleted_users(
  customer_id int (10),
  email varchar(50) NOT NULL,
  today_date date
);


# Insert the non active users in the table backup table
INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = 0;

# Corroborando
SELECT * FROM deleted_users;

UPDATE deleted_users SET today_date = CURDATE();

# Delete the non active users from the table customer

SELECT * FROM customer
WHERE active = 0;

# vamos a eliminar las llaves foraneas en al tabla de customer, apra poder eliminar los usuarios inactivos.
SET FOREIGN_KEY_CHECKS=0;

# Para eliminar cosas, si sale error 1175 --> se tiene que quitar el candadito en preferencias.
DELETE FROM customer 
WHERE active = 0;


