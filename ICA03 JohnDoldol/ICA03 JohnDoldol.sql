--ICA03 JohnDoldol
--CMPE2400 
--JANUARY 20/2018
declare @num as int
declare @divisible as varchar(3)

set @num = RAND()*101
set @divisible = case
	when @num % 3 = 0 then 'Yes'
	else 'No'
end

select
	@num as 'Random Number',
	@divisible as 'Factor of 3'
go

--q2
declare @min as int
declare @ballpark as varchar(12)

set @min = rand()*60 + 1
set @ballpark = case
	when @min < 15 then 'on the hour'
	when @min < 30 then 'quarter past'
	when @min < 45 then 'half past'
	else 'quarter to'
end

select
	@min as 'Minutes',
	@ballpark as 'Ballpark'
go

--q3
declare @day as int
declare @status as varchar(9)

set @day = rand()*7

set @status = case
	when datepart(weekday,getdate()) + @day between 2 and 6 then 'Got Class'
	when datepart(weekday,getdate()) + @day between 9 and 13 then 'Got Class'
	else 'Yahoo'
end

select
	@day as 'Day Number',
	@status as 'Status'
go

--q4
declare @rnd as int
declare @two as int = 0
declare @three as int = 0
declare @five as int = 0
declare @count as int = 0
declare @limit as int = rand()*10001+1

while @count < @limit
begin
	set @rnd = rand()*11+1
	
	if @rnd % 2 = 0
		set @two += 1
		
	if @rnd % 3 = 0
		set @three += 1

	if @rnd % 5 = 0
		set @five += 1
	
	set @count += 1
end

--print out results	
select
	@count as 'Number of Iterations',
	@two as 'Factor of 2',
	@three as 'Factor of 3',
	@five as 'Factor of 5'
go

--q5
declare @x as int
declare @y as int
declare @in as int = 0
declare @guess as int = 0
declare @apie as decimal(14,9)

while @guess < 1000
begin
	set @x = rand()*101
	set @y = rand()*101

	if(SQRT(POWER(@x,2)+POWER(@y,2)) <= 100)
		set @in += 1
	
	set @guess += 1
	--calculate our PI estimate
	set @apie = 4 * cast(@in as decimal) / cast(@guess as decimal)

	--check if PI estimate is accurate enough, if so exit loop
	if(@apie between Pi()-0.0002 and Pi()+0.0002)
		break
end

select
	@apie as 'Estimate',
	Pi() as 'PI',
	@in as 'In',
	@guess as 'Tries'
go