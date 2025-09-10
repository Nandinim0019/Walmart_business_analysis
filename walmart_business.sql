SELECT * FROM walmart;
describe walmart;
set sql_safe_updates=0;
update walmart
set unit_price=replace(unit_price,"$"," ");
alter table walmart 
modify unit_price decimal(10,2);
update walmart
set date=str_to_date(date,"%d/%m/%y");
alter table walmart 
modify column date date;
alter table walmart 
modify column time time;


#1 Find different payment methods, number of transactions, and quantity sold by payment method
select payment_method, 
       count(*) as no_of_transactions, 
       sum(quantity) as quantity_sold
from walmart
group by 1;


#2 Identify the highest-rated category in each branch. Display the branch, category, and avg rating
with high_rate as
       (
       select branch,
              category,
			  round(avg(rating),2) as avg_rating,
              dense_rank() over(partition by branch order by round(avg(rating),2)) as rnk
		from walmart
        group by 1,2
        )
select branch,
       category,
       avg_rating 
from high_rate
where rnk=1;


#3 Identify the busiest day for each branch based on the number of transactions
with transaction_rank as
       (
       select date,
	   branch,
       count(*) as no_of_transaction,
       dense_rank() over(partition by branch order by count(*) desc) as rnk
       from walmart
       group by 1,2
       )
select dayname(date),
       branch,
       no_of_transaction 
from transaction_rank 
where rnk=1;


#4 Determine the average, minimum, and maximum rating of categories for each city
select city,
       category,
       round(avg(rating),2) as avg_rating,
       max(rating) as max_rating,
       min(rating) as min_rating 
from walmart
group by 1,2
order by city;


#5 Calculate the total profit for each category
select category,
	   round(sum(unit_price*quantity*profit_margin),2) as total_profit
from walmart
group by 1
order by total_profit desc;


#6 Determine the most common payment method for each branch
with payment_rnk as
       (
       select branch,
              payment_method,
              count(*) as payment_count,
              dense_rank() over(partition by branch order by count(*) desc) as rnk
	   from walmart
       group by 1,2
       )
select branch,
       payment_method as common_payment_method
from payment_rnk 
where rnk=1;


#7 Categorize sales into Morning, Afternoon, and Evening shifts
with time_shift as
	    (
        select time,
		           case when hour(time)<12 then "Morning"
			            when hour(time) between 12 and 17 then "Afternoon"
                        when hour(time)>17 then "Evening"
				   end as shift
		from walmart
	    )
select shift,
       count(*) as no_of_sales 
from time_shift
group by 1;


#8 Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)
with sale_yr as
             (
             select branch,
					year(date) as year_of_sale ,
                    sum(unit_price*quantity) as revenue 
			 from walmart
			 where year(date) in(2022,2023)
             group by 1,2
             order by branch
             ),
lag_value as
             (
             select branch,
             revenue as revenue_2023,
             lag(revenue,1) over(partition by branch) as revenue_2022,
             round((revenue-lag(revenue,1) over(partition by branch))/lag(revenue,1) over(partition by branch)*100,2) as revenue_decrease_ratio
             from sale_yr
             order by revenue_decrease_ratio asc
			 )
select 
      branch,
      revenue_2023,
      revenue_2022,
      revenue_decrease_ratio 
from lag_value
where revenue_decrease_ratio is not null
order by revenue_decrease_ratio asc
limit 5;


       
      









