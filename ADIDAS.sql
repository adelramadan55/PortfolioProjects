select * from dbo.adidassalesdata
select retailerid, city, unitssold, operatingprofit, salesmethod
from dbo.adidassalesdata
order by operatingprofit desc
select retailer, retailerid, invoicedate, region, operatingmargin, salesmethod 
from dbo.adidassalesdata
where salesmethod = 'in-store'
order by invoicedate desc

