USE lesson_4;

/* Задача 1: выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
(используя вложенные запросы)
*/
SELECT users.id,
users.firstname,
users.lastname,
(SELECT hometown
FROM profiles
WHERE user_id = users.id) AS 'town',
(SELECT filename
FROM media
WHERE id = (SELECT photo_id
FROM profiles
WHERE user_id = users.id)) AS 'avatar'
FROM users;


/*
Задача 4: выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
(используя JOIN)
*/
SELECT users.id, users.firstname, users.lastname, profiles.hometown, media.filename
FROM users
INNER JOIN profiles
ON users.id = profiles.user_id
LEFT JOIN media
ON media.id = profiles.photo_id;

/*
Задача 2.1: выбрать фотографии (filename) пользователя с email: arlo50@example.org.
ID типа медиа, соответствующий фотографиям неизвестен (используя вложенные запросы)
*/
SELECT media.filename
FROM media
WHERE media.user_id = (SELECT id
FROM users
WHERE email = 'arlo50@example.org')
AND media.media_type_id = (SELECT id
FROM media_types
WHERE name_type LIKE 'Photo');

SELECT *
FROM media_types;

/*
Задача 2.2: выбрать фотографии (filename) пользователя с email: arlo50@example.org.
ID типа медиа, соответствующий фотографиям неизвестен (используя JOIN)
*/
SELECT media.filename
FROM media
INNER JOIN users
ON media.user_id = users.id
INNER JOIN media_types
ON media.media_type_id = media_types.id
WHERE users.email = 'arlo50@example.org'
AND media_types.name_type = 'Photo';

/*
Задача 3: выбрать id друзей пользователя с id = 1
(используя UNION)
*/
SELECT friend_requests.initiator_user_id
FROM friend_requests
WHERE target_user_id = 1
AND status = 'approved'
UNION
SELECT friend_requests.target_user_id
FROM friend_requests
WHERE initiator_user_id = 1
AND status = 'approved';

SELECT *
FROM friend_requests;

/*
Задача 5: Список медиафайлов пользователей с количеством лайков (используя JOIN)
*/
SELECT users.firstname,
users.lastname,
media.filename,
COUNT(likes.id) AS 'likes'
FROM users
INNER JOIN media 
	ON users.id = media.user_id
LEFT JOIN likes
	ON media.id = likes.media_id
GROUP BY users.firstname, users.lastname, media.filename
ORDER BY users.firstname;

SELECT users.firstname,
users.lastname,
media.filename,
likes.id
FROM users
INNER JOIN media
ON users.id = media.user_id
LEFT JOIN likes
ON media.id = likes.media_id
ORDER BY users.firstname;

/*
Задача 6: Список медиафайлов пользователей, указав название типа медиа (id, filename, name_type)
(используя JOIN)
*/
SELECT media.id, media.filename, media_types.name_type
FROM media
INNER JOIN media_types
ON media.media_type_id = media_types.id;

/*
Задача 7: Вывести список людей и количество сообщений, написанных ими.
*/
SELECT users.firstname,
users.lastname,
COUNT(messages.id) AS 'count_msg'
FROM users
LEFT JOIN messages
ON users.id = messages.from_user_id
GROUP BY users.firstname, users.lastname
ORDER BY users.firstname;