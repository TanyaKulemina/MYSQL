USE lesson_4;


-- Задача 1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого
-- (одного) пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).
CREATE TABLE users_old (
    id BIGINT UNSIGNED NOT NULL UNIQUE PRIMARY KEY,
    firstname VARCHAR(50) COMMENT 'Имя',
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DROP PROCEDURE IF EXISTS transfer_user;
DELIMITER //
CREATE PROCEDURE transfer_user(tr_user_id BIGINT)
BEGIN

    INSERT INTO users_old (id, firstname, lastname, email)
    SELECT id, firstname, lastname, email
    FROM users
    WHERE id = tr_user_id;

    DELETE
    FROM users
    WHERE id = tr_user_id;

END //
DELIMITER ;

START TRANSACTION;
CALL transfer_user(3);

SELECT *
FROM users;

SELECT *
FROM users_old;

COMMIT;

-- Задача 2. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
    RETURNS CHAR(32)
    READS SQL DATA
BEGIN

    DECLARE result CHAR(32);

    SET result = CASE
                     WHEN HOUR(CURTIME()) >= 0 AND HOUR(CURTIME()) < 6 THEN 'Доброй ночи'
                     WHEN HOUR(CURTIME()) >= 6 AND HOUR(CURTIME()) < 12 THEN 'Доброе утро'
                     WHEN HOUR(CURTIME()) >= 12 AND HOUR(CURTIME()) < 18 THEN 'Добрый день'
                     ELSE 'Добрый вечер'
        END;

    RETURN result;

END //
DELIMITER ;

SELECT hello();