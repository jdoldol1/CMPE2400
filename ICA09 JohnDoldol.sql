use NorthwindTraders

--q1
declare @usa as varchar(3) = 'USA'
select	CompanyName, ProductName, UnitPrice
from Suppliers inner join Products
on	Suppliers.SupplierID = Products.SupplierID
where Country = @usa
order by CompanyName,ProductName
go

--q2
declare @ul as varchar(2) = 'ul'
select 
	LastName + ', ' + FirstName as 'Name', 
	TerritoryDescription as 'Territory Description'
from Employees inner join EmployeeTerritories
on Employees.EmployeeID = EmployeeTerritories.EmployeeID 
inner join Territories 
on EmployeeTerritories.TerritoryID = Territories.TerritoryID
where LastName like '%' + @ul + '%'
order by TerritoryDescription
go

--q3
declare @sweden as varchar(6) = 'sweden'
select distinct
	CustomerID as 'Customer ID',
	ProductName as 'Product Name'
from Orders inner join [Order Details]
on Orders.OrderID = [Order Details].OrderID
inner join Products
on [Order Details].ProductID = Products.ProductID
where Orders.ShipCountry = @sweden and ProductName like '[u-z]%'
order by ProductName
go

--q4
select distinct
	CategoryName as 'Category Name',
	Products.UnitPrice as 'Product Price',
	[Order Details].UnitPrice as 'Selling Price'
from Categories inner join Products
on Categories.CategoryID = Products.CategoryID 
inner join [Order Details] 
on Products.ProductID = [Order Details].ProductID
where Products.UnitPrice <> [Order Details].UnitPrice and [Order Details].UnitPrice > 69
order by [Order Details].UnitPrice
go

--q5
declare @shipdue as int = 8
select distinct
	ShipName as 'Shipper',
	ProductName as 'Product Name'
from Orders inner join [Order Details]
on Orders.OrderID = [Order Details].OrderID
inner join Products
on [Order Details].ProductID = Products.ProductID
where Discontinued = 1 and (DATEDIFF(DAY,RequiredDate,ShippedDate) > @shipdue)
order by ShipName
go