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
