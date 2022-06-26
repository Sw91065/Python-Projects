-- use inclass
# Question 1:
# 1) Print customer Id, customer name and average account_balance maintained by each customer for all 
# of his/her accounts in the bank.
select c.customer_id,c.customer_name,avg(a.balance_amount) as avg from bank_account_details as a join bank_customer as c using(customer_id)
group by c.customer_id;

# Question 2:
# 2) Print customer_id , account_number and balance_amount for all the accounts.
# for account_type = "Credit Card" apply the condition that if balance_amount is nil then assign transaction_amount  
select c.account_type,c.customer_id,c.account_number,if(c.balance_amount=0,t.Transaction_amount,c.balance_amount) as loss
from bank_account_details as c join bank_account_transaction as t
using(account_number) where c.account_type='credit card';

# Question 3:
# 3) Print account_number and balance_amount , transaction_amount,Transaction_Date from Bank_Account_Details and 
# bank_account_transaction for all the transactions occurred during march,2020 and april, 2020
select b.account_number,b.balance_amount,t.Transaction_amount,t.Transaction_Date from Bank_Account_Details as b join bank_account_transaction as t using(account_number)
 having month(Transaction_Date) in (3,4) and year(Transaction_Date)=2020;
select distinct * from bank_account_transaction;
# Question 4:
# 4) Print the customer ids, account_number, balance_amount,transaction_amount ,transaction_date who did transactions 
# during the first quarter. Do not display the accounts if they have not done any transactions in the first quarter.
select a.customer_id,a.account_number,a.balance_amount,t.transaction_amount,t.transaction_date,c.customer_name from 
bank_account_details as a join bank_account_transaction as t using(account_number) join bank_customer as c using
 (customer_id)  having month(Transaction_Date) between 1 and 3;

# Question 5:
# 5) Print account_number, Event and Customer_message from BANK_CUSTOMER_MESSAGES and Bank_Account_Details to 
# display an “Adhoc" Event for all customers who have  “SAVINGS" account_type account.
-- select(select event,customer_message from Bank_customer_messages as m where event='adhoc'
select account_number,customer_id from bank_account_details where account_type='savings';
select * from bank_account_details;
# Question 6:
# a) Display records of All Accounts , their Account_types, the balance amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types
select a.customer_id,a.account_type,a.balance_amount from bank_account_details as a join
 bank_account_relationship_details as b using(customer_id) ;
select * from bank_account_details;
# Question 7:
# a) Display records of All Accounts , their Account_types, the balance amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 
# c) After retrieving all records of accounts and their linked accounts, display the  
# transaction amount of accounts appeared  in another column.
select a.customer_id,a.account_type,a.balance_amount,t.transaction_amount from bank_account_details as a join 
bank_account_relationship_details as b using(customer_id) join bank_account_transaction as t on b.account_number=t.account_number ;

# Question 8:
# 8) Display all type of "Credit cards"  accounts including "Add-on Credit Cards" 
# type accounts with their respective aggregate sum of transaction amount.

# Ref: Check Bank_Account_Details_table for all types of credit card.
        # Check transaction_amount in bank_account_transaction. 
select b.account_type,sum(a.Transaction_amount) as sii from bank_account_details as b join bank_account_transaction as a
using(account_number) where account_type like '%credit card%' group by account_type;

# Question 9:
# 9) Display “SAVINGS” accounts and their corresponding aggregate sum of transaction amount 
# of all recurring deposits
select * from bank_account_details;
select * from bank_account_transaction;
select * from bank_interest_rate;
select a.customer_id,a.account_type,sum(b.transaction_amount) from bank_account_details as a join bank_account_transaction as b 
using(account_number) where account_type='savings' and b.transaction_amount>0  group by b.account_number;
# Question 10:
# 10) Display every account's total no of transactions for every year and each month.
 select a.customer_id,count(account_number),b.account_number,month(transaction_date),year(transaction_date) from bank_account_details as 
 a join bank_account_transaction as b using(account_number) group by month(transaction_date);

# Question 11:
# 11) Display savings accounts and its corresponding Recurring deposits transactions that are more than 4 times.
select a.customer_id,a.account_type,a.account_number from bank_account_details as a join bank_account_transaction as b
 using(account_number) where account_type='savings'group by b.account_number having count(a.account_number)>4 ;
 

# Question 12:
# 12) Find the no. of transactions of credit cards including add-on Credit Cards
select count(customer_id),b.account_number,a.account_type from bank_account_details as a join bank_account_transaction as b 
on a.account_number=b.account_number where a.account_type like '%credit card%' group by account_type;