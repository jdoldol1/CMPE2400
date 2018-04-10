-- ica16
-- You will need to install a personal version of the ClassTrak database
-- The Full and Refresh scripts are on the Moodle site.
-- Once installed, you can run the refresh script to restore data that may be modified or 
--  deleted in the process of completing this ica.

use  [jdoldol_ClassTrak]-- YOUR_COPY_CLASSTRAK
go

-- q1
-- Complete an update to change all classes to have their descriptions be lower case
-- select all classes to verify your update

update Classes
set class_desc = LOWER(class_desc)
select * from Classes
go


-- q2
-- Complete an update to change all classes have 'Web' in their 
-- respective course description to be upper case
-- select all classes to verify your selective update
update Classes
set class_desc = UPPER(class_desc)
from Classes as C 
	inner join Courses as CRS
	on C.course_id = CRS.course_id
where CRS.course_desc like '&web&'

select * from Courses
go

-- q3
-- For class_id = 123
-- Update the score of all results which have a real percentage of less than 50
-- The score should be increased by 10% of the max score value, maybe more pass ?
-- Use ica13_06 select statement to verify pre and post update values,
--  put one select before and after your update call.

if exists ( select * from sysobjects where name = 'ica13_06' )
	drop procedure ica13_06
go

create procedure ica13_06
@class_id as int = 0
as
	select 
		AMT.ass_type_desc as 'Type',
		left(cast(avg(RS.score) as decimal(10, 2)), 22) as 'Raw Avg',
		left(cast(avg(RS.score * 100.0 / RQM.max_score) as decimal(10, 2)), 22) as 'Avg',
		count(RS.score) as 'Num'
	from Assignment_type as AMT 
		left join Requirements as RQM
			on AMT.ass_type_id = RQM.ass_type_id
		left join Results as RS
			on RQM.req_id = RS.req_id
	where RS.class_id = @class_id
	group by AMT.ass_type_desc
	order by type
go

exec ica13_06 123
go

update Results 
set score = score + (0.1 * REQ.max_score)
from Results as RES
	inner join Requirements as REQ
	on RES.req_id = REQ.req_id
where (RES.score * 100 / REQ.max_score) < 50

exec ica13_06 @class_id = 123
go

go

