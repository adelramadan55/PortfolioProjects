select * from supermarkets_sales.dbo.supermarket_sales
select SUM(cogs) as total_male_cogs, Gender
from supermarkets_sales.dbo.supermarket_sales
where Gender='male'
group by Gender
select SUM(cogs) as total_female_cogs, Gender
from supermarkets_sales.dbo.supermarket_sales
where Gender='female'
group by Gender
select City,[Customer type], Gender, cogs
from supermarkets_sales.dbo.supermarket_sales
where [Customer type]='member'
order by cogs desc
select MAX([product line]) as max_product_line, Quantity
from supermarkets_sales.dbo.supermarket_sales
group by Quantity
select MAX([Tax 5%]) as max_tax, [Product line]
from supermarkets_sales.dbo.supermarket_sales
group by [Product line]
select MAX(Branch) as max_sales_branch, Quantity
from supermarkets_sales.dbo.supermarket_sales
group by Quantity
select MAX(Gender) as max_geneder_sales, Quantity
from supermarkets_sales.dbo.supermarket_sales
group by Quantity
order by Quantity desc
select MAX([gross income]) as max_gross_income_sales, Branch
from supermarkets_sales.dbo.supermarket_sales
group by Branch
order by Branch desc
select Rating, max(Branch)
from supermarkets_sales.dbo.supermarket_sales
group by Rating
order by Rating desc


 

