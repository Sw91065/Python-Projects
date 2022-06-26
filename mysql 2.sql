-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
use ipl;
select * from ipl_bidding_details;
select * from ipl_bidder_points;
select * from ipl_bidding_details;
select * from ipl_match;
select * from  ipl_match;

-- 1st solution
select tt.bidder_id,dd/bb*100 from 
(select bidder_id,count(bid_team) as bb,bid_team,BID_STATUS from ipl_bidding_details group by BIdder_id) as tt join 
(select bidder_id,count(bid_team) as dd,bid_team,BID_STATUS from ipl_bidding_details where BID_STATUS ='Won' group by BIDder_id) as pp 
group by BIDDER_ID;

-- 2nd solution
select bidder_id,sum(if(bid_status='won',1,0))/count(bidder_id)*100 as pp from ipl_bidding_details group by BIDDER_ID order by pp desc ;
-- 3rd In a given stadium, what is the percentage of wins by a team which has won the toss?
select match_id,tt.stadium_name,tt.stadium_id,sum(if(match_winner=toss_winner,1,0))/count(match_id)*100 from ipl_match as ii join ipl_match_schedule as pp using(match_id)
join ipl_stadium as tt on pp.stadium_id=tt.stadium_id group by tt.stadium_id;
                                                   ------------- SQL2 ----------------
-- write a query to list the employees who works for sales department
select a.employee_id,first_name,a.department_id,department_name
 from employees as a join departments as d using(department_id) where department_name like '%sale%';
 
 
select  employee_id,first_name from employees where department_id=
(select department_id from departments where department_name='sales');

select avg(salary) from employees where department_id=
(select department_id from departments where department_name='sales');


select count(employee_id) from employees where salary >
(select employee_id from employees where first_name='susan');


select (employee_id),first_name from employees where department_id!=
(select department_id from  employees where first_name='den');


select employee_id from employees where salary <
(select salary from employees where first_name='gerald');


select employee_id from employees where department_id in
(select department_id from departments where department_name in ('sales','finance'));

select employee_id,first_name from employees where salary > all
(select max(salary) from employees where hire_date like '%2000%'); 


select employee_id,first_name from employees  where salary > all
(select avg(salary) from employees);

select * from employees;

select employee_id from employees where job_id like '%sa_rep%' and salary > any
(select salary  from employees where  job_id like '%sa _man%');

select employee_id from employees where salary < any
(select salary from employees where job_id like'%sh_clerk%');



select * from employees where department_id in
(select department_id  from departments where location_id =
(select location_id from locations where city='seattle') );


select location_id,state_province,city from locations where country_id in
(select country_id from countries where region_id=
(select region_id from regions where region_name='asia'));



select * from employees where department_id in 
(select department_id from departments where location_id=
(select location_id from locations where city ='london'));





select * from employees where salary = 
(select salary from employees where department_id in
(select department_id from departments where first_name='gerald'));



select * from employees where (salary,department_id)=
(select salary,department_id from employees where first_name='gerald');




select * from employees where (department_id,salary) =
(select department_id ,salary from employees where department_id in(10,20) and salary between 10000 and 20000);

------ Having ----------


select min(q.salary) from
(select salary from employees order by salary desc limit 5) as q;



select count(q.employee_id)from
(select employee_id from employees where first_name like 'a%') as q;



select department_id ,avg(salary)from employees group by department_id having
avg(salary) > 
(select salary from employees where first_name='lex');


create table new_emp(
employee_id int,
first_name varchar(20),
last_name varchar(20),
salary float
);
insert into new_emp
(select employee_id,first_name,last_name,salary from employees
having salary > 10000);
select * from new_emp;




select * from employees o where salary>(select avg(salary) from employees i where i.department_id=o.department_id group by department_id);





select * from employees o where exists (select * from employees i where o.employee_id=i.manager_id);

select department_name from departments o where exists ( select department_id,salary from employees i where o.department_id=i.department_id and salary >4000);



select * from employees o where exists (select * from job_history j where j.employee_id=o.employee_id);



                                                       --------- Window Function ----------
                                                       
select * from employees;
select * ,sum(salary) over () from employees;
select * ,sum(salary) over (partition by department_id ) from employees;
select *,row_number() over(partition by department_id order by salary) from employees;
select *,rank() over(order by salary) from employees;

select *,dense_rank() over(partition by department_id order by salary) from employees;
select *,row_number() over (order by salary) as rowid, rank() over(partition by department_id order by salary) as rp,dense_rank() over(partition by department_id order by salary)   
from employees;


select *,row_number() over (order by salary desc) as rowid, rank() over(partition by department_id order by salary) as rp,dense_rank() 
over(partition by department_id order by salary)  as ppy from employees where department_id in(60,90);


select *,ntile(10) over (order by department_id desc) as df from employees;


select *,lag(salary) over(partition by department_id ) from employees;
select *,lag(salary,3,'20 lakh') over(partition by department_id ) from employees;


select *,lag(salary,3) over(partition by department_id ) as dff from employees ;
select salary,salary-lag(salary) over (partition by department_id) as ff from employees;

select salary,lead(salary) over (partition by department_id order by salary ) as ff from employees;

select *,first_value(salary ) over(partition by department_id order by salary) from employees;

select *,first_value(start_date) over(partition by employee_id order by start_date) from job_history;

select distinct employee_id,last_value(start_date) over(partition by employee_id order by start_date range between unbounded preceding and unbounded following) from job_history;

select *,job_title,first_value(job_title) over (partition by job_id ) from jobs;

select *,last_value(first_name) over(partition by department_id order by salary  range between unbounded preceding and unbounded following) from employees;
select *,first_value(first_name) over(partition by department_id order by salary desc range between unbounded preceding and unbounded following) from employees;



select *,nth_value(first_name,2) over(partition by department_id order by salary desc range between unbounded preceding and unbounded following) from employees;


select *,  percent_rank() over(order by salary) as percentrank, cume_dist() over(order by salary) as cumpass from employees where department_id=50;