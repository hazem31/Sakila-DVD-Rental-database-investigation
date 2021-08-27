SELECT DATE_PART('month',r.rental_date) AS Rental_month , DATE_PART('year',r.rental_date) AS Rental_year , se.store_id , COUNT(*) AS count_rentals
FROM rental r
JOIN staff sf
ON sf.staff_id = r.staff_id
JOIN store se
ON se.store_id = sf.store_id
GROUP BY 1,2,3;

SELECT DATE_TRUNC('month',p.payment_date) AS pay_month , c.first_name || ' ' || c.last_name AS full_name , COUNT(*) AS pay_countpermonth , SUM(p.amount) AS pay_amount 
FROM customer c
JOIN rental r
ON r.customer_id = c.customer_id
JOIN payment p
ON p.rental_id = r.rental_id
WHERE c.customer_id IN (SELECT customer_id 
					   FROM (SELECT c.customer_id , SUM(p.amount) 
							 FROM customer c 
							 JOIN rental r
							 ON r.customer_id = c.customer_id
							 JOIN payment p
							 ON p.rental_id = r.rental_id
							 GROUP BY  1
							 ORDER BY 2 DESC
							 LIMIT 10) AS t2) AND DATE_PART('year',p.payment_date) = 2007
GROUP BY 1,2
ORDER BY 2;
