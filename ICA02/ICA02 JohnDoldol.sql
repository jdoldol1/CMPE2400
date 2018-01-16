--question 1
select 
		LEFT(@@SERVERNAME, 12) as 'Server',
		SUBSTRING(@@VERSION, 14, 22) as 'Version',
		@@ERROR as 'Errors',
		@@CONNECTIONS as 'Connections',
		@@PACK_RECEIVED as 'Rcvd',
		@@PACK_SENT as 'Sent',
		@@PACK_SENT/@@PACK_RECEIVED as 'Result'
go

--question 2
declare @oldtimes as datetime = '2000-10-01'
declare @endtimes as datetime = DateAdd(minute,-123456789,@oldtimes)
select
	LEFT(@oldtimes,12) as 'Start',
	@endtimes as 'Wayback'
go

--question 3
declare @christmas date = '2018-december-25'
select
	datediff(day,CURRENT_TIMESTAMP, '2018-12-25') as 'Days',
	@christmas as Xmas	
go

--question 4
declare @month varchar(2) = month(getdate())
declare @monthname varchar(24) = datename(month,cast(@month as int)) + '(' +@month + ')'
declare @season varchar(10)
declare @p varchar(1)


select
	@monthname as 'Name(#)',
	@month as 'Season',
	'nope' as 'Gotta p'
go

	





		


		



