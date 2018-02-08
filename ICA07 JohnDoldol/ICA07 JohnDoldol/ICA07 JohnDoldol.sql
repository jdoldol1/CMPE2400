--ICA07 John Doldol
--February 5, 2018

--q1
use NorthwindTraders
declare @freight as int = 800
select 
	LastName as 'Last Name', 
	Title as 'Title'
from Employees
where EmployeeID in
	(
		select EmployeeID
		from Orders
		where Freight > @freight
	)
order by [Last Name] 
go

--q2
declare @fval as int = 800
select
	LastName as 'Last Name',
	Title as 'Title'
from Employees as outy
where exists
(
	select EmployeeID
	from Orders as inny
	where (inny.Freight > @fval) and (inny.EmployeeID = outy.EmployeeID)
)
order by [Last Name]
go

--q3
select
	ProductName as 'Product Name',
	UnitPrice as 'Unit Price'
from Products
where SupplierID in
	(
		select distinct SupplierID
		from Suppliers
		where Country in('sweden','italy')
	)
order by UnitPrice
go	

--q4
select
	ProductName as 'Product Name',
	UnitPrice as 'Unit Price'
from Products as outy
where exists
	(
		select distinct SupplierID
		from Suppliers as iny
		where (outy.SupplierID = iny.SupplierID) and (iny.Country in('sweden','italy'))
	)
order by [Unit Price]
go

--q5
declare @unitvalue as int = 20
select ProductName
from Products as outter
where CategoryID in
	(
		select CategoryID
		from Categories
		where CategoryName in('seafood','confections')
	)
and UnitPrice > @unitvalue
order by CategoryID, ProductName
go

--q6
declare @uvalue as int = 20
select 
	ProductName
from Products as outy
where exists
	(
		select CategoryID
		from Categories as inny
		where (outy.CategoryID = inny.CategoryID) and 
		(inny.CategoryName in('seafood','confections'))
	)
and UnitPrice > @uvalue
order by CategoryID, ProductName
go

--q7
declare @cost as int = 15
select
	CompanyName as 'Company Name',
	Country as 'Country'
from Customers
where CustomerID in
	(
		select distinct CustomerID
		from Orders
		where OrderID in 
			(
				select OrderID
				from [Order Details]
				where (Quantity * UnitPrice) < @cost
			)	
	)
order by Country
go

--q8
declare @procost as int = 15
select
	CompanyName as 'Company Name',
	Country as 'Country'
from Customers as outside
where exists 
	(
		select distinct CustomerID
		from Orders as middle
		where (outside.CustomerID = middle.CustomerID) and exists
			(
				select OrderID
				from [Order Details] as inside
				where (middle.OrderID = inside.OrderID) and (inside.Quantity*inside.UnitPrice < @procost)
			) 
	)
order by Country
go

--q9
declare @due as int = 7
select ProductName
from Products
where ProductID in 
		(
			select ProductID
			from [Order Details]
			where OrderID in 
				(
					select OrderID
					from Orders
					where CustomerID in 
						(
							select CustomerID
							from Customers
							where Country in('UK','USA')
						) and ( DATEDIFF(day,RequiredDate,ShippedDate) > 7) 
				)
		)
order by ProductName
go

--q10
select OrderID, ShipCity
from Orders as outside
where OrderID in
		(
			select OrderID
			from [Order Details]
			where ProductID in 
				( 
					select ProductID
					from Products
					where SupplierID in 
						(
							select SupplierID
							from Suppliers
							where outside.ShipCity = City
						)
				)
		)
order by ShipCity
go
					



	


	










