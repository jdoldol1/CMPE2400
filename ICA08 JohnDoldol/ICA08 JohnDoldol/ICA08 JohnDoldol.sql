use NorthwindTraders

--q1
select top 1
	CompanyName as 'Supplier Company Name',
	Country as 'Country'
from Suppliers
order by Country
go

--q2
select top 1 with ties
	CompanyName as 'Supplier Company Name',
	Country as 'Country'
from Suppliers
order by Country
go

--q3
select top 10 percent
	ProductName as 'Product Name',
	UnitsInStock as 'Units in Stock'
from Products
order by [Units in Stock] desc

--q4
select 
	CompanyName as 'Customer Company Name',
	Country as 'Country'
from Customers
where CustomerID in 
	(
		select top 8 CustomerID
		from Orders
		order by Freight desc
	)
go

--q5
select
	CustomerID as 'Customer ID',
	OrderID as 'Order ID',
	convert(varchar,OrderDate,106) as 'Order Date'
from Orders
where OrderID in
	(
		select top 3 OrderID
		from [Order Details]
		order by Quantity desc
	)
order by [Customer ID]
go