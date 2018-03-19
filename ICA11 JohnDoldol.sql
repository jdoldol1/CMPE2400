---q1
select
	concat(e.LastName, ', ', e.FirstName) as 'Name',
	count(e.EmployeeID) as 'Num Orders'
from Employees as e inner join Orders
on e.EmployeeID = Orders.EmployeeID
group by e.LastName, e.FirstName
order by 'Num Orders' desc
go

--q2
select 
	CONCAT(e.LastName, ', ', e.FirstName) as 'Name',
	AVG(o.Freight) as 'Average Freight',
	convert(varchar,max(o.OrderDate),106) as 'Newest Order Date'
from Employees as e inner join Orders as o
on e.EmployeeID = o.EmployeeID
group by e.LastName, e.FirstName
order by max(o.OrderDate), e.LastName
 go

--q3
select
	s.CompanyName as 'Supplier',
	s.Country,
	count(p.ProductID) as 'Num Products',
	avg(p.UnitPrice) as 'Avg price'
from Suppliers as s left outer join Products as p
on s.SupplierID = p.SupplierID
where s.CompanyName like '[h,u,r,t]%'
group by s.CompanyName, s.Country
order by count(p.ProductID)
go 

--q4
declare @usa as varchar(3) = 'USA'
select 
	s.CompanyName as 'Supplier',
	s.Country as 'Country',
	Coalesce(MIN(p.UnitPrice),0) as 'Min Price',
	coalesce(MAX(p.UnitPrice), 0) as 'Max Price'
from Suppliers as s left join Products as p
on s.SupplierID = p.SupplierID
where s.Country like @usa
group by s.CompanyName, s.Country
order by Coalesce(MIN(p.UnitPrice),0)
go

--q5
declare @walla as varchar(12) = 'Walla Walla'
declare @Poland as varchar(6) = 'Poland'
select
	c.CompanyName as 'Customer',
	c.City as 'City',
	convert(varchar,o.OrderDate,106) as 'Order Date',
	count(o.OrderDate) as 'Products in Order'
from Customers as c left join Orders as o
	on c.CustomerID = o.CustomerID 
	left join [Order Details] as d
	on o.OrderID = d.OrderID
where c.City like @walla or c.Country like @Poland
group by c.CompanyName, c.City, o.OrderDate
order by count(o.OrderDate)
go

--q6
select
	concat(e.LastName,', ',e.FirstName) as 'Name',
	sum(d.UnitPrice*d.Quantity) as 'Sales Total',
	count(d.OrderID) as 'Detail Items'
from Employees as e left join Orders as o
	on e.EmployeeID = o.EmployeeID
	left join [Order Details] as d
	on d.OrderID = o.OrderID
group by e.LastName, e.FirstName
order by sum(d.UnitPrice*d.Quantity) desc
go

