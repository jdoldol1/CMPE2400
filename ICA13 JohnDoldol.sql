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
if exists ( select * from sysobjects where name = 'ica13_05' )
	drop procedure ica13_05
go

create procedure ica13_05
@minPrice as money = null,
@country as nvarchar(max) = 'USA'
as
	select 
		s.CompanyName as 'Supplier',
		s.Country as 'Country',
		Coalesce(MIN(p.UnitPrice),0) as 'Min Price',
		Coalesce(MAX(p.UnitPrice), 0) as 'Max Price'
	from NorthwindTraders.dbo.Suppliers as s 
	left join NorthwindTraders.dbo.Products as p
		on s.SupplierID = p.SupplierID
	where s.Country like @country
	group by s.CompanyName, s.Country
	having Coalesce(MIN(p.UnitPrice),0) > @minPrice
	order by [Min Price]
go

exec ica13_05 15
go
exec ica13_05 @minPrice = 15
go
exec ica13_05 @minPrice = 5, @country = 'UK'
go

--q6
if exists ( select * from sysobjects where name = 'ica13_06' )
	drop procedure ica13_06
go

create procedure ica13_06
@class_id as int = 0
as
	select 
		t.ass_type_desc as 'Type',
		round(avg(e.score),2) as 'Raw Avg',
		round(avg((e.score / r.max_score)* 100),2)  as 'Avg',
		count(e.score) as 'Num'
	from ClassTrak.dbo.Assignment_type as t left join  ClassTrak.dbo.Requirements as r
		on t.ass_type_id = r.ass_type_id
		left join ClassTrak.dbo.Results as e 
		on e.req_id = r.req_id
	where e.class_id = @class_id
	group by t.ass_type_desc
	order by t.ass_type_desc
go

exec ica13_06 88
go
exec ica13_06 @class_id = 89
go

--q7
if exists ( select * from sysobjects where name = 'ica13_07' )
	drop procedure ica13_07
go

create procedure ica13_07
@year as int,
@minAvg as int = 50,
@minSize as int = 10
as
	select 
		concat(st.last_name,', ',st.first_name) as 'Student',
		c.class_desc as 'Class',
		t.ass_type_desc as 'Type',
		count(st.last_name) as 'Submitted',
		round(avg(res.score/req.max_score) * 100,1) as 'Avg'
	from ClassTrak.dbo.Students as st 
		left join ClassTrak.dbo.Results as res
			on st.student_id = res.student_id
		left join ClassTrak.dbo.Requirements as req
			on res.req_id = req.req_id
		left join ClassTrak.dbo.Assignment_type as t
			on req.ass_type_id = t.ass_type_id
		left join ClassTrak.dbo.Classes as c 
			on req.class_id = c.class_id
	where DATEPART(year, c.start_date) = @year and res.score is not null
	group by st.last_name, st.first_name, c.class_desc, t.ass_type_desc
	having count(st.last_name) > @minSize and avg(res.score/req.max_score) * 100 < @minAvg
	order by [Submitted], [Avg]
go

exec ica13_07 @year=2011
go

exec ica13_07 @year=2011, @minAvg=40, @minSize=15
go