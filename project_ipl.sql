select *                                   /*5*/
from  ipl.ipl_matches
limit 20;
select *                                  /*7*/
from ipl.ipl_matches
where date = '02-05-2013';
select *                                 /*all the matches where the margin of victory is more than 100 runs*/
from ipl.ipl_matches
where result_margin > 100;
select count( distinct venue)          /*Get the count of cities that have hosted an IPL match*/
from ipl.ipl_matches;
select * from ipl.ipl_matches           /* tied matches*/
where eliminator = 'y';