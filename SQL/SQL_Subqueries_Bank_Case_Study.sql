/*
Subqueries - bank case study
*/

use bank;

/*

Exercise 1:

We want to identify the customers who have borrowed more than the average amount. 

*/

-- step 1: calculate the average
select avg(amount) from bank.loan;

-- step 2 --> pseudo code the main goal of this step ....
# Give me the customers who has borrowed amount larger than the average amount by customer 
select * from bank.loan
where amount > "AVERAGE";

-- step 3 ... create the query
select * from bank.loan
where amount > (
  select avg(amount)
  from bank.loan
);

-- step 4 - Prettify the result. Let's find top 10 such customers
select * from bank.loan
where amount > (select avg(amount)
from bank.loan)
order by amount desc
limit 10;

/*
Exercise 2:
Select the banks from the list of banks which have average transaction amounts higher than 5.5K and are not ‘ST’
Select orders (payments) grouped by account_id, bank_to and account_to
Get for each account, the total amount transferred, destination bank and destination account
*/
-- basic query:

#Child Query 
SELECT account_id, max(bank_to), max(account_to), round(sum(amount),2) as Total FROM bank.order
GROUP BY account_id;

-- ...if we wanna filter rows with Total > x, we can use a subquery:

#Parent Query, using a subquery
select * from (
  select account_id, bank_to, account_to, round(sum(amount),2) as Total
  from bank.order
  group by account_id, bank_to, account_to
)  as sub1
where Total > 10000;

-- ...or we can do the same without a subquery with HAVING:

  select account_id, bank_to, account_to, round(sum(amount),2) as Total
  from bank.order
  group by account_id, bank_to, account_to
  having total > 10000;

/*
Exercise 3:
Select the banks from the list of banks which have average transaction amounts higher than 5.5K and are not ‘ST’
find those banks from the trans table where the average amount of transactions is over 5500
*/
-- basic query:

-- ...this way, we can easily get all the orders from those banks:
#Child Query
SELECT bank, avg(amount) as Average 
FROM bank.trans
WHERE bank not in  ('',' ')
GROUP BY bank # Grouping all average transactions on a specific bank 
HAVING Average > 5500;

-- ...if we want just the names of the banks, we need to use a subquery:
# Full query:
SELECT bank FROM 
(select bank, round(avg(amount),2) as Average from bank.trans
WHERE bank not in  ('',' ')
GROUP BY bank # Grouping all average transactions on a specific bank 
HAVING Average > 5500) as sub1
WHERE bank <> 'ST';

/*
Exercise 4:
Which transactions of bank.trans are in the list (In this query we are trying to find the k_symbols based on the average amount from the table order. The average amount should be more than 3000)
find the k_symbols based on the average amount from the table order.
The average amount should be more than 3000.
 */
-- basic query:

# Child query:
select k_symbol, round(avg(amount),2) as Average from bank.order
where k_symbol not in ('',' ')
group by k_symbol
having Average > 3000;

-- ... now we can easily get all the transactions with those k_symbols:
# Full query:
select * from bank.trans
where k_symbol in (
  select k_symbol as symbol from (
    select avg(amount) as Average, k_symbol
    from bank.order
    where k_symbol <> ' '
    group by k_symbol
    having Average > 3000
    order by Average desc
  ) sub1
);




