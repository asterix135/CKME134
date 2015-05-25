-- Christopher Graham - CKME134
-- Assignment 2, Question 2
-- Find top 10 hashtags
-- Original source file full_txt.txt

drop table twitter.hashtag_top10_v1;

create table twitter.hashtag_top_10_v1 as
	select id, ts, tweet,
	regexp_extract(lower(tweet_element), 
		'(.*)(#\\S+)\\s(.*)', 2) as hashtag
	from twitter.full_text_ts_complex
	lateral view explode(split(tweet, '\\s')) tmp as tweet_element
	where trim(regexp_extract(lower(tweet_element),
		'(.*)(#\\S+)\\s(.*)',2)) != "";