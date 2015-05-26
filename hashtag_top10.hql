-- Christopher Graham - CKME134
-- Assignment 2, Question 2
-- Find top 10 hashtags
-- Original source file full_txt.txt

drop table twitter.hashtag_list;
drop table twitter.hashtag_top10;
		
-- Create table of ids and extracted hashtags
create table twitter.hashtag_list as
	select id, hashtag
	from twitter.full_text_ts
	lateral view explode(split(lower(tweet), '\\s')) tmp as hashtag
	where hashtag REGEXP '^#';

-- Create count table	
create table twitter.hashtag_top10 as
	select hashtag, COUNT(*) as cnt
	from twitter.hashtag_list
	group by hashtag
	order by cnt desc
	limit 10;	
	
-- export count table from web browser interface
