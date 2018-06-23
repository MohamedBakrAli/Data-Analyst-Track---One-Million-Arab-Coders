				 		   -- Quiz: SUM--
				 		 -----------------
-- prob 1
SELECT SUM(poster_qty) from orders;

-- prob 2
SELECT SUM(standard_qty) from orders;

-- prob 3
SELECT SUM(total_amt_usd) from orders;

-- prob 4
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

-- prob 5
SELECT SUM(standard_amt_usd)/ SUM(standard_qty)
from orders;

				
						--Quiz: MIN, MAX, & AVG--
					   ----------------------------

-- prob 1
SELECT MIN(occurred_at) FROM orders;

-- prob 2
SELECT occurred_at FROM orders
WHERE occurred_at <= ALL (SELECT occurred_at FROM orders);

-- prob 3
SELECT MAX(occurred_at) FROM web_events;

-- prob 4
SELECT occurred_at FROM web_events
WHERE occurred_at >= ALL (SELECT occurred_at FROM web_events);

-- prob 5
SELECT AVG(standard_qty) as avg_standard_qty, AVG(gloss_qty) as avg_gloss_qty,
AVG(poster_qty) as avg_poster_qty, AVG(total) as avg_total,
AVG(standard_amt_usd) as avg_standard_amt_usd, AVG(gloss_amt_usd) as avg_gloss_amt_usd,
AVG(poster_amt_usd) as avg_poster_amt_usd, AVG(total_amt_usd) as avg_total_amt_usd
FROM orders;

-- prob 6
SELECT
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

						--Quiz: GROUP BY--
					   --------------------

-- prob 1
SELECT a.name, MIN(o.occurred_at) 
FROM accounts a JOIN orders  o on (a.id =o.account_id)
GROUP BY name
LIMIT 1;

-- prob 2
SELECT a.name, SUM(o.total_amt_usd) 
FROM accounts a JOIN orders  o on (a.id =o.account_id)
GROUP BY name;

-- prob 3
SELECT a.name, MIN(w.occurred_at) min, w.channel
FROM accounts a JOIN web_events w on a.id = w.account_id
GROUP BY (w.channel,a.name)
ORDER BY min
LIMIT 1;

-- prob 4
SELECT channel, COUNT(*) times
FROM web_events 
GROUP BY channel;

-- prob 5
SELECT a.primary_poc
FROM accounts a JOIN web_events w on (a.id = w.account_id)
GROUP BY a.primary_poc
ORDER BY w.occurred_at
LIMIT 1;

-- prob 6
SELECT a.name, MIN(o.total_amt_usd) small_total
FROM accounts a JOIN orders o on (a.id = o.account_id)
GROUP BY a.name
ORDER BY small_total;

-- prob 7
SELECT r.name , count(*) cnt
FROM region r JOIN sales_reps s ON (r.id = s.region_id)
GROUP BY r.name
ORDER BY cnt;

						--Quiz: GROUP BY Part || --
					   --------------------
-- prob 1
SELECT a.name, AVG(o.standard_qty) avg_standard_qty,AVG(o.gloss_qty) avg_gloss_qty, AVG(o.poster_qty) avg_poster_qty
FROM accounts a JOIN orders o ON a.id = o.account_id
GROUP BY a.name

-- prob 2
SELECT a.name, AVG(o.standard_amt_usd ) avg_standard_amt_usd ,
AVG(o.gloss_amt_usd ) avg_gloss_amt_usd, AVG(o.poster_amt_usd ) avg_poster_amt_usd 
FROM accounts a JOIN orders o ON a.id = o.account_id
GROUP BY a.name

-- prob 3
SELECT s.name, w.channel, COUNT(*) occurrences
FROM accounts a JOIN sales_reps s ON a.sales_rep_id = s.id JOIN web_events w ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY occurrences DESC;

-- prob 4
SELECT r.name, w.channel, COUNT(*) occurrences
FROM accounts a JOIN sales_reps s ON a.sales_rep_id = s.id JOIN web_events w ON a.id = w.account_id
JOIN region r ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY occurrences DESC;

						--Quiz: DISTINCT--
					   --------------------
