SELECT 
    *
FROM
    retail_cleaned;
    
 SHOW VARIABLES LIKE 'secure_file_priv';
 
SELECT 'invoice','stockcode','description','quantity','invoicedate','Price','customer_id','country','sourcesheet'
UNION ALL
SELECT invoice, stockcode, description, quantity, invoicedate, Price, customer_id, country, sourcesheet
FROM retail_cleaned
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/retail_full.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n';

SELECT 'invoice','stockcode','description','quantity','invoicedate','Price','customer_id','country','sourcesheet'
UNION ALL
SELECT invoice,
       IFNULL(stockcode,''),
       IFNULL(description,''),
       IFNULL(quantity,''),
       invoicedate,
       IFNULL(Price,''),
       IFNULL(customer_id,''),
       IFNULL(country,''),
       IFNULL(sourcesheet,'')
FROM retail_cleaned
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/retail_full2.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n';