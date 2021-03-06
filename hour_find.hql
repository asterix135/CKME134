-- Christopher Graham - CKME134
-- Assignment 2, Question 1
-- Find hour of the day that most number of tweets was generated by users
-- on March 6, 2010
-- Original source file full_text.txt

drop table twitter.mar6_all;
create table twitter.mar6_all as
	select id, ts, hour(ts) as tweet_hour
	from twitter.full_text_ts
	where to_date(ts) = '2010-03-06';

drop table twitter.mar6_hour_count;

create table twitter.mar6_hour_count as
	select tweet_hour, COUNT(*) as cnt
	from twitter.mar6_all
	group by tweet_hour
	order by cnt desc;

-- export twitter.mar6_hour_count from web browser interface
