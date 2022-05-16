select count(distinct(id)) as match_played,count(id) as ball_faced ,batsman ,match_year,((sum(total_runs)/count(id))*100) as strike_rate from ipl.deliveries_v06 
where  match_year = 2014 
group by batsman
order by strike_rate desc , match_played asc;

create table ipl.ipl_run as select count(distinct(id)) as match_played , sum(total_runs) as run, count(id) as ball,((sum(total_runs)/count(id))*100) as strike_rate,batsman ,batting_team from ipl.deliveries_v06 
group by batsman order by run desc;
select * from ipl.ipl_run; 

alter table ipl.ipl_run drop column batting_team;
select batsman,count(ball_result) as boundary from ipl.deliveries_v03 group by batsman order by boundary ;

create table ipl.four select count(ball_result) as four ,batsman from ipl.deliveries_v03 where total_runs = 4 group by batsman;

create table ipl.six select count(ball_result) as six ,batsman from ipl.deliveries_v03 where total_runs = 6 group by batsman;

create table ipl.player as 
  select a.*,b.six 
  from ipl.play as a
  left join ipl.six as  b
  on a.batsman = b.batsman;
  select batsman ,sum(total_runs) from ipl.deliveries_v06 group by id ;
