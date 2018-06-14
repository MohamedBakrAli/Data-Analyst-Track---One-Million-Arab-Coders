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