--1. write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

with cte as (select distinct top 5 City 
			,sum(cast(amount as bigint)) over(partition by city) as city_wise_total
			,sum(cast(amount as bigint)) over(order by city rows between unbounded preceding and unbounded following) as total
			from credit_card
			order by city_wise_total desc
			)
select city, city_wise_total, 100*city_wise_total/total perc from cte


--2. write a query to print highest spend month and amount spent in that month for each card type

select * from (
				select  datepart(YEAR, Date) 'year'
						,datepart(MONTH, Date) 'month'
						,card_type, sum(cast(amount as bigint)) total
						,RANK() over(partition by card_type order by sum(cast(amount as bigint)) desc) rnk
				from credit_card
				group by Card_Type, datepart(MONTH, Date), datepart(YEAR, Date)
			  ) a
where rnk = 1


--3. write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with c1 as (
			select *,	sum(amount) over(partition by card_type order by date, amount) card_spend
			from credit_card
			)
     ,c2 as (
			select *,	RANK() over(partition by card_type order by card_spend) rnk
			from c1
			where card_spend>=1000000)

select * from c2 where rnk = 1



--4. write a query to find city which had lowest percentage spend for gold card type

with c1 as (
			select distinct city, card_type
					,sum(amount) over(partition by city, card_type) amount_card
					,sum(amount) over(partition by city) amount_city
					from credit_card
			)

select top 1 *, round(100*cast(amount_card as float)/cast(amount_city as float), 2) perc
from c1
where Card_Type = 'Gold'
order by amount_card

--5. write a query to print 3 columns: city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

with c1 as (
			select city, Exp_Type, sum(amount) amount_by_type
			from credit_card
			group by city, Exp_Type
			)
,c2 as     (
			select city, max(amount_by_type) max_amount, min(amount_by_type) min_amount
			from c1
			group by city
			)

select c1.city
	  ,max(case when c1.amount_by_type = c2.max_amount then c1.exp_type end) as highest_exp_type
	  ,max(case when c1.amount_by_type = c2.min_amount then c1.exp_type end) as lowest_exp_type
from c1 inner join c2
on c1.city = c2.city
group by c1.city
order by c1.city







--6. write a query to find percentage contribution of spends by females for each expense type

with c1 as (
			select exp_type, Gender, sum(cast(amount as float)) amount_by_female 
			from credit_card
			where Gender = 'F'
			group by Exp_Type, Gender
			)
	,c2 as (
			select exp_type, sum(cast(amount as float)) amount_by_exptype
			from credit_card
			group by Exp_Type)

	select c2.exp_type
			,c1.amount_by_female
			,c2.amount_by_exptype
			,ROUND(100*c1.amount_by_female/c2.amount_by_exptype, 2) per_cont
	from c1  join c2
	on c1.exp_type = c2.exp_type


--7. which card and expense type combination saw highest month over month growth in Jan-2014

with c1 as (
			select  Card_Type, Exp_Type
					,DATEPART(YEAR, Date)  trans_year 
					,DATEPART(MONTH, Date) trans_month
					,sum(Amount)		   total_amount 
					from credit_card
			group by Card_Type, Exp_Type, DATEPART(YEAR, Date), DATEPART(MONTH, Date)
			)
	,c2 as (
			select *, LAG(total_amount,1) over(partition by Card_Type, Exp_Type order by trans_year, trans_month) pre_month
			from c1)

	select top 1*, 100*cast((total_amount-pre_month) as float)/CAST(pre_month as float) perc
	from c2 
	where trans_year = 2014 and  trans_month = 1
	order by perc desc




--8. during weekends which city has highest total spend to total no of transcations ratio 

select top 1 city
	   ,sum(amount) amount_city
	   ,count(1) no_of_trans
	   ,sum(amount)/count(1) ratio
from credit_card
where DATEPART(WEEKDAY, date) in (7,1)
group by city
order by ratio desc


--9. which city took least number of days to reach its 500th transaction after first transaction in that city

with c1 as (
			select City, Date, ROW_NUMBER() over(partition by city order by date) trans_no
			from credit_card
			)
	,c2 as (
			select *
			,LEAD(Date,1) over(order by city) day500
			,datediff(day,  date, LEAD(Date,1) over(order by city)) days_taken
			from c1
			where City in (select city from c1	where trans_no =500)
			and trans_no in (1,500)
			)
select  top 1 * from c2
where trans_no = 1
order by days_taken