-- prob 1
SELECT DISTINCT a.id account_id, r.id region_id
FROM accounts a JOIN sales_reps s ON a.sales_rep_id = s.id JOIN region r ON r.id = s.region_id;

SELECT DISTINCT id, name 
FROM accounts;

-- prob 2
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;


SELECT id 
FROM Sales_reps;

						--Quiz: HAVING--
					   --------------------
-- prob 1
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

-- prob 2
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

-- prob 3
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC 
LIMIT 1;

-- prob 4
SELECT a.id, a.name, SUM(total_amt_usd) total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(total_amt_usd) > 30000
ORDER BY total_amt_usd DESC;

-- prob 5
SELECT a.id, a.name, SUM(total_amt_usd) total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(total_amt_usd) < 1000
ORDER BY total_amt_usd DESC;

-- prob 6
SELECT a.id, a.name, SUM(total_amt_usd) total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_amt_usd DESC
LIMIT 1;

-- prob 7
SELECT a.id, a.name, SUM(total_amt_usd) total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_amt_usd
LIMIT 1;

-- prob 8
SELECT a.id, a.name, COUNT(*) cnt
FROM accounts a 
JOIN web_events w ON a.id = w.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY cnt;

-- prob 9
SELECT a.id, a.name, COUNT(*) cnt
FROM accounts a 
JOIN web_events w ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name
HAVING COUNT(*) > 6
ORDER BY cnt DESC
LIMIT 1;

-- prob 10
SELECT w.channel, COUNT(*) cnt 
FROM accounts a 
JOIN web_events w ON a.id = w.account_id
GROUP BY w.channel
ORDER BY cnt DESC
LIMIT 1;

						--Quiz: DATE functions--
					      --------------------
-- prob 1
SELECT DATE_TRUNC('year', occurred_at) year_date, SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- prob 2
SELECT DATE_PART('month', occurred_at) month_date, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

-- prob 3
SELECT DATE_PART('year', occurred_at) year_date, SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- prob 4
SELECT DATE_PART('month', occurred_at) month_date, COUNT(*) cnt
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

-- prob 5
SELECT DATE_PART('month', occurred_at) month_date, SUM(o.gloss_amt_usd) total
FROM orders o JOIN accounts a ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

							--Quiz: CASE--
					      --------------------
-- prob 1
SELECT a.name, SUM(total_amt_usd) total_spent,
CASE WHEN SUM(total_amt_usd) > 200000 THEN 'greater than 200,000'
WHEN SUM(total_amt_usd) > 100000 THEN 'between 200,000 and 100,000' ELSE 'under 100,000' END AS level
FROM orders o JOIN accounts a ON o.account_id = a.id
GROUP BY total_spent
ORDER BY 2 DESC;

-- prob 2 
SELECT a.name, SUM(total_amt_usd) total_spent,
CASE WHEN SUM(total_amt_usd) > 200000 THEN 'greater than 200,000'
WHEN SUM(total_amt_usd) > 100000 THEN 'between 200,000 and 100,000' ELSE 'under 100,000' END AS level
FROM orders o JOIN accounts a ON o.account_id = a.id
WHERE DATE_PART('year', o.occurred_at) = 2016 OR DATE_PART('year', o.occurred_at) = 2017
GROUP BY total_spent
ORDER BY total DESC;

-- prob 3
SELECT s.id, s.name, COUNT(*) order_cnt,
CASE WHEN COUNT(*) > 200 THEN 'top'
ELSE 'not' END AS level
FROM accounts a JOIN sales_reps as s ON a.sales_rep_id = s.id JOIN orders o ON a.id = o.account_id
GROUP BY s.id, s.name
ORDER BY order_cnt DESC;

-- prob 4
SELECT s.id, s.name, COUNT(*) order_cnt, SUM(o.total_amt_usd) Total,
CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
ELSE 'not' END AS level
FROM accounts a JOIN sales_reps as s ON a.sales_rep_id = s.id JOIN orders o ON a.id = o.account_id
GROUP BY s.id, s.name
ORDER BY Total DESC;

	