--q1
if exists ( select * from sysobjects where name = 'ica14_01' )
	drop procedure ica14_01
go

create procedure ica14_01
@category as nvarchar(max) = null,
@productName as nvarchar(max) output,
@highestQuantity as int output
as
	select top 1
		@productName = p.ProductName,
		@highestQuantity = od.Quantity
	from NorthwindTraders.dbo.Categories as c
		left join NorthwindTraders.dbo.Products as p 
			on c.CategoryID = p.CategoryID
		left join NorthwindTraders.dbo.[Order Details] od
			on p.ProductID = od.ProductID
	where c.CategoryName = @category
	order by od.Quantity desc
go

declare @categoryFind as nvarchar(24) 
declare @product as nvarchar(24)
declare @quantity as int

set @categoryFind = 'Beverages'
exec ica14_01 @categoryFind, 
	@product output, @quantity output

select
	@categoryFind as 'Category',
	@product as 'ProductName',
	@quantity as 'Highest Qty'
	
set @categoryFind = 'Confections'
exec ica14_01 @category = @categoryFind,
	@productName = @product output, @highestQuantity = @quantity output

select
	@categoryFind as 'Category',
	@product as 'ProductName',
	@quantity as 'Highest Qty'
go