			--QUIZ 4
-- prob 1
SELECT *
FROM accounts JOIN orders
ON accounts.id = orders.account_id;

-- prob 2
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

			-- QUIZ 11
-- prob 1
select a.primary_poc, w.occurred_at, w.channel
from accounts as a join web_events as w on (w.account_id = a.id)
where a.name = 'Walmart';


-- prob 2

select r.name as r_name, s.name as s_name , a.name as a_name
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
order by a.name;

-- prob 3

select r.name as r_name, a.name as a_name,  (o.total_amt_usd/(o.total+ 0.01)) as unit_price
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
join orders as o on (a.id = o.account_id);

			-- QUIZ LAST CHECK
-- prob 1
select r.name as r_name, s.name as s_name , a.name as a_name
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
where r.name = 'Midwest'
order by a.name;

-- prob 2
select r.name as r_name, s.name as s_name , a.name as a_name
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
where r.name = 'Midwest' and s.name like 'S%'
order by a.name; 

-- prob 3
select r.name as r_name, s.name as s_name , a.name as a_name
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
where r.name = 'Midwest' and s.name like '% K%'
order by a.name; 

-- prob 4
select r.name as r_name, a.name as a_name,  (o.total_amt_usd/(o.total+ 0.01)) as unit_price
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
join orders as o on (a.id = o.account_id)
where standard_amt_usd > 100;

-- prob 5
select r.name as r_name, a.name as a_name,  (o.total_amt_usd/(o.total+ 0.01)) as unit_price
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
join orders as o on (a.id = o.account_id)
where standard_amt_usd > 100 and poster_qty > 50
order by unit_price;

-- prob 6
select r.name as r_name, a.name as a_name,  (o.total_amt_usd/(o.total+ 0.01)) as unit_price
from region as r join sales_reps as s on (s.region_id = r.id) join accounts as a on (s.id = a.sales_rep_id)
join orders as o on (a.id = o.account_id)
where standard_amt_usd > 100 and poster_qty > 50
order by unit_price DESC;

-- prob 7
select a.name, w.channel
from accounts as a join web_events as w on (w.account_id = a.id)
where a.id = 1001;

-- prob 8
select o.accurred_at, a.name, o.total, o.total_amt_usd
from orders as o join accounts as a on (o.account_id = a.id)
where o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

