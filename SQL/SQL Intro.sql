# 1. Review the tables in the database.
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'sakila';

# 2. Explore tables by selecting all columns from each table or using the in built review features for your client.
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'film'
ORDER BY ORDINAL_POSITION

SELECT * FROM film;

# 3. Select one column from a table. Get film titles.
# SELECT "column_name1", "column_name2", "column_name3" FROM "table_name";
SELECT "title" FROM "film";

# 4. Select one column from a table and alias it. Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.
SELECT u.col1 AS u_col1
SELECT language_id AS language;

# 5.1 Find out how many stores does the company have?
SELECT COUNT(stores)
FROM company;

# 5.2 Find out how many employees staff does the company have?
SELECT COUNT(employees)
FROM company;

# 5.3 Return a list of employee first names only?
SELECT  first_name, 
FROM employees;
