SELECT f.title AS film_title , c.name AS category_name , f.rental_duration , NTILE(4) OVER (ORDER BY f.rental_duration) AS std_qun
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
WHERE c.name = 'Animation' OR c.name = 'Children' OR c.name = 'Classic' OR c.name = 'Comedy'
OR c.name = 'Family' OR c.name = 'Music';
