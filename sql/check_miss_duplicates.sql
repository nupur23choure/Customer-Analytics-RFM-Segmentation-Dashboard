SET SQL_SAFE_UPDATES = 0;
UPDATE retailcombined
SET customer_id = CASE
        WHEN TRIM(customer_id) = '' OR UPPER(TRIM(customer_id)) IN ('NULL','NAN','NA')
        THEN NULL ELSE customer_id END,
    description = CASE
        WHEN TRIM(description) = '' OR UPPER(TRIM(description)) IN ('NULL','NAN','NA')
        THEN NULL ELSE description END;
SET SQL_SAFE_UPDATES = 1;

-- check1 Missing customer id-- 
select count(*) as missing_customer_id from retailcombined
where customer_id is NULL;

-- check 2 negative or zero quantity
select count(*) as negative_quant from retailcombined
where quantity<=0;

-- check 3 Missing description
select count(*) as miss_description from retailcombined
where description is NULL; 

-- check 4 exact duplicate rows
select invoice, stockcode, description, quantity, invoicedate, Price, customer_id, country,
count(*) as exact_dup_count
from retailcombined
group by invoice, stockcode, description, quantity, invoicedate, Price, customer_id, country
having count(*) >1;


