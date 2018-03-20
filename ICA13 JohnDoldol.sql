--q1
create procedure ica13_01
as
	select 
		concat(e.LastName, ', ', e.FirstName) as 'Name',
		count(e.EmployeeID) as 'Num Orders'
		from NorthwindTraders.dbo.Employees as e 
			inner join NorthwindTraders.dbo.Orders as o
				on e.EmployeeID = o.EmployeeID
		group by e.LastName, e.FirstName
		order by 'Num Orders' desc
go

--q2
create procedure ica13_02
as
	select
			concat(e.LastName,', ',e.FirstName) as 'Name',
			sum(d.UnitPrice*d.Quantity) as 'Sales Total',
			count(d.OrderID) as 'Detail Items'
		from NorthwindTraders.dbo.Employees as e 
			left join NorthwindTraders.dbo.Orders as o
				on e.EmployeeID = o.EmployeeID
			left join NorthwindTraders.dbo.[Order Details] as d
				on d.OrderID = o.OrderID
		group by e.LastName, e.FirstName
		order by sum(d.UnitPrice*d.Quantity) desc 
go

--q3
create procedure ica13_03
as
	declare @cost as int = 15
	select
		CompanyName as 'Company Name',
		Country as 'Country'
	from NorthwindTraders.dbo.Customers
	where CustomerID in
		(
			select distinct CustomerID
			from NorthwindTraders.dbo.Orders
			where OrderID in 
				(
					select OrderID
					from NorthwindTraders.dbo.[Order Details]
					where (Quantity * UnitPrice) < @cost
				)	
		)
	order by Country
go

--q4