-- confirm the conversion worked cleanly
select count(*) as total_rows from retailcombined;

select count(*) as failed_rows from retailcombined 
where invoiceDate is NULL;

select count(*) as failed_prices from retailcombined 
where price is NULL;