-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select * from ipl_bidder_details;
select * from ipl_bidder_points;
select * from ipl_bidding_details;

select t.bidder_id, bd/bdw*100 as d from
(select bidder_id,count(bid_status) as bd,bid_status from ipl_bidding_details where bid_status='won' group by bidder_id ) as t join
(select bidder_id,count(bid_status) as bdw,bid_status from ipl_bidding_details group by bidder_id) as p 
using(bidder_id) group by bidder_id order by d desc ;

-- 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
select s.stadium_name,count(m.match_id),s.stadium_id,s.city from ipl_stadium as s join ipl_match_schedule as m using(stadium_id) group by STADIUM_ID;

select * from ipl_match;


-- 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
select tt.match_id,cb/cm*100,tt.stadium_id,stadium_name from 
(select m.match_id,count(m.match_id) as cm,s.stadium_id from ipl_match as m join ipl_match_schedule as s using (match_id)group by stadium_ID)
 as tt join (select m.match_id,count(m.match_id) as cb,s.stadium_id from ipl_match as m join ipl_match_schedule as s using (match_id)
where TOSS_WINNER=MATCH_WINNER group by stadium_ID) as pp using(stadium_id) join ipl_stadium as l  using(STADIUM_ID) order by stadium_name;



-- 4.	Show the total bids along with bid team and team name.
select bid_team,team_name,count(bid_team) as pp from ipl_bidding_details as a join ipl_team as b on team_id=bid_team group by BID_TEAM;


select * from ipl_bidding_details;
select * from ipl_team;

-- 5.	Show the team id who won the match as per the win details.
select * from ipl_match;
select * from ipl_team;
select * from ipl_tournament;
select * from ipl_team_standings;
select win_details,if(match_winner=1,team_id1,team_id2) from ipl_match group by  win_details;
-- 6.	Display total matches played, total matches won and total matches lost by team along with its team name.
select sum(matches_played),sum(matches_won),sum(matches_lost),b.team_name from ipl_team_standings as a join ipl_team as b using(team_id) group by team_name;



-- 7.	Display the bowlers for Mumbai Indians team.
select * from ipl_team;
select * from ipl_team_players;
select b.TEAM_NAME,a.team_id,a.player_id,a.PLAYER_ROLE from ipl_team_players as a join ipl_team as b using(team_id) where PLAYER_ROLE like '%bowl%' and
 TEAM_ID = (select team_id from ipl_team where team_name like 'mumbai%') ;


-- 8.	How many all-rounders are there in each team, Display the teams with more than 4 
-- all-rounder in descending order.
select count(player_role) as ct,a.remarks,t.team_name  from ipl_team_players as a join ipl_team as t using(team_id)
 where PLAYER_ROLE like '%rounder%' group by team_id having ct>4 ; 
 
 
 