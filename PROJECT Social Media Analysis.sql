-- --------------- SOCIAL MEDIA ANALYSIS BY MYSQL ---------------------------

-- Description
-- Designed and implemented a MySQL-based social media analysis project, 
-- leveraging relational database capabilities to efficiently 
-- store, retrieve, and analyze extensive social media data. 
-- Developed features including user profiles, post storage, s
-- entiment analysis, and trend tracking to provide 
-- aluable insights into user behavior and trending topics. 
-- Demonstrated proficiency in database management for 
-- effective data organization and retrieval, showcasing 
-- a keen understanding of scalable and well-structured MySQL systems

use social_media;

show tables;
# total 13 tables are in database

-- task 1) Check data.

select * from users;
select * from login;
select * from post;
select * from comments;

-- 2) Total users in our data.
select count(user_id) total_users from users;
-- Total users are 50.

-- 3) Total post in our data.
select count(post_id) total_posts from post;
-- Total posts are 100.

-- 4) Average post per user.
select count(post_id)/count(distinct user_id) from post;
-- On an average 2 posts are done by each user.

-- 5) Display users who have posted 5 or more than 5 posts.
select user_id, count(post_id) total_posts
from post
group by user_id
having total_posts>=5
order by total_posts desc;

select c1.user_id, username, count(c2.post_id) total_posts
from users c1 inner join post c2
on c1.user_id=c2.user_id
group by c1.user_id
having total_posts>=5
order by total_posts desc;

# user_id, username, total_posts
# 37, Ethan, 6
# 7, sunil, 5
# 40, Freddie, 5
# 47, Liam, 5

-- 6) Display users with 0 comment.
select * from users where user_id not in (select user_id from post);
-- Total 5 users have not posted anything.

-- 7) Display users who dont follow anybody.
select user_id, username  as 'not_follower' 
from users
where user_id not in (select distinct follower_id from follows
where follower_id!=followee_id);
-- 0 . There is no such user who dont follow anybody.

-- 8) Display number of comment by each user.
select c1.user_id, c1.username, count(c2.comment_id) total_comments
from users c1 inner join comments c2
on c1.user_id=c2.user_id
group by c1.user_id
order by total_comments desc;
-- Theo >> 9 comments.

-- 9) Display users with maximum posts.
select c1.user_id, username, count(c2.post_id) total_posts
from users c1 inner join post c2
on c1.user_id=c2.user_id
group by c1.user_id
order by total_posts desc
limit 1;
# user_id, username, total_posts
# 37, Ethan, 6

-- 11) Display users with maxximum posts
SELECT C1.user_id, C1.username, count(C2.post_id) total_posts
FROM users C1 INNER JOIN Post C2
ON C1.user_id=C2.user_id
Group by C1.user_id
order by total_posts Desc
limit 1;
-- >> User_id 37 Ethan has done 6 posts

-- 12) Display no of logins per user
Select User_ID, count(login_id) Total_Logins From login
Group by user_ID;
-- Total 39 users has done login

-- 13) Display most liked post
SELECT C1.post_id, count(DISTINCT c1.user_id) Total_Likes
FROM post_likes C1 inner join post c2
ON c1.post_id=C2.post_id
group by C1.post_Id
order by total_likes DESC
limit 1;
# post_id, Total_Likes
# 42, 24

-- 14) Longest Caption in the post
SELECT user_id, caption, length(caption) as Caption_Length
FROM post
order by caption_length DESC
limit 1;
# user_id, caption, Caption_Length
# 37, Being sexy is about attitude possessed, not a body type. 
# It’s a state of mind., 80

-- 15) Find the users having followers more than 40
Select Followee_id, count(follower_ID) AS Count From Follows
group by Followee_id
having count>=40
order by 2 desc;
-- 14 users are having followers more than 40

-- 16) Display Most used hashtag
SELECT hashtag_name, count(*) Total
FROM hashtags
Group by hashtag_id;
-- 31 hashtags.

SELECT C1.hashtag_id,C2.hashtag_name,count(*) Total
FROM POST_TAGS C1 inner join hashtags C2
ON C1.hashtag_ID=C2.Hashtag_ID
GROUP BY C1.hashtag_id,C2.hashtag_name
Order by Total DESC;
-- Beautiful is most used hastag in our database.

-- 17) Find Most inactive user
SELECT USER_ID,USERNAME as 'INACTIVE USERS'
FROM users where user_id not in (select user_id FROM post);
# USER_ID, INACTIVE USERS
# 49, Jamie



