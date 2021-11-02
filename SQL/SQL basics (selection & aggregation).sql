#Instructions
#Assume that any _id columns are incremental, meaning that higher ids always occur after lower ids. 
#For example, a client with a higher client_id joined the bank after a client with a lower client_id.

USE bank

# 1. Get the id values of the first 5 clients from district_id with a value equals to 1.

SELECT * FROM client
WHERE district_id=1
LIMIT 5;

# 2. In the client table, get an id value of the last client where the district_id equals to 72.
SELECT * FROM client
WHERE district_id=72
order by district_id desc;


# 3. Get the 3 lowest amounts in the loan table.
### JUST GET ONE AMOUNT NOT 3 

SELECT 
    MIN(amount)
FROM
    loan
LIMIT 3;

# 4. What are the possible values for status, ordered alphabetically in ascending order in the loan table?

SELECT 
   status
FROM 
   bank.loan
ORDER BY 
   status asc;

#5. What is the loan_id of the highest payment received in the loan table?
select loan_id,max(payments) as max_p from loan 
group by loan_id 
order by max_p desc 
limit 1

# 6. What is the loan amount of the lowest 5 account_ids in the loan table? 
# Show the account_id and the corresponding amount
SELECT account_id, amount
FROM bank.loan
ORDER BY account_id
LIMIT 5;

# 7. What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT
account_id as id,
amount
from bank.loan
order by account_id asc
limit 5;

# 8. What are the unique values of k_symbol in the order table?
# Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. You have to use backticks to escape the order table name.
SELECT DISTINCT (k_symbol) FROM bank.order where k_symbol = " " order by k_symbol;

#9. In the order table, what are the order_ids of the client with the account_id 34?
SELECT order_id
FROM bank.order
WHERE account_id = 34;

#10. In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
### ERROR SYNTAX ?????
SELECT DISTINCT account_id
FROM bank.order
WHERE order_id >= 29540 AND order_id <= 29560;

#11. In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
SELECT amount
FROM bank.order
WHERE account_to = 30067122;

#12. In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
SELECT trans_id, date, type, amount
FROM trans
WHERE account_id = 793
ORDER by date desc 
LIMIT 10;

#13. In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
### ERROR 
SELECT COUNT(client_id), district_id
FROM client
WHERE district_id <10
GROUP BY district_id
ORDER by district_id asc;

#14. In the card table, how many cards exist for each type? 
# Rank the result starting with the most frequent type.

SELECT COUNT(type)
FROM card
GROUP BY type;

# OPTIONAL
#15. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

SELECT account_id, SUM(amount)
FROM loan
GROUP BY account_id
ORDER BY SUM(amount) desc
limit 10;

#16. In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

SELECT date, count(loan_id)
FROM loan
WHERE date < 930907 
GROUP BY date
ORDER BY date desc;

