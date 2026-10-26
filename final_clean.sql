-- duplicate and produce the final clean table

CREATE TABLE retail_cleaned AS
with del_dup_row as (
        select *,
        row_number() over ( partition by invoice, stockcode, description, quantity, invoicedate, Price, customer_id, country
        order by (select NULL)
        ) as RowNum
        from retailcombined
)
select invoice, stockcode, description, quantity, invoicedate, Price, customer_id, country, sourcesheet
from del_dup_row
where RowNum =1;
SELECT * FROM retail_cleaned;
SELECT COUNT(*) FROM retailcombined;

-- almost 35000 rows were duplicated