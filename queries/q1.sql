SELECT f.title AS film_title , c.name AS category_name , COUNT(*) AS rental_count
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r 
ON  r.inventory_id = i.inventory_id
WHERE c.name = 'Animation' OR c.name = 'Children' OR c.name = 'Classic' OR c.name = 'Comedy'
OR c.name = 'Family' OR c.name = 'Music'
GROUP BY 1,2 
ORDER BY 2;
