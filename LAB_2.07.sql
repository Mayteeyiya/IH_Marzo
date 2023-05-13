# Lab 2.07

# In this activity we are going to do some database maintenance. In the current database we only have information 
#on movies for the year 2006. Now we have received the film catalog for 2020 as well. For this new data we will create 
#another table and bulk insert all the data there. Code to create a new table has been provided below.

USE sakila;


drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

# We have just one item for each film, and all will be placed in the new table. For 2020, the rental duration will be 3 
#days, with an offer price of 2.99€ and a replacement cost of 8.99€ (these are all fixed values for all movies for 
#this year). The catalog is in a CSV file named films_2020.csv that can be found at files_for_lab folder.


# Instructions
	# Add the new films to the database.
	# Update information on rental_duration, rental_rate, and replacement_cost.
    
   
# Hint
	# You might have to use the following commands to set bulk import option to ON:
    
show variables like 'local_infile';
set global local_infile = 1;

	# If bulk import gives an unexpected error, you can also use the data_import_wizard to insert data into the new table. 

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/maytee/Downloads/IRONHACK/*LABS/LABS_2/dataV3_Lesson_2.7_lab-main/dataV3_Lesson_2.7_lab-main/files_for_part1/films_2020.csv'
INTO TABLE films_2020
FIELDS TERMINATED BY ',';

SELECT * FROM films_2020;

UPDATE films_2020 SET rental_duration = 3;
UPDATE films_2020 SET rental_rate = 2.99;
UPDATE films_2020 SET replacement_cost = 8.99;

SELECT * FROM films_2020;


# Lab | SQL Queries - Lesson 2.7 Part 2

# 1. In the table actor, what last names are not repeated? For example if you would sort the data in the table actor by 
#last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the 
#same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time 
#with actor "Angelina Astaire", hence we would want this in our output list.

SELECT * FROM actor
ORDER BY last_name;

SELECT last_name from actor
GROUP BY last_name
HAVING count(*) = 1;


# 2. Which last names appear more than once? We would use the same logic as in the previous question but this time we 
#want to include the last names of the actors where the last name was present more than once

SELECT last_name, COUNT(*) AS count 
FROM actor 
GROUP BY last_name 
HAVING count > 1;

# 3. Using the rental table, find out how many rentals were processed by each employee. 

SELECT staff_id, COUNT(*) as processed_films
FROM rental
GROUP BY staff_id;


# 4. Using the film table, find out how many films were released.

SELECT * FROM film;

SELECT COUNT(release_year) FROM film;


# 5. Using the film table, find out how many films there are of each rating.

SELECT * FROM film;

SELECT rating, COUNT(*) as num_films
FROM film
GROUP BY rating;


# 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, ROUND(AVG(length), 2) AS mean_length
FROM film
GROUP BY rating;


# 7. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;


