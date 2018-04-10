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
		inner join NorthwindTraders.dbo.Products as p 
			on c.CategoryID = p.CategoryID
		inner join NorthwindTraders.dbo.[Order Details] od
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

--q2
if exists ( select * from sysobjects where name = 'ica14_02' )
	drop procedure ica14_02
go
create procedure ica14_02
@year as int,
@coname as varchar(64) output,
@average as money output
as
	select top 1
		@coname = CONCAT(e.LastName, ', ', e.FirstName),
		@average = AVG(o.Freight)
	from NorthwindTraders.dbo.Employees as e
	inner join NorthwindTraders.dbo.Orders as o
	on e.EmployeeID = o.EmployeeID	
	where DATEPART(year, o.OrderDate) = @year
	group by e.LastName, e.FirstName
	order by AVG(o.Freight) desc
go


declare @YEAR as int = 1996
declare @fullname as varchar(64)
declare @freight as money

exec ica14_02 @YEAR,
	@fullname output, @freight output
select 
	@YEAR as 'Year',
	@fullname as 'Name',
	@freight as 'Biggest Avg Freight'

set @YEAR = 1997
exec ica14_02 @year = @YEAR, @coname = @fullname output, @average = @freight output

select 
	@YEAR as 'Year',
	@fullname as 'Name',
	@freight as 'Biggest Avg Freight'


--q3
if exists  ( select * from sysobjects where name = 'ica14_03')
	drop procedure ica14_03
go

create procedure ica14_03
@class_id as int,
@ass_type_desc as varchar(max) = 'all'
as
	select
		s.last_name as 'Last',
		a.ass_type_desc,
		round(min(r.score * 100 / e.max_score),1) as 'Low',
		round(max(r.score * 100 / e.max_score),1) as 'High',
		round(avg(r.score * 100 / e.max_score),1) as 'Avg'
	into #StudentStats
	from ClassTrak.dbo.Students as s
		inner join ClassTrak.dbo.Results as r
			on s.student_id = r.student_id
		inner join ClassTrak.dbo.Requirements as e
			on r.req_id = e.req_id
		inner join ClassTrak.dbo.Assignment_type as a
			on e.ass_type_id = a.ass_type_id
	where r.class_id = @class_id
	group by s.last_name, a.ass_type_desc

	if @ass_type_desc = 'ica'
		set @ass_type_desc = 'Assignment'
	else if @ass_type_desc = 'lab'
		set @ass_type_desc = 'Lab'
	else if @ass_type_desc = 'le'
		set @ass_type_desc = 'Lab Exam'
	else if @ass_type_desc = 'fe'
		set @ass_type_desc = 'Final'

	select * 
	from #StudentStats as ss
	where ss.ass_type_desc = @ass_type_desc
	order by [Avg] desc
go

declare @cid as int
set @cid = 123
exec ica14_03 @cid, 'ica'

set @cid = 123
exec ica14_03 @cid, 'le'
go

--q4

if exists  ( select * from sysobjects where name = 'ica14_04')
	drop procedure ica14_04
go

create procedure ica14_04
@student as nvarchar(24),
@summary as bit = 0
as
	declare @chosenName as nvarchar(24)
	declare @matching as int

	select
		@chosenName = s.first_name + ' ' + s.last_name 
	from ClassTrak.dbo.Students as s
	where s.first_name + ' ' + s.last_name like @student + '%'
	set @matching = @@ROWCOUNT
	
	if @matching <> 1
		return -1

	select
		@chosenName as 'Name',
		c.class_desc,
		e.ass_type_id,
		e.ass_desc,
		r.score,
		e.max_score
	into #StudentTable
	from ClassTrak.dbo.Students as s
		inner join ClassTrak.dbo.class_to_student as cts
			on s.student_id = cts.student_id
		inner join ClassTrak.dbo.Classes as c
			on cts.class_id = c.class_id
		inner join ClassTrak.dbo.Results as r
			on c.class_id = r.class_id and s.student_id = r.student_id
		inner join ClassTrak.dbo.Requirements as e
			on r.req_id = e.req_id
	where s.first_name + ' ' + s.last_name = @chosenName

	if @summary = 1
		begin
			select
				@chosenName as 'Name',
				st.class_desc,
				round(avg(st.score * 100 / st.max_score),1) as 'Avg'
			from #StudentTable as st
			group by st.class_desc
			order by st.class_desc
		end
	else
		begin
			select
				@chosenName as 'Name',
				st.class_desc,
				st.ass_type_id,
				round(avg(st.score/ st.max_score)*100, 1) as 'Avg'
			from #StudentTable as st
			group by st.class_desc, st.ass_type_id
			order by st.class_desc, st.ass_type_id
		end
	return 1
go

declare @retVal as int
exec @retVal = ica14_04 @student = 'Ro'
select @retVal

exec @retVal = ica14_04 @student = 'Ron'

select @retVal
exec @retVal = ica14_04 @student = 'Ron', @summary = 1
select @retVal
go

-- q5
-- q5
if exists ( select * from sysobjects where name = 'ica14_05' )
	drop procedure ica14_05
go

create procedure ica14_05
@lastname as nvarchar(24) = null,
@fullname as nvarchar(24) output,
@numberClasses as int output,
@totalStudents as int output,
@totalGraded as int output,
@average as float output
as
	
	declare @result as int
	declare @id as int
	select 
		@id = I.instructor_id,
		@fullname = I.first_name + ' ' + I.last_name
	from ClassTrak.dbo.Instructors as I
	where I.last_name  like '%' + @lastname + '%'
	set @result = @@ROWCOUNT

	--make sure you have a match or else return
	if @result <> 1
	begin
		set @fullname = null
		return -1
	end

	select
		@numberClasses = count(distinct cts.class_id),
		@totalStudents = count(cts.student_id)
	from ClassTrak.dbo.Instructors as I
		inner join ClassTrak.dbo.Classes as C
			on I.instructor_id = C.instructor_id
		inner join ClassTrak.dbo.class_to_student as cts
			on C.class_id = cts.class_id
	where I.instructor_id = @id	

	select
		@totalGraded = count(r.score * 100 / e.max_score),
		@average = avg(r.score * 100 / e.max_score)
	from ClassTrak.dbo.Instructors as I
		inner join ClassTrak.dbo.Classes as C
			on I.instructor_id = C.instructor_id
		inner join ClassTrak.dbo.Results as R
			on C.class_id = R.class_id
		inner join ClassTrak.dbo.Requirements as E
			on r.req_id = e.req_id
	where I.instructor_id = @id
	return 1
go

declare @name as nvarchar(24)
declare @class as int
declare @students as int
declare @graded as int
declare @avg as float
declare @returned as int
exec @returned = ica14_05 'Cas', @name output, @class output, @students output, @graded output, @avg output


select
	@name as 'Instructor',
	@returned as 'Returned',
	@class as 'Num Classes',
	@students as 'Total Students',
	@graded as 'Total Graded',
	@avg as 'Avg Awarded'