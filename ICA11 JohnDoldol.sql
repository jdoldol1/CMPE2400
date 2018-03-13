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