-- Write a query to get the sum of impressions by day.
select date, sum(impressions) as 'Total Impressions'
from marketing_data 
group by date;

-- Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
select state, revenue
from website_revenue 
order by revenue desc 
limit 3;
-- ANSWER: The third best state (NY) generated $7,093.

-- Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
select name, sum(cost) as 'Total Cost', sum(impressions) as 'Total Impressions', sum(clicks) as 'Total Clicks', sum(revenue) as 'Total Revenue'
from marketing_data 
join campaign_info 
on marketing_data.campaign_id = campaign_info.id
join website_revenue 
on website_revenue.campaign_id = marketing_data.campaign_id 
group by marketing_data.campaign_id, name 
order by name 

-- Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
select state, sum(conversions) as 'Total Conversions'
from website_revenue join marketing_data 
on marketing_data.campaign_id = website_revenue.campaign_id
join campaign_info 
on campaign_info.id = website_revenue.campaign_id
where name = 'Campaign5'
group by state 
order by sum(conversions) desc 
-- ANSWER: Georgia (GA) generated the most conversions: 3342. 

-- In your opinion, which campaign was the most efficient, and why?
select name, sum(conversions) / sum(cost) as 'Cost per Conversion ($/conversion)'
from marketing_data join campaign_info 
on marketing_data.campaign_id = campaign_info.id 
group by campaign_id
order by conversions / cost 
-- ANSWER: I believe Campaign5 was the most efficient because it resulted in the lowest dollar cost per conversion: $1.91 per conversion. 

-- Bonus Question
-- Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
select DATENAME(date, getdate()), sum(conversions) / sum(cost) as 'Cost per Conversion ($/conversion)'
from marketing_data join campaign_info 
on marketing_data.campaign_id = campaign_info.id 
group by DATENAME(date, getdate())
order by conversions / cost 