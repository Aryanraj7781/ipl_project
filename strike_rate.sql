select count(distinct(id)) as match_played,count(id) as ball_faced ,batsman ,match_year,((sum(total_runs)/count(id))*100) as strike_rate from ipl.deliveries_v06 
where  match_year = 2014
group by batsman
order by strike_rate desc , match_played asc
