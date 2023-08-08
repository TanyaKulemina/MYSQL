USE lesson_4;

-- Задача 1. Создайте представление, в которое попадает информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
CREATE VIEW user_info_less_20 AS
SELECT firstname,
       lastname,
       hometown,
       gender
FROM users
	INNER JOIN profiles
		ON users.id = profiles.user_id
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 20
ORDER BY firstname, lastname;

SELECT *
FROM user_info_less_20;

-- Задача 2. Найдите кол-во отправленных сообщений каждым пользователем и выведите ранжированный список 
-- пользователей, указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге
-- (первое место у пользователя с максимальным количеством сообщений) (используйте DENSE_RANK)
SELECT firstname,
       lastname,
	COUNT(messages.id) AS `Количество`,
	DENSE_RANK() OVER (
    ORDER BY COUNT(messages.id) DESC)              AS `Рейтинг`
	FROM users
         LEFT JOIN messages
		ON users.id = messages.from_user_id
GROUP BY firstname, lastname;

-- Задача 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и 
-- найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)
SELECT messages.id AS 'id',
	   messages.body AS 'message',
       messages.created_at AS 'Дата отправления',
       TIMESTAMPDIFF(MINUTE, created_at, LEAD(created_at) OVER (ORDER BY created_at )) AS 'Разница в минутах'
FROM messages;