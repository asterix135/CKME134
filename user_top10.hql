-- Christopher Graham - CKME134
-- Assignment 2, Question 3
-- Find top 10 mentions @xxxxxxx
-- Original source file full_text.txt
-- Creation of Hive database not documented because it was done in lab

drop table twitter.mention_list;
drop table twitter.mention_top10;

-- create table of id's and extracted mention names
create table twitter.mention_list as
	select id, 
	regexp_extract(lower(user_full), 
		'(.*)@user_(\\S{8})([:| ])(.*)', 2) as user
	from twitter.full_text_ts
	lateral view explode(split(tweet, '\\s')) tmp as user_full
	where trim(regexp_extract(lower(user_full),
		'(.*)@user_(\\S{8})([:| ])(.*)',2)) != '';
	
-- create count table
create table twitter.user_top10 as
	select user, COUNT(*) as cnt
	from twitter.mention_list
	group by user
	order by cnt desc
	limit 10;

-- export count table from web browser interface
