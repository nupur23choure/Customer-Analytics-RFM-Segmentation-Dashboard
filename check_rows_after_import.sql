-- check rows after import
use ecommercecustomeranalytics
select count(*) from year_2009_2010;
-- 525461
select count(*) from year_2010_2011;
-- 541910

describe year_2009_2010;
describe year_2010_2011;

-- rename a colum
ALTER TABLE year_2009_2010 RENAME COLUMN `Customer ID` TO customer_id;
ALTER TABLE year_2010_2011 RENAME COLUMN `Customer ID` TO customer_id;

-- combine both year and convert types

CREATE TABLE retailcombined AS
SELECT invoice, stockcode, description, quantity,
       COALESCE(
           STR_TO_DATE(invoicedate, '%d-%m-%Y %H:%i'),
            STR_TO_DATE(invoicedate, '%d-%m-%Y %H:%i:%s'),
			STR_TO_DATE(invoicedate, '%d/%m/%Y %H:%i'),
            STR_TO_DATE(invoicedate, '%Y-%m-%d %H:%i:%s')
       ) AS invoicedate,
       CAST(Price AS DECIMAL(10,2)) AS Price,
       customer_id, country,
       '2009-2010' AS sourcesheet
FROM year_2009_2010

UNION ALL

SELECT invoice, stockcode, description, quantity,
       COALESCE(
            STR_TO_DATE(invoicedate, '%d-%m-%Y %H:%i'),
            STR_TO_DATE(invoicedate, '%d-%m-%Y %H:%i:%s'),
			STR_TO_DATE(invoicedate, '%d/%m/%Y %H:%i'),
            STR_TO_DATE(invoicedate, '%Y-%m-%d %H:%i:%s')
       ) AS invoicedate,
       CAST(Price AS DECIMAL(10,2)) AS Price,
       customer_id, country,
       '2010-2011' AS sourcesheet
FROM year_2010_2011;

SELECT invoicedate FROM year_2009_2010 LIMIT 20;
SELECT invoicedate FROM year_2010_2011 LIMIT 20;
