use NorthwindTraders

--q1
declare @usa as varchar(3) = 'USA'
select	CompanyName, ProductName, UnitPrice
from Suppliers inner join Products
on	Suppliers.SupplierID = Products.SupplierID
where Country = @usa
order by CompanyName,ProductName

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

--q3