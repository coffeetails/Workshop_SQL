# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
#
SELECT 
    nm, population
FROM
    city
WHERE
    nm LIKE 'ping%'
ORDER BY population;

#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
#
SELECT 
    nm, population
FROM
    city
WHERE
    nm LIKE 'ran%'
ORDER BY population DESC;

#
# 3: Count all cities
#
SELECT count(*) FROM city;

#
# 4: Get the average population of all cities
#
SELECT avg(population) FROM city;

#
# 5: Get the biggest population found in any of the cities
#
SELECT max(population) FROM city;

#
# 6: Get the smallest population found in any of the cities
#
SELECT min(population) FROM city;

#
# 7: Sum the population of all cities with a population below 10000
#
SELECT sum(population) FROM city WHERE population < 10000;

#
# 8: Count the cities with the countrycodes MOZ and VNM
#
SELECT 
    COUNT(*)
FROM
    city
WHERE
    countrycode IN ('moz' , 'vnm');

#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
#
SELECT 
    countrycode, COUNT(*)
FROM
    city
WHERE
    countrycode IN ('moz' , 'vnm')
GROUP BY countrycode;

#
# 10: Get average population of cities in MOZ and VNM
#
SELECT avg(population) FROM city WHERE countrycode IN ("moz", "vnm");

#
# 11: Get the countrycodes with more than 200 cities
#
SELECT 
    country.name, country.code, COUNT(*)
FROM
    country
        INNER JOIN
    city ON country.code = city.countrycode
GROUP BY country.name , country.code
HAVING COUNT(*) > 200; 

#
# 12: Get the countrycodes with more than 200 cities ordered by city count
#
SELECT 
    country.name, country.code, COUNT(*)
FROM
    country
        INNER JOIN
    city ON country.code = city.countrycode
GROUP BY country.name , country.code
HAVING COUNT(*) > 200
ORDER BY COUNT(*); 

#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
#
SELECT
	city.nm, countrylanguage.language, city.population
FROM 
	city
		INNER JOIN
	countrylanguage ON countrylanguage.countrycode = city.countrycode
WHERE city.population BETWEEN 400 AND 500;

#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
#
SELECT
	city.nm, countrylanguage.language, city.population
FROM 
	city
		INNER JOIN
	countrylanguage ON countrylanguage.countrycode = city.countrycode
WHERE city.population BETWEEN 500 AND 600;

#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
#
SELECT 
    country.name,
    country.code,
    city.countrycode,
    city.nm,
    city.population
FROM
    city
        INNER JOIN
    country ON country.code = city.countrycode
WHERE
    country.code = (
		SELECT 
            countrycode
        FROM
            city
        WHERE
            city.population = 122199
	);

#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
#
SELECT 
    country.name,
    country.code,
    city.countrycode,
    city.nm,
    city.population
FROM
    city
        INNER JOIN
    country ON country.code = city.countrycode
WHERE
    country.code = (
		SELECT countrycode
        FROM city
        WHERE city.population = 122199
	)
	AND NOT city.population = 122199;

#
# 17: What are the city names in the country where Luanda is capital?
#
SELECT 
    country.name,
    city.nm
FROM
    city
        INNER JOIN
    country ON country.code = city.countrycode
WHERE
    country.code = (
		SELECT city.countrycode
        FROM city
        WHERE city.nm = "Luanda"
	);
    
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
#
SELECT
	*
FROM
	city
		INNER JOIN
	country ON country.capital = city.id;

#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
#
SELECT
	distinct(countrylanguage.language)
FROM
	country
		INNER JOIN
	countrylanguage ON countrylanguage.countrycode = country.code
		INNER JOIN
	city ON city.countrycode = country.code
		WHERE country.region = (
		SELECT 
			country.region
		FROM 
			city
				INNER JOIN
			country on country.code = city.countrycode
		WHERE city.nm = "Riga");
    
#
# 20: Get the name of the most populous city
#

SELECT
	nm, population
FROM
	city
WHERE 
	population = (
		SELECT max(population)
        FROM city
	);
    
-- SELECT max(population)
-- FROM city;
