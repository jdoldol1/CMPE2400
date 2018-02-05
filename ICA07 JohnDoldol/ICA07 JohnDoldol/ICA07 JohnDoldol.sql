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







