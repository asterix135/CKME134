--Assignment 3 - Pig - Question 1
--CKME134
--Christopher Graham

a = LOAD '/user/lab/pig/full_text.txt' AS (id:chararray, ts:chararray,
	location:chararray, lat:float, lon:float, tweet:chararray);

b = FOREACH a GENERATE id, ts, tweet, REGEX_EXTRACT(LOWER(tweet), 
	'(.*?)@user_(\\S{8})([:| ])(.*?)', 2) as mention1,
	REGEX_EXTRACT(LOWER(tweet),
	'(.*?)@user_(\\S{8})([:| ])(.*?)@user_(\\S{8})([:| ])(.*)', 5) as mention2,
	REGEX_EXTRACT(LOWER(tweet),
	'(.*?)@user_(\\S{8})([:| ])(.*?)@user_(\\S{8})([:| ])(.*?)@user_(\\S{8})',
	8) as mention3
;

c = store b into '/user/lab/pig/top_3_users.txt';
