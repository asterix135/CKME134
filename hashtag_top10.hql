-- Christopher Graham - CKME134
-- Assignment 2, Question 2
-- Find top 10 hashtags
-- Original source file full_txt.txt

drop table twitter.hashtag_list;
drop table twitter.hashtag_top10_v1;
		
-- Create table of ids and extracted hashtags
create table twitter.hashtag_list as
	select id, hashtag
	from twitter.full_text_ts
	lateral view explode(split(tweet, '\\s')) tmp as hashtag
	where hashtag REGEXP '^#';

-- Create count table	
create table twitter.hashtag_count as
	select hashtag, COUNT(*) as cnt
	from twitter.hashtag_list
	group by hashtag
	order by cnt desc;	
	
