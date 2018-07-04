					---Video + Quiz: Write Your First Subquery---
					---------------------------------------------
-- prob 1
SELECT DATE_TRUNC('day',occurred_at), channel, COUNT(*) as cnt
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

-- prob 2
SELECT * 
FROM (SELECT DATE_TRUNC('day',occurred_at), channel, COUNT(*) as cnt
	 FROM web_events
	 GROUP BY 1,2
	 ORDER BY 3 DESC) sub;

-- prob 3
SELECT channel, AVG(cnt)
FROM (SELECT DATE_TRUNC('day',occurred_at), channel, COUNT(*) as cnt
	 FROM web_events
	 GROUP BY 1,2
	 ORDER BY 3 DESC) sub
GROUP BY 1;

					---Quiz: More On Subqueries---
					------------------------------
-- prob 1
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders;

-- prob 2
SELECT  AVG(standard_qty) st, AVG(gloss_qty) glo , AVG(poster_qty) pos
FROM orders
WHERE DATE_TRUNC('month',occurred_at) = 
	  (SELECT DATE_TRUNC('month', MIN(occurred_at))
		FROM orders);
SELECT  SUM (total_amt_usd) tot_usd
FROM orders
WHERE DATE_TRUNC('month',occurred_at) = 
	  (SELECT DATE_TRUNC('month', MIN(occurred_at))
		FROM orders);

	  				---Quiz: Subquery Mania---
	  				--------------------------
-- prob 1
SELECT  r_name, MAX(tot_usd)
FROM(SELECT r.name r_name, s.name s_name, SUM (total_amt_usd) tot_usd
	FROM sales_reps s
	JOIN accounts a ON s.id = a.sales_rep_id
	JOIN orders o ON  a.id = o.account_id
	JOIN region r ON r.id = s.region_id
	GROUP BY 1,2
	ORDER BY 2 DESC) t1
GROUP BY 1;

-- prob 2
SELECT r.name, count(o.total) total_orders
FROM sales_reps s
JOIN accounts a  ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
JOIN region r ON r.id = s.region_id
GROUP BY 1
HAVING SUM(o.total_amt_usd) = (SELECT MAX(tot_usd)
								FROM (SELECT s.region_id region_id, SUM (total_amt_usd) tot_usd
										FROM sales_reps s 
										JOIN accounts a ON s.id = a.sales_rep_id
										JOIN orders o ON o.account_id = a.id
										GROUP BY 1) t1 );

-- prob 3
SELECT a.name 
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY 1
HAVING SUM (o.total) > (SELECT total 
						FROM (SELECT a.id,SUM(o.standard_qty), SUM(o.total) total
						FROM accounts a 
						JOIN orders o ON a.id = o.account_id
						GROUP BY 1
						ORDER BY 2 DESC
						LIMIT 1) t1);

-- prob 4
SELECT a.name, w.channel, count(*)
From accounts a JOIN web_events w ON a.id = w.account_id
WHERE a.id = (SELECT  id_ FROM (SELECT a.id id_ , SUM (o.total_amt_usd) 
FROM orders o 
JOIN accounts a
ON o.account_id = a.id 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1) sub)
GROUP BY 1,2
ORDER BY 3 DESC;

-- prob 5
SELECT AVG(tot_spend)
FROM (SELECT a.id, SUM(o.total_amt_usd) tot_spend
FROM orders o 
JOIN accounts a ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10) t1;

-- prob 6
SELECT AVG(avg_amt)
FROM (SELECT a.id, AVG(o.total_amt_usd) avg_amt
	FROM orders o
	JOIN accounts a ON a.id = o.account_id
	GROUP BY 1
	HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
							   FROM orders o))t1;

			  				---Quiz: WITH---
			  				----------------
-- prob 1
WITH t1 AS (
	SELECT s.name s_name, r.name r_name, SUM(o.total_amt_usd) tot_usd
	FROM orders o 
	JOIN accounts a ON a.id = o.account_id
	JOIN sales_reps s ON a.sales_rep_id = s.id
	JOIN region r ON r.id = s.region_id
	GROUP BY 1,2
	ORDER BY 3 DESC),
t2 AS (
	SELECT r_name , MAX(tot_usd) tot_usd
	FROM t1
	GROUP BY 1)
SELECT t1.s_name, t1.r_name, t1.tot_usd
FROM t1 
JOIN t2 ON t1.r_name = t2.r_name AND t1.tot_usd = t2.tot_usd;

-- prob 2
WITH t1 AS (
	SELECT r.name r_name, SUM(o.total_amt_usd) tot_usd
	FROM orders o 
	JOIN accounts a ON a.id = o.account_id
	JOIN sales_reps s ON a.sales_rep_id = s.id
	JOIN region r ON r.id = s.region_id
	GROUP BY 1),
t2 AS (
	SELECT MAX(tot_usd) tot_usd
	FROM t1)
SELECT r.name, COUNT(o.total)
FROM sales_reps s
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON o.account_id = a.id
JOIN region r ON r.id = s.region_id
GROUP By 1
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

-- prob 3
WITH t1 AS (
	SELECT a.name a_name, SUM(o.standard_qty) standard_qty, SUM(o.total) total
	FROM accounts a
	JOIN orders o ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1),
t2 AS (
	SELECT a.name a_name
	FROM accounts a
	JOIN orders o ON a.id = o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT total FROM t1)
)
SELECT COUNT(*) cnt_orders
FROM t2;

-- prob 4
WITh t1 AS(
	SELECT a.id a_id, SUM(o.total_amt_usd) tot_usd
	FROM accounts a
	JOIN orders o ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1)
SELECT w.channel, COUNT(*)
FROM accounts a
JOIN web_events w ON a.id = w.account_id AND a.id = (SELECT a_id FROM t1)
GROUP BY 1
ORDER BY 2 DESC;

-- prob 5
WITH t1 AS (
	SELECT a.id, SUM(o.total_amt_usd) tot_usd
	FROM accounts a 
	JOIN orders o ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10)
SELECT AVG(tot_usd)
FROM t1;

-- prob 6
WITH t1 AS (
	SELECT AVG(o.total_amt_usd) avg_all
	FROM orders o),
t2 AS(
	SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
	FROM orders o
	GROUP by 1
	HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt) 
FROM t2;