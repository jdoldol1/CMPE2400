--q1
declare @id as int = 88
select 
	t.ass_type_desc as 'Type',
	avg(e.score) as 'Raw Avg',
	avg((e.score / r.max_score)* 100)  as 'Avg',
	count(e.score) as 'Num'
from Assignment_type as t left join  Requirements as r
	on t.ass_type_id = r.ass_type_id
	left join Results as e 
	on e.req_id = r.req_id
where e.class_id = @id
group by t.ass_type_desc
order by t.ass_type_desc
go

--q2
declare @id as int = 88
select 
	CONCAT(r.ass_desc, '(', t.ass_type_desc ,')') as 'Desc(Type)',
	round(avg(e.score/r.max_score)*100,2) as 'Avg',
	count(e.score) as 'Num Score'
from Assignment_type as t left join Requirements as r
 on t.ass_type_id = r.ass_type_id
 left join Results as e
 on e.req_id = r.req_id
where e.class_id = @id
group by r.ass_desc, t.ass_type_desc, r.max_score
having avg(e.score/r.max_score)*100 > 57
order by t.ass_type_desc
go

--q3
declare @id as int = 123
select
	s.last_name as 'Last',
	a.ass_type_desc,
	round(min((r.score/q.max_score) * 100),1) as 'Low',
	round(max((r.score/q.max_score) * 100),1) as 'High',
	round(sum(r.score / q.max_score)/count(r.score) * 100,1) as 'Avg'
from Students as s left join Results as r
	on s.student_id = r.student_id
	left join Requirements as q 
		on q.req_id = r.req_id
		left join Assignment_type as a
			on q.ass_type_id = a.ass_type_id
where r.class_id = @id
group by s.last_name, a.ass_type_desc
having round(sum(r.score / q.max_score)/count(r.score) * 100,1) > 70
order by a.ass_type_desc,'Avg'
go

--q4
select 
	i.last_name as 'Last',
	convert(varchar,c.start_date,106) as 'Start',
	count(s.student_id) as 'Num Registered',	
	sum(convert(int,s.active)) as 'Num active'
from Instructors as i left join Classes as c
	on i.instructor_id = c.instructor_id
	left join class_to_student as s
		on c.class_id = s.class_id
group by i.last_name, c.start_date
having (count(s.student_id) - sum(convert(int,s.active))) > 3
order by i.last_name, c.start_date
go

--q5
declare @startdate as int = 2011
select 
	concat(st.last_name,', ',st.first_name) as 'Student',
	c.class_desc as 'Class',
	t.ass_type_desc as 'Type',
	count(st.last_name) as 'Submitted',
	round(avg(res.score/req.max_score) * 100,1) as 'Avg'
from Students as st left join Results as res
	on st.student_id = res.student_id
	left join Requirements as req
		on res.req_id = req.req_id
		left join Assignment_type as t
			on req.ass_type_id = t.ass_type_id
			 left join Classes as c 
				on req.class_id = c.class_id
where DATEPART(year, start_date) = @startdate and res.score is not null
group by st.last_name, st.first_name, c.class_desc, t.ass_type_desc
having count(st.last_name) > 10 and avg(res.score/req.max_score) * 100 < 40
order by [Submitted],[Avg]
go
				