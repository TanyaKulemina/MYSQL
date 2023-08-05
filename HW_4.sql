USE lesson_4;

-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT COUNT(likes.id) 
FROM likes
	INNER JOIN media
		ON likes.media_id = media.id
	INNER JOIN profiles
		ON media.user_id = profiles.user_id
WHERE TIMESTAMPDIFF(year, birthday, curdate()) < 12;
	
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT profiles.gender
FROM likes
	INNER JOIN users
		ON likes.user_id = user_id
	INNER JOIN profiles
		ON users.id = profiles.user_id
GROUP BY gender
HAVING COUNT(likes.id) = (SELECT COUNT(likes.id) AS likes_gender
FROM likes
	INNER JOIN users
		ON likes.user_id = user_id
	INNER JOIN profiles
		ON users.id = profiles.user_id
GROUP BY gender
ORDER BY likes_gender DESC
limit 1);

-- Вывести всех пользователей, которые не отправляли сообщения.
SELECT users.firstname, users.lastname
FROM users
	LEFT JOIN messages
		ON users.id = messages.from_user_id
WHERE messages.from_user_id is null;

-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.
SELECT users.*
FROM friend_requests
	INNER JOIN users
		ON friend_requests.initiator_user_id = users.id 
        OR friend_requests.target_user_id = users.id
	INNER JOIN messages
		ON users.id = messages.from_user_id
WHERE friend_requests.status = 'approved' 
AND messages.to_user_id = 1
GROUP BY users.id
HAVING COUNT(messages.id) = (SELECT COUNT(messages.id) AS count_msg
FROM friend_requests
	INNER JOIN users
		ON friend_requests.initiator_user_id = users.id 
        OR friend_requests.target_user_id = users.id
	INNER JOIN messages
		ON users.id = messages.from_user_id
WHERE friend_requests.status = 'approved' 
AND messages.to_user_id = 1
GROUP BY users.firstname, users.lastname
ORDER BY count_msg DESC
LIMIT 1)
	
	





	

	