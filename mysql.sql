create table student(
id int,
f_name varchar(20),
l_name varchar(20),
score float,
email varchar(15)
);
desc student;
alter table student add contact_no int;
alter table student drop contact_no;
alter table student add contact_no int after l_name;
alter table student modify score int;
alter table student change score scores float;
alter table student rename column scores to score;



create table employees(
emp_id int,
emp_name varchar(20),
dept varchar (20),
salary float
);
desc employees;
alter table employees drop dept;
alter table employees modify emp_name varchar(10);
alter table employees change emp_name name varchar(10);
alter table employees add desig varchar(15) after name;
alter table employees drop desig;
drop table student;
insert into employees values (101,'Swapnil','analytics',100000);
insert into employees values(102,'Mayur','bussiness',150000),(103,'vivek','sales',1030000),(104,'aman','manage',130000);
select * from employees;
update employees set desig='data scientist' where emp_id =101;
update employees set desig='data enginneer' where emp_id=102;
select * from employees where salary > 150000;
select * from employees where salary > 10000 and desig='sales';
select * from employees;
select *, salary+20000 from employees;
create table date_time1
(
dt date,
ti time,
dttime datetime
);
desc date_time1;
insert into date_time1 values('2022/05/09', '14:38', '2022/05/09 14:38:12');
select * from date_time1;
insert into date_time1 values (current_date,current_time,now());
use hr;
select salary,salary+2000 as bonus from employees;
-- immediate --
select 'swapnil' as name, 'patil' as surname from dual;
select 1+2+3 as 'addit',8/2 as 'divi' from dual;
select (1+78)/6 as 'comp' from dual;
select salary,salary+2000 as bonus from employees where salary+2000>10000;
-- distinct --
select * from employees;
select distinct department_id from employees;
select distinct department_id ,job_id from employees;
select job_id from employees where job_id='IT_PROG';
select department_id,hire_date,first_name from employees where first_name in ('Neena','Bruce');
select * from employees where manager_id is null;
select * from employees where job_id='IT_PROG' and salary>5000;
select department_id,hire_date,first_name from employees where first_name like 'Neena';
select * from employees where department_id  not in (90,80,70);
select first_name,last_name,salary from employees;
select *,salary*12 as annual from employees;
-- order by clause --
select employee_id,first_name,salary from employees order by salary desc;
select employee_id,first_name,salary,department_id from employees order by salary desc,department_id desc;
select first_name,last_name from employees where last_name like '%li%' order by first_name;
select first_name,department_id,hire_date from employees order by department_id,hire_date desc;
select * from employees limit 5;
select  employee_id,first_name,last_name,job_id,salary from employees order by salary desc limit 5;
select employee_id,first_name,last_name,job_id from employees limit 5,8;
select * from employees where job_id ='ST_MAN' order by salary desc limit 2,1;
select * from employees where salary >10000 limit 2,3;
-- Build Function -- single row and multi row functions
select round(45.789,2),round(67.929,0);
select truncate(45.789,2),truncate(67.929,0);
select floor(25.98);
select ceiling(25.03);
select concat('welcome',' ','to',' ','sql') as name;
select concat(first_name,' ',last_name) as name from employees;
select upper(concat(first_name,' ',last_name,' ',job_id)) as name from employees;
select length('hello world');
select instr('hellosffddg','f') as llkk;
select replace('jack and jue','j','bl') as swap from dual;
select trim('   swapnil');
select length(trim('   swapnil')) as name;   -- this all are character functions--
select concat(employee_id,' ',first_name,' ',length(instr(last_name,'a')),' ',instr(job_id,'REP'));
select concat(employee_id,' ',first_name,' ',last_name,' ',job_id) as details,length(last_name) as len ,instr(last_name,'a') from employees where job_id like '%rep%' and last_name like '%a%';
select instr('fdgghgjgjggdf','gjgj');
select period_diff(20221208,20221209) as period;
select adddate('2022/05/10',interval 1.5 month);
select adddate('2022/05/10',interval 10 day) as today;
select subdate('2022/05/10',interval 10 day) as yest;
select date_format(current_date(),'%d%m%Y');
select date_format(current_date(),'%a %b %D %M %Y %T') as gdwshvjks;
select str_to_date('10 August 2017','%d %m %y');
select str_to_date('August 10 2017','%M %d %Y');
select hire_date ,adddate(hire_date,interval 100 day) as tt,subdate(hire_date,interval 1 month) as pp from employees where department_id=90;
select * from employees where date_format(hire_date,'%Y')=1995;
select * from employees where year(hire_date)=1995;
-- Control Flow Functions--
select salary,employee_id ,if (salary>12000,'good','low') from employees;
select * from employees;
select commission_pct, ifnull(commission_pct,1) as fillna from employees;
select salary,employee_id ,if (salary is null,'good','low') from employees;
-- If null--
select salary,employee_id ,nullif(salary=employee_id,null) from employees;
select department_id, nullif (department_id,100) from employees;
select salary ,if (salary>15000,'Good','bad') as sal_grade from employees;
select employee_id,first_name,department_id, ifnull(commission_pct,0) as vlist0 from employees where department_id=80 or department_id=90;
select curdate();
select date_format(current_date(),'%m %d %y');
select date_format(current_date(),'%D %M %Y') as dert;
select str_to_date('05 11 2022 10 30 43','%m %d %Y %h %i %s');
select str_to_date('wednesday may 11 2022','%W %M %d %Y');
-- case expressiopn---
use hr;
select * from employees;
select last_name,first_name,job_id,salary ,
case
when salary<5000 then 'low'
when salary<10000 then 'medium'
when salary <15000 then 'good'
else 'better sal'
end as 'grade level' from employees;
create table author
(id int,name varchar(10) not null default'mr.x',
country varchar (10) not null check (country in ('usa','uk','uae')),
page int check(page>0),
primary key(id)
);
select * from author;
desc author;
alter table author add contact int unique;
insert into author 
(id,country, page,contact)
values(107,'uae',17,183456);
select '  *  ' from dual union select ' ** 'from dual union select'***' from dual;
select count(*)from employees;
select count(department_id) from employees;
select avg(ifnull(commission_pct,0)) from employees;
select * from employees;
select count(distinct (department_id))  from employees;
select min(salary) as min, max(salary) as max, avg(salary) as avg from employees;
-- COALESCE --
select commission_pct,coalesce(commission_pct,0) from employees;
-- Groupby--
select * from employees;
-- select first_name,last_name,avg(salary) from employees group by
select  department_id,count(employee_id) from employees group by department_id;
select department_id,count(employee_id) as 'NO. of employees',
 case
 when count(employee_id)=1 then 'Junioouur'
 when count(employee_id) in (2,3) then 'inter'
 when count(employee_id)>3 then 'seniour'
 end as 'Grade' from employees group by department_id;
 -- Having Clause--
 select department_id,max(salary) from employees where salary>10000 group by department_id;
 select department_id,max(salary) from employees group by department_id having max(salary) >10000;
 -- from join
 -- where
 -- group by
 -- having
 -- select (distinct)
 -- order by
 -- limit
