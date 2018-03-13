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


