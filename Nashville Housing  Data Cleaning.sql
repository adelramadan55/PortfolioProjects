select * from portfolioproject..[Nashville Housing]
select saledateconverted, convert(date, saledate)
from portfolioproject..[Nashville Housing]
update portfolioproject..[Nashville Housing]
set saledate = convert(date, saledate)
alter table portfolioproject..[Nashville Housing]
add saledateconverted date
update portfolioproject..[Nashville Housing]
set saledateconverted = convert(date, saledate)
select *
from portfolioproject..[Nashville Housing]
--where PropertyAddress is null
order by ParcelID
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress)
from portfolioproject..[Nashville Housing] a
join portfolioproject..[Nashville Housing] b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null
update a 
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from portfolioproject..[Nashville Housing] a
join portfolioproject..[Nashville Housing] b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select PropertyAddress
from portfolioproject..[Nashville Housing]
--where PropertyAddress is null
--order by ParcelID

select SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, len(propertyaddress)) as address
from portfolioproject..[Nashville Housing]

alter table portfolioproject..[Nashville Housing]
add propertyaddresssplite nvarchar(255)
update portfolioproject..[Nashville Housing]
set propertyaddresssplite = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

alter table portfolioproject..[Nashville Housing]
add propertyaddresscity nvarchar(255)
update portfolioproject..[Nashville Housing]
set propertyaddresscity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, len(propertyaddress))

select * from portfolioproject..[Nashville Housing]
select owneraddress from portfolioproject..[Nashville Housing]
select 
PARSENAME(replace(owneraddress, ',', '.'), 3)
,PARSENAME(replace(owneraddress, ',', '.'), 2)
,PARSENAME(replace(owneraddress, ',', '.'), 1)
from portfolioproject..[Nashville Housing]

alter table portfolioproject..[Nashville Housing]
add owneraddresssplite nvarchar(255)
update portfolioproject..[Nashville Housing]
set owneraddresssplite = PARSENAME(replace(owneraddress, ',', '.'), 3)

alter table portfolioproject..[Nashville Housing]
add owneraddresscity nvarchar(255)
update portfolioproject..[Nashville Housing]
set owneraddresscity = PARSENAME(replace(owneraddress, ',', '.'), 2)

alter table portfolioproject..[Nashville Housing]
add owneraddressstate nvarchar(255)
update portfolioproject..[Nashville Housing]
set owneraddressstate = PARSENAME(replace(owneraddress, ',', '.'), 1)

select * from portfolioproject..[Nashville Housing]

select distinct(SoldAsVacant), count(soldasvacant)
from portfolioproject..[Nashville Housing]
group by soldasvacant
order by 2

select SoldAsVacant
, case when soldasvacant = 'y' then 'yes'
     when soldasvacant = 'n' then 'no'
	 else soldasvacant
	 end
from portfolioproject..[Nashville Housing]
update portfolioproject..[Nashville Housing]
set SoldAsVacant =  case when soldasvacant = 'y' then 'yes'
     when soldasvacant = 'n' then 'no'
	 else soldasvacant
	 end
	 with rownumcte as(
	 select *,
	 ROW_NUMBER() over(
	 partition by parcelid,
	 propertyaddress,
	 saleprice,
	 saledate,
	 legalreference
	 order by uniqueid
	 ) row_num
	 from portfolioproject..[Nashville Housing]
 --order by ParcelID
 )
 select * from rownumcte
 where row_num > 1
 order by PropertyAddress



	 alter table portfolioproject..[Nashville Housing]
	 drop column owneraddress, propertyaddress, taxdistrict

	 alter table portfolioproject..[Nashville Housing]
	 drop column saledate