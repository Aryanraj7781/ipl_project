select *                                          /*First 20 Row*/
from  ipl.ipl_matches
limit 20;

select *                                         /*Match Happen on 02-05-2022*/
from ipl.ipl_matches
where date = '02-05-2013';

select count(id)                                /*all the matches where the margin of victory is more than 100 runs*/
from ipl.ipl_matches
where result_margin > 100;

select count(distinct city)                     /*Get the count of cities that have hosted an IPL match*/
from ipl.ipl_matches;

select * from ipl.ipl_matches                   /* tied matches*/
where eliminator = 'y'
order by date desc;

create table ipl.deliveries_v02 as select *,                                     /*ball_result*/
case when total_runs >= 4 then 'boundary'
when total_runs = 0 then 'dot'
else 'other'
end as ball_result
from ipl.ipl_ball;

select ball_result, count(*) from ipl.deliveries_v02                               /*total number of boundary and dot ball*/
group by ball_result;

select batting_team, count(*) as total_boundary from ipl.deliveries_v02            /*total number of boundary scored by each team*/
 where ball_result = 'boundary' 
 group by batting_team
 order by total_boundary desc;
 
 select bowling_team , count(*) as total_dot from ipl.deliveries_v02           /*total number of dot ball scored by each team*/
 where ball_result = 'dot'
 group by bowling_team
 order by total_dot desc;
 
 select distinct dismissal_kind ,count(*) from ipl.deliveries_v02                /*total number of dismissal by dismissal kind*/
 group by dismissal_kind;
 
 select bowler ,count(extra_runs) as total_extra from ipl.deliveries_v02       /* top 5 bowler who conceded maximum run*/
 group by bowler
 order by total_extra desc
 limit 5;
 
 create table ipl.deliveries_v03 as                                         /* creating table and joining with other table*/
  select a.*,b.venue ,b.match_date
  from ipl.deliveries_v02 as a
  left join(select max(venue) as venue ,max(`date`) as match_date,id from ipl.ipl_matches group by id )  as  b
  on a.id = b.id;

select venue ,count(total_runs) as run from ipl.deliveries_v03             /*total run scored at each venue*/
group by venue
order by run desc;

select extract(year from match_date) as ipl_year, sum(total_runs) as run from ipl.deliveries_v03          /*year wise total run scored at eaden garden*/
where venue = 'eden Gardens'
group by ipl_year
order by run desc ;

select distinct(team1) from ipl.ipl_matches;                                                         /*team name replace*/
create table ipl.matches_corrected as select *,
replace(team1,'Rising Pune Supergiants','Rising Pune Supergiant') as team1_corr,
replace(team2,'Rising Pune Supergiant','Rising Pune Supergiants') as team2_corr 
from ipl.ipl_matches;

select distinct(team1_corr) from ipl.matches_corrected;                 

create table ipl.deliveries_v04 as select *, concat(id,'-',inning,'-',`over`,'-',ball) as ball_id from ipl.deliveries_v03;              /*creating ball id*/
select * from ipl.deliveries_v04;

select count(id) as total_row, count(distinct id) as match_id from ipl.deliveries_v04;           
create table ipl.deliveries_v05 as select *,
row_number() over (partition by ball_id) as r_num from ipl.deliveries_v04;
select * from ipl.deliveries_v05;

select count(r_num) from ipl.deliveries_v05 WHERE r_num=2;
SELECT * FROM ipl.deliveries_v05 WHERE ball_id in (select BALL_ID from ipl.deliveries_v05 WHERE r_num=2);




