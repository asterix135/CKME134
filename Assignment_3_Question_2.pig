--Assignment 3 - Pig - Question 2
--CKME134
--Christopher Graham

a = load '/user/lab/pig/full_text.txt' as (id:chararray, ts:chararray,
	location:chararray, lat:float, lon:float, tweet:chararray);
b = foreach a generate id, ts, flatten(TOKENIZE(LOWER(tweet))) as token;
c = filter b by (token MATCHES '^#(.*)');
d = group c by token;
e = foreach d generate group as token, COUNT(c) AS cnt;
f = order e by cnt desc;
g = limit f 3;
dump g;