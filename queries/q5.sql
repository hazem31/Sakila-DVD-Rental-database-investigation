SELECT DISTINCT DATE_TRUNC('month',p.payment_date) AS pay_month , c.first_name || ' ' || c.last_name AS full_name , SUM(p.amount) OVER (PARTITION BY c.customer_id ORDER BY DATE_TRUNC('month',p.payment_date) ) AS pay_amount 
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


ORDER BY 2