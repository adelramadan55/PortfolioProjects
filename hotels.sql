with hotels as (
select * from PortfolioProject2..hotelrevenue2018
union
select * from PortfolioProject2..hotelrevenue2019
union
select * from PortfolioProject2..hotelrevenue2020)

select * from hotels
left join PortfolioProject2..marketsegment
on hotels.market_segment = marketsegment.market_segment
left join dbo.mealcost
on dbo.mealcost.meal = hotels.meal