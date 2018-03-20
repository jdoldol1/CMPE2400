-- John Doldol
-- CMPE2400 - ICA10
-- February 26, 2018


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
select top 1
		p.ProductName as 'Product Name',
		od.Quantity
	from NorthwindTraders.dbo.Products p 
	left outer join NorthwindTraders.dbo.[Order Details] od
	on p.ProductID = od.ProductID
	order by od.Quantity desc
go

--q5
select top 10
	CompanyName as 'Company',
	ProductName as 'Product',
	Quantity
from Suppliers full join Products
on Suppliers.SupplierID = Products.SupplierID
full join [Order Details]
on Products.ProductID = [Order Details].ProductID
order by Quantity, CompanyName desc
go

--q6
	select CompanyName as 'Customer/Supplier with Nothing'
	from Customers left join Orders
	on Customers.CustomerID = Orders.CustomerID
	where OrderDate is null
union
	select CompanyName
	from Suppliers left join Products
	on Suppliers.SupplierID = Products.SupplierID
	where ProductName is null
order by CompanyName
go

--q7
declare @customer as varchar(8) = 'Customer'
declare @supplier as varchar(8) = 'Supplier'
	select
	@customer as 'Type',
	CompanyName as 'Customer/Supplier with Nothing'
	from Customers left join Orders
	on Customers.CustomerID = Orders.CustomerID 
	where OrderDate is null
union
	select 
	@supplier as 'Type',
	CompanyName as 'Customer/Supplier with Nothing'
	from Suppliers left join Products
	on Suppliers.SupplierID = Products.SupplierID
	where ProductName is null
go
	