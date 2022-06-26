create table student34(
id int,
f_name varchar(20),
l_name varchar(20),
score float,
email varchar(15)
);
alter table student34 add column age varchar(20);
alter table student34 modify l_name varchar(10);
alter table student34 rename column l_name to last_name;
insert into student34 values (101,'Swapnil','analytics',100000,'swer',56);
insert into student34 values(102,'Mayur','bussiness',150000,'fdgdg',98),(103,'vivek','sales',1030000,'gdgdfh',76),(104,'aman','manage',130000,'gfgffh',56);
select * from student34;
update student34 set last_name ='scientist' where id=102;

create table date_time2
(
dt date,
ti time,
dttime datetime
);
select * from date_time2;
desc date_time2;
insert into date_time2 values('2022/05/09', '14:38', '2022/05/09 14:38:12');
select * from employees;

select  * from employees order by salary desc;

select employee_id from employees where job_id='pu_clerk' and salary >
(select avg(salary) from employees where job_id='st_clerk') order by salary desc;

select upper(concat(first_name,' ',last_name)) as full_Name from  employees;

select replace('rwapnil rtil','r','s');


select period_diff(202009,202209) as period;

select adddate(20220915,interval 1.5 month);
select adddate(20220820,interval 10 day);
select date_format(current_date(),'%d-%m-%Y');
select str_to_date('10-aug-2020','%d-%M-%YYYY');

select *,if(salary>3000,if(salary> 4500,'BETTER','GOOD'),'CASUAL') FROM employees;
select *, if (salary<=3000,'Average',(if(salary<5000,'GOOD','BETTER'))) from employees;
select *,nullif(salary>18000,null) from employees;

select * ,
case
when salary < 3000 then first_name
end as 'gfgg' from employees; 



select name,
(select case when grades between 8 and 10 then name
else null end as 'hgdd'  from grade) from students order by name;


# 1)  For every branch find the sum of calculated profit after ignoring the loss. 
select branch,sum(revenue-cost) as calcu,revenue-cost as df from bank_branch_pl group by branch having calcu>1 order by calcu desc;


##Find the minimum revenue for each banker if estimated_profit is greater than 20000000.
select *,min(revenue) as fhh from bank_branch_pl where Estimated_profit>20000000 group by banker order by fhh desc ;

-- Find the branches for which branch level real profit is more than the estimated_profit.
select * from bank_inventory_pricing;
select * from bank_branch_pl;

select *,revenue-cost as real_profit from bank_branch_pl having real_profit > any
(select estimated_profit from bank_branch_pl);

# 13) Display the name of the branch and products whose calculated profit exceeds the estimated profit even if the cost of product is reduced by 30%.

select *,revenue-cost as real1 from bank_branch_pl having real1 > any
(select Estimated_profit from bank_branch_pl ) 
(select cost*.7 from bank_branch_pl);

select * from employees;
select * from departments;


select employee_id,a.department_id,b.department_name,a.salary,avg(a.salary) from employees a join departments b using (department_id)
where b.department_name='sales' having a.salary >avg(salary);

select employee_id,first_name from employees where department_id = 
(select department_id from departments where department_name='sales');




-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select * from ipl_bidder_points;
select * from ipl_bidding_details;


select bidder_id,winr/count(BIDDER_ID)*100 as ratio from 
(select bidder_id,count(BIDDER_ID) as winr ,bid_team from ipl_bidding_details where BID_STATUS like'%won%' group by BID_TEAM) as df group by BID_team order by winr desc; 
##select count(bidder_id) ,bid_team from ipl_bidding_details group by bid_team;
select bidder_id,sum(if(bid_status='won',1,0))/count(bidder_id)*100 as ratio from ipl_bidding_details group by BIDDER_ID order by ratio desc;


-- 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select a.stadium_id,count(match_id) as played,b.stadium_name,b.city from ipl_match_schedule as a join ipl_stadium as b using(stadium_id) group by STADIUM_ID order by STADIUM_ID ;

-- 5.	Show the team id who won the match as per the win details
select * from ipl_match;
select match_id,if(match_winner=1,team_id1,team_id2) as Team_id,win_details from ipl_match group by team_id;

select * from ipl_team;
select * from ipl_team_players;

select team_id,player_id,player_role,remarks from ipl_team_players where PLAYER_ROLE like '%bowler%' and remarks like '%MI%';

# Question 9:
# 9) Display “SAVINGS” accounts and their corresponding aggregate sum of transaction amount 
# of all recurring deposits
select * from bank_account_details;
select * from bank_account_transaction;
select * from bank_interest_rate;
select Customer_id,Account_Number,Account_type from 
(select customer_id,a.account_number,sum(transaction_amount),b.Account_type from bank_account_transaction as a join bank_account_details as b where b.Account_type like '%recurring%' group by Account_Number) as pp  group by Account_Number;

# 1) Print credit card transactions with sum of transaction_amount on all Fridays and sum of transaction_amount on all other days. 
select * from bank_account_details;
select * from bank_account_transaction;

#select a.customer_id,a.account_number,a.account_type,sum(transaction_amount) from bank_account_details as a join bank_account_transaction as b using(account_number)
select sum(transaction_amount),if(date_format(transaction_date,'%a')='fri','Friday','Other_day') as trans from bank_account_transaction as a join bank_account_details as b using(account_number) where Account_type='credit card'  group by trans;

# 3) Generate a report to Send Ad-hoc holiday greetings - “Happy Holiday” for all transactions occurred during Holidays in 3rd month.
select * from bank_account_transaction;
select * from  bank_holidays;

select Account_Number,Transaction_amount,Transaction_Date,holiday,if(Transaction_Date=holiday,'Happy Holiday',transaction_date) as curr from 
(select account_number,transaction_amount,transaction_date from bank_account_transaction where month(transaction_date)=3 group by Account_Number) as s1 join 
bank_holidays group by curr ;

#Calculate the Bank accrued interest with respect to their RECURRING DEPOSITS  for any deposits older than 30 days.
select * from bank_account_transaction;
select * from bank_interest_rate;

select df.account_number,Transaction_Date,Transaction_amount*interest_rate,b.Account_type from 
 (select account_number,transaction_amount,transaction_date from bank_account_transaction where Transcation_channel like '%deposit%') as df 
 join bank_account_details as b using(account_number) join bank_interest_rate as c on b.Account_type=c.account_type  ;
 
 
 
 select * from cust_dimen;
select * from market_fact;
select * from orders_dimen;
select * from prod_dimen;
select * from shipping_dimen;


select salary from employees as a join ( select avg(salary) from employees group by department_id) as b ;