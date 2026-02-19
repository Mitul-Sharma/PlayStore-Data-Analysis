USE playstore_db;
CREATE TABLE apps_data (
    app_name VARCHAR(255),
    developer VARCHAR(255),
    downloads VARCHAR(50),
    date_reached DATE,
    date_published DATE,
    category VARCHAR(255),
    pre_installed VARCHAR(50),
    app_type VARCHAR(50),
    price VARCHAR(50)
);
SELECT app_name FROM apps_data;

SELECT * FROM apps_data LIMIT 10;

DESCRIBE apps_data;

SELECT DISTINCT downloads FROM apps_data;

SELECT DISTINCT price FROM apps_data;

UPDATE apps_data
SET price = REPLACE(price, '$', '');

UPDATE apps_data
SET price = '0'
WHERE price = '';

ALTER TABLE apps_data
MODIFY COLUMN price DECIMAL(10,2);

DESCRIBE apps_data;

UPDATE apps_data
SET downloads = REPLACE(downloads, '+', '');

UPDATE apps_data 
SET downloads = REPLACE(downloads, ',', '');

SELECT DISTINCT downloads FROM apps_data;

UPDATE apps_data
SET downloads = SUBSTRING_INDEX(downloads, '-', 1)
WHERE downloads LIKE '%-%';

UPDATE apps_data
SET downloads = REPLACE(downloads, 'M', '') * 1000000
WHERE downloads LIKE '%M';

UPDATE apps_data
SET downloads = REPLACE(downloads, 'B', '') * 1000000000
WHERE downloads LIKE '%B';

ALTER TABLE apps_data
MODIFY COLUMN downloads BIGINT;
	
SELECT DISTINCT downloads 
FROM apps_data 
WHERE downloads NOT REGEXP '^[0-9]+$';

DESCRIBE apps_data;

SELECT app_name, downloads
FROM apps_data 
ORDER BY downloads DESC
LIMIT 5;

SELECT category, SUM(downloads) AS total_downloads
FROM apps_data
GROUP BY category 
ORDER BY total_downloads DESC
LIMIT 5;

SELECT price, SUM(downloads) 
FROM apps_data 
GROUP BY price
ORDER BY price ASC;

SELECT 
    CASE 
        WHEN price = 0 THEN 'Free' 
        ELSE 'Paid' 
    END AS app_type,
    SUM(downloads) AS total_downloads
FROM apps_data
GROUP BY CASE WHEN price = 0 THEN 'Free' ELSE 'Paid' END;

SELECT 
    developer,
    COUNT(app_name) AS total_apps,
    SUM(downloads) AS total_downloads,
    AVG(price) AS average_app_price
FROM apps_data
GROUP BY developer
ORDER BY total_downloads DESC
LIMIT 10;
