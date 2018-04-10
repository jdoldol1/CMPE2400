-- ica15
-- This ICA is comprised of 2 parts, but should be tackled as described by your instructor.
-- To ensure end-to-end running, you will have to complete the ica in pairs where possible :
--  q1A + q2A, then q1B + q2B
-- You will need to install a personal version of the ClassTrak database
-- The Full and Refresh scripts are on the Moodle site.
-- Once installed, you can run the refresh script to restore data that may be modified or 
--  deleted in the process of completing this ica.

use [jdoldol_ClassTrak] -- YOUR_COPY_CLASSTRAK
go

-- q1
-- All in one batch, to retain your variable contexts/values

-- A
-- Insert a new Instructor : Donald Trump
--  Check column types, supply necessary values, it may require a column list
--  Save your identity into a variable

declare @instructor_id as int
insert into Instructors(first_name,last_name)
values ('Donald','Trump')
set @instructor_id = @@IDENTITY

-- B 
-- Insert a new Course : cmpe2442 "Fast and Furious - SQL Edition"
--  Check column types, supply necessary values, it may require a column list
--  Save your identity into a variable

declare @course_id as int
insert into Courses(course_abbrev,course_desc)
values ('CMPE2442','Fast and Furious - SQL Edition')
set @course_id = @@IDENTITY

-- C
-- Insert a record indicating your new instructor is teaching the new course
--  description : "Beware the optimizer"
--  start_date : use 01 Sep 2016
--  Save the identity into a variable

declare @class_id as int
insert into Classes(class_desc ,instructor_id,course_id , start_date)
values('Beware the optimizer',@instructor_id,@course_id,'2016-09-01')
set @class_id = @@IDENTITY

-- D Insert a bunch in one insert
-- Generate the insert statement to Add all the students with a last name that
--  starts with a vowel to the new class

insert into class_to_student(class_id,student_id)
	select @class_id, student_id
	from Students
	where last_name like '[aeiou]%'

-- E
--  Prove it all, generate a select to show :
--   All instructors - see your new entry
--   All courses that have SQL in description
--   All classes that have a start_date after 1 Aug 2016
--   All students in the new class - filter by description having "Beware"
--       sort by first name in last name

use [jdoldol_ClassTrak]
select * from Instructors
select * from Courses
select * from Classes where datediff(day, '01-Aug-2016', Classes.start_date) > 0
select 
	S.student_id as 'ID',
	S.first_name + ' ' + S.last_name as 'Student Name'
from Students as S
	inner join class_to_student as CLS_T_STU
		on S.student_id = CLS_T_STU.student_id
	inner join Classes as CLS
		on CLS_T_STU.class_id = CLS.class_id
where	CLS.class_desc like '%Beware%'
order by S.last_name, S.first_name

go
-- end q1


use jdoldol_ClassTrak
go

-- q2 - Undo all your changes to reset the database, you must do this in reverse order to
--      ensure you do not attempt to corrupt Referencial Integrity.
--     As such, work backwards from D to A, deleting what we added, but you must query the DB
--      to find and save the relevant keys.


-- q2 - Undo all your changes to reset the database, you must do this in reverse order to
--      ensure you do not attempt to corrupt Referencial Integrity.
--     As such, work backwards from D to A.

-- D - Delete all students that have been assigned to your new class, do this without a 
--     variable, rather perform a join with proper filtering for this delete

delete class_to_student
from class_to_student as CTS
	inner join Classes as CLS
		on CTS.class_id = CLS.class_id
where CLS.class_desc like '%Beware%'
	and start_date = '2016-09-01'

-- C - declare, query and set class id to your new class based on above filter.
--     declare, query and save the linked course and instructor ( use in B and A )
--     Delete the new class
declare @class_id as int
declare @course_id as int
declare @ins_id as int

select 
	@class_id = CLS.class_id
from Classes as CLS
where CLS.class_desc like '%Beware%'
	and start_date = '2016-09-01'

select 
	@course_id = CLS.course_id,
	@ins_id = INS.instructor_id
from Courses as CRS
	inner join Classes as CLS
		on CRS.course_id = CLS.course_id
	inner join Instructors as INS
		on CLS.instructor_id = INS.instructor_id
where	CLS.start_date = '2016-09-01' and
		CLS.class_desc = 'Beware the optimizer' and
		CRS.course_abbrev = 'CMPE2442' and 
		CRS.course_desc = 'Fast and Furious - SQL Edition'

delete Classes
where class_id = @class_id
-- B - Delete the new course as saved in C

delete Courses
where Courses.course_id = @course_id

-- A - Delete the new instructor as saved in C

delete Instructors
where instructor_id = @ins_id

-- E - Repeat q1 part E to verify the removal of all the data.
use [jdoldol_ClassTrak]
select * from Instructors
select * from Courses where course_desc like '%Fast%'
select * from Classes where datediff(day, '01-Aug-2016', Classes.start_date) > 0
select 
	S.student_id as 'ID',
	S.first_name + ' ' + S.last_name as 'Student Name'
from Students as S
	inner join class_to_student as CLS_T_STU
		on S.student_id = CLS_T_STU.student_id
	inner join Classes as CLS
		on CLS_T_STU.class_id = CLS.class_id
where	CLS.class_desc like '%Beware%'
order by S.last_name, S.first_name

go