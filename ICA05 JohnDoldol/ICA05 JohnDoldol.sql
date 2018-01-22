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
