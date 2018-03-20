--q1
if exists ( select * from sysobjects where name = 'ica13_01' )
	drop procedure ica13_01
go
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

exec ica13_01
go

--q2
if exists ( select * from sysobjects where name = 'ica13_02' )
	drop procedure ica13_02
go

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
		order by [Sales Total] desc 
go

exec ica13_02
go


--q3
if exists ( select * from sysobjects where name = 'ica13_03' )
	drop procedure ica13_03
go
create procedure ica13_03
@maxPrice as money = null
as
	--declare @cost as int = 15
	select
		c.CompanyName as 'Company Name',
		c.Country as 'Country'
	from NorthwindTraders.dbo.Customers as c
	where c.CustomerID in
		(
			select distinct CustomerID
			from NorthwindTraders.dbo.Orders as o
			where o.OrderID in 
				(
					select OrderID
					from NorthwindTraders.dbo.[Order Details] as d
					where (d.Quantity * d.UnitPrice) < @maxPrice
				)	
		)
	order by Country
go

exec ica13_03 15
go

--q4
if exists ( select * from sysobjects where name = 'ica13_04' )
	drop procedure ica13_04
go

create procedure ica13_04
@minPrice as money = null,
@categoryName as nvarchar(max) = ''
as
	select 
		outy.ProductName
	from NorthwindTraders.dbo.Products as outy
	where exists
		(
			select CategoryID
			from NorthwindTraders.dbo.Categories as inny
			where (outy.CategoryID = inny.CategoryID) and 
			(inny.CategoryName like @categoryName)
		)
	and UnitPrice > @minPrice
	order by outy.CategoryID, outy.ProductName
go

exec ica13_04 20, 'confections'
go

--q5