select * from  employees;
select * from departments;
select job_id from employees group by job_id;
select sum(salary) from employees group by department_id;
select employee_id,avg(salary) from employees where department_id =50 group by employee_id;
select manager_id,min(salary) from employees group by manager_id order by salary ;
select max(salary)-min(salary) as mnx,department_id from employees group  by department_id having mnx>2000;
select department_id,count(employee_id),count(department_id) from employees group by department_id  having count(department_id)>2;
use hr;
select salary,salary+2000 as sal from employees having sal >10000;
-- JOIN---
select e.first_name,e.last_name,e.department_id,d.department_name from employees as e join departments as d on e.employee_id=d.department_id;
select e.first_name,e.last_name,d.department_id,d.department_name,d.location_id,l.city,l.state_province from employees as e join departments as d on e.department_id=d.department_id join locations as l on d.location_id=l.location_id;
select e.first_name,e.last_name,e.department_id,d.department_name from employees as e join departments as d on e.department_id=d.department_id where e.department_id in (80,40);
select e.department_id,d.department_id from departments as d left join employees as e on e.department_id=d.department_id;
-- select e.department_id,d.department_id from departments as d left join departments as e on e.department_id=d.department_id;
select e.first_name,e.last_name,j.job_title,j.max_salary-e.salary as jp from employees as e left join jobs as j on e.job_id=j.job_id;
select d.department_name,avg(e.salary),count(e.employee_id) from employees as e join departments as d on e.department_id=d.department_id where commission_pct is not null group by department_name;
select e.first_name,e.last_name,j.job_title,j.max_salary-e.salary as jp from employees as e right join jobs as j using(job_id) where department_id=80;
select e1.first_name,e1.salary from employees as e1 join employees as e2 where e1.salary < e2.salary and e2.employee_id=182;
select e1.first_name,e1.manager_id,e1.last_name from employees e1 join employees e2 on e2.employee_id=e1.manager_id;
select count(e.employee_id),d.department_name from employees as e join departments as d 
on e.department_id=d.department_id group by e.department_id;

select e.employee_id,l.location_id from employees as e join departments as d on e.department_id=d.department_id join locations as l on d.location_id
=l.location_id  where l.city like '%london%';
select e1.first_name,e2.manager_id from employees as e1 join employees as e2 where e1.hire_date< e2.hire_date and e1.manager_id =e2.employee_id;
select month(e.hire_date) as mn,d.department_name,l.location_id,count(e.employee_id) as ct ,l.city from employees as e join departments as d 
using(department_id)join locations as l using(location_id) where l.city='seattle' group by mn having ct>2;


select substring_index(name,' ',-1) from
(select "Mayur Shrotriya" as Name) t;


select substring_index('mayurshrotriya','s',1) , substring_index('mayurshrotriya','r',-3);