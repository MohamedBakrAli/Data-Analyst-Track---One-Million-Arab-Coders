SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;


SELECT total, occurred_at, total_amt_usd
FROM orders
ORDER BY total
LIMIT 20;

SELECT total_amt_usd, occurred_at
FROM orders
ORDER BY total_amt_usd DESC, occurred_at 
LIMIT 5;


SELECT total_amt_usd, occurred_at
FROM orders
ORDER BY total_amt_usd , occurred_at 
LIMIT 10;

SELECT * 
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT name, website, primary_poc
FROM accounts
WHERE primary_poc = ' Exxon Mobil';

SELECT id, name
FROM accounts
WHERE name like 'C%';

SELECT id, name
FROM accounts
WHERE name like '%one%';

SELECT id, name
FROM accounts
WHERE name like '%s';

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic','adwors');

SELECT * 
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT id, name
FROM accounts 
WHERE name NOT LIKE 'C%' and name NOT LIKE 'S%';

SELECT id  
FROM orders 
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT id  
FROM orders 
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);



