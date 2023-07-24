USE myfirstdb;

CREATE TABLE orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id VARCHAR(3) NOT NULL UNIQUE,
	amount DOUBLE,
    order_status VARCHAR(10)
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, "OPEN"),
('e01', 25.50, "OPEN"),
('e05', 100.70, "CLOSED"),
('e02', 22.18, "OPEN"),
('e04', 9.50, "CANCELLED");

SELECT *,
CASE
	WHEN order_status = "OPEN"
		THEN "Order is in open state"
	WHEN order_status = "CLOSED"
		THEN "Order is closed"
	WHEN order_status = "CANCELLED"
		THEN "Order is cancelled"
END AS "full_order_status"
FROM orders;