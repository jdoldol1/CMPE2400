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