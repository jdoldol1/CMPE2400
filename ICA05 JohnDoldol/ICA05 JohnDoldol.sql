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
	CustomerId as 'Customer ID',
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

--q6
select
	TrackId as 'Track ID',
	left(Name,50) as 'Title',
	Composer as 'Composer'
from Track
where (name like 'black%' or composer like '%verd%') and GenreId not in(1,3,5,7,9)
go

--q7
select
	TrackId as 'Track ID',
	left(Convert(time,dateadd(ms,Milliseconds,0)),12) as 'Time',	
	cast(UnitPrice / (cast(Milliseconds as decimal)/60000)as money) as 'Cost/Minute',
	cast(Bytes / (cast(Milliseconds as decimal)/1000) as decimal(10,3)) as 'Bytes/Second'
from Track 
where Milliseconds > 60000
and cast(UnitPrice / (cast(Milliseconds as decimal)/60000)as money) > 2.75
go
