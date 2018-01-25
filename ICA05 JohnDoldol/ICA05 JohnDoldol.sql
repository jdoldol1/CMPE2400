--ICA05 JohnDoldol
--CMPE2400
--JANUARY 22 2018

--q1	
use Chinook 
select 
	* from Genre
go 

--q2
select 
	CustomerId as 'Customer ID',
	cast(LastName as varchar(18)) as 'Last Name',
	cast(FirstName as varchar(18)) as 'First Name',
	Company as 'Company Name'
from Customer
go

--q3
select 
	left(CustomerId, 10) as 'Customer ID',
	cast(FirstName as varchar(18) ) as 'First Name',
	cast(Country as varchar(18)) as 'Country',
	cast(State as varchar(18)) as 'Region'
from Customer
where Fax is null and State is not null
go

--q4
declare @7minutes as int = 420000
declare @8minutes as int = 480000
select
	TrackId as 'Track ID',
	left(Name, 26) as 'Name',
	left(Composer, 64) as 'Written by'
from Track	
where GenreId = 2 and Milliseconds between @7minutes and @8minutes
go

--q5
select
	left(Company,48) as 'Company Name',
	LastName as 'Contact',
	left(Address,36) as 'Street Address'
from Customer
where Country in('Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana',
'Paraguay','Peru','Suriname','Uruguay','Venezuela') and Company is not NULL
go