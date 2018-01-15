--ica03 demo
declare @var as int = 0
declare @fvar as float = 0
set @var = rand() --0 to 1 exclusively (no 1)
set @fvar = rand() * 11 + 10
select
	@var,
	@fvar
go
