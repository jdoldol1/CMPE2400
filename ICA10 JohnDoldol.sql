use NorthwindTraders

--q1
select
	CompanyName as 'Company Name',
	ProductName as 'Products Name',
	UnitPrice as 'Unit Price'
from Suppliers left outer join Products
on Suppliers.SupplierID = Products.SupplierID
order by [Company Name], ProductName
go

--q2
select
	CompanyName as 'Company Name',
	ProductName as 'Products Name',
	UnitPrice as 'Unit Price'
from Suppliers left outer join Products
on Suppliers.SupplierID = Products.SupplierID
where ProductName is null
order by [Company Name], ProductName
go

--q3
select
	CONCAT(LastName, ', ', FirstName) as 'Name',
	OrderDate as 'Order Date'
from Employees left outer join Orders 
on Employees.EmployeeID = Orders.EmployeeID
where OrderDate is null
order by LastName
go

--q4
select top 5
	ProductName as 'Product Name',
	Quantity
from Products left outer join [Order Details] 
on Products.ProductID = [Order Details].ProductID
order by Quantity
go

--q5