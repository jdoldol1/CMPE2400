--ICA06 John Doldol
--January 28, 2018

use Chinook
--q1
select
	left(Name,24) as 'Name',
	UnitPrice as 'Unit Price'
from Track
where GenreId in(13,25) and (UnitPrice between 1.69 and 1.89)
order by Name asc
go

--q2
select
	InvoiceId as 'Invoice Id',
	TrackId as 'Track Id',
	UnitPrice * Quantity as 'Value'
from InvoiceLine
where UnitPrice * Quantity between 16 and 18
order by UnitPrice * Quantity desc
go

--q3
select
	left(Name,48) as 'Name',
	left(Composer,12) as 'Composer',
	UnitPrice as 'Unit Price'
from Track
where Name like '% black %'or Name like '%white%'
order by Name asc
go

--q4
select
	CONCAT(left(InvoiceId,6),':', left(TrackId,6)) as 'Inv:Track',
	UnitPrice as 'Unit Price',
	Quantity as 'Quantity',
	UnitPrice * Quantity as 'Cost'
from InvoiceLine
where (UnitPrice * Quantity between 12 and 14) and
InvoiceId between 200 and 299
order by TrackId asc
go

--q5
select
	left(FirstName, 24) as 'First Name',
	PostalCode as 'PC',
	Phone as 'Phone',
	Email as 'Email'
from Customer
where (PostalCode like '[a-z][0-9][a-z]%[0-9][a-z][0-9]') 
or (Phone like '%[0-2][0-2][0-2][0-2]%')
order by [First Name] asc
go

--q6
select
	LastName as 'LastName',
	DATEDIFF(YEAR,BirthDate,getdate()) + DATEDIFF(YEAR,HireDate,GETDATE()) as 'Magic Number',	
	case
		when DATEDIFF(YEAR,BirthDate,getdate()) + DATEDIFF(YEAR,HireDate,GETDATE()) > 84
		then 'Yup'
		else cast(85 - (DATEDIFF(YEAR,BirthDate,getdate()) + DATEDIFF(YEAR,HireDate,GETDATE())) as varchar(3))
	end as 'Yet ?'
from Employee
order by DATEDIFF(YEAR,BirthDate,getdate()) + DATEDIFF(YEAR,HireDate,GETDATE())
go

--q7
select
	LastName as 'Last Name',
	City as 'City',
	Country as 'Country'
from Customer
where Country like '%[^aemy]'
and Company is not null
order by Country, City asc

--q8
select Distinct
	Country as 'Country'
from Customer
where Country like '[a-f]%'
order by Country desc

--q9