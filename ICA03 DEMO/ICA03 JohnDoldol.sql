--ica03 demo
--declare @var as int = 0
--declare @fvar as float = 0
--set @var = rand() --0 to 1 exclusively (no 1)
--set @fvar = rand() * 11 + 10
--select
--	@var,
--	@fvar
--go

declare @var int = 10
set @var = case @var * 10
	when 20 then 2
	when 50 then 5
	when 100 then 11
	else 99
end
print @var
go

declare @name as varchar(24) = 'EUGENE YAN'
declare @result as varchar(24) = 'no money'
set @result =
	case
		when len(@name) < 2 then 'short'
		when len(@name) < 4 then 'medium'
		when len(@name) < 8 then 'long'
		else 'chink'
end
select @result
go

declare @total as int = 0
declare @loopNum as int = rand() * 100
declare @loop as int = 0
while @loop < @loopNum
begin
	set @total += rand() * 11 - 5
	set @loopNum += 1
end
select 
	@total as 'Sum',
	@loopNum as 'Loops'
go