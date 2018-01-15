--ica03 demo
declare @var as int = 0
set @var = rand() --0 to 1 exclusively (no 1)
select
	@var
go