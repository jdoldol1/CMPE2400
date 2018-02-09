use NorthwindTraders

--q1
select top 1
	CompanyName as 'Supplier Company Name',
	Country as 'Country'
from Suppliers
order by Country
go

--q2