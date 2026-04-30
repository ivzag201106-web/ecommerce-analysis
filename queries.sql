-- ============================================
-- E-commerce Olist | SQL-запросы
-- Инструмент: Beekeeper Studio (SQLite)
-- ============================================


-- 1. Суммарный оборот по способам оплаты
SELECT 
  payment_type AS Способ_Оплаты, 
  COUNT(payment_type) AS Количество_сделок, 
  SUM(payment_value) AS Суммарный_Оборот
FROM Payments
GROUP BY payment_type
ORDER BY ROUND(AVG(payment_value), 2) DESC;


-- 2. Средний чек по способам оплаты
SELECT 
  payment_type AS Способ_Оплаты, 
  ROUND(AVG(payment_value), 2) AS Средний_чек,
  COUNT(payment_type) AS Количество_сделок 
FROM Payments
GROUP BY payment_type
ORDER BY ROUND(AVG(payment_value), 2) DESC;


-- 3. Топ-10 категорий по объёму продаж
SELECT 
  p.product_category_name AS Категория,
  COUNT(p.product_category_name) AS Количество_заказов,
  SUM(o.price) AS Объём_продаж
FROM OrderItems AS o 
INNER JOIN Products AS p ON p.product_id = o.product_id  
GROUP BY p.product_category_name
ORDER BY SUM(o.price) DESC 
LIMIT 10;


-- 4. Топ-10 категорий по среднему чеку
SELECT 
  p.product_category_name AS Категория,
  COUNT(p.product_category_name) AS Количество_заказов,   
  ROUND(AVG(o.price), 2) AS Средний_чек  
FROM OrderItems AS o 
INNER JOIN Products AS p ON p.product_id = o.product_id  
GROUP BY p.product_category_name
ORDER BY ROUND(AVG(o.price), 2) DESC 
LIMIT 10;


-- 5. Распределение клиентской базы по штатам
SELECT
  customer_state AS Штат,
  COUNT(customer_id) AS Количество_клиентов
FROM Customers
GROUP BY customer_state
ORDER BY COUNT(customer_id) DESC;


-- 6. Среднее время доставки по штатам (в днях)
SELECT 
  c.customer_state AS Штат,
  ROUND(AVG(julianday(o.order_delivered_timestamp) - julianday(o.order_purchase_timestamp)), 0) AS Среднее_время_доставки
FROM Orders AS o
INNER JOIN Customers AS c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY Среднее_время_доставки DESC;


-- 7. Статусы доставки заказов (просрочен / вовремя)
SELECT 
  order_id AS Заказ,
  CASE 
    WHEN order_delivered_timestamp > order_estimated_delivery_date THEN 'Просрочен'
    WHEN order_delivered_timestamp <= order_estimated_delivery_date THEN 'Вовремя'
  END AS Статус_доставки
FROM Orders
WHERE order_delivered_timestamp IS NOT NULL  
  AND order_estimated_delivery_date IS NOT NULL;


-- 8. Динамика выручки по месяцам
SELECT 
  strftime('%Y-%m', o.order_purchase_timestamp) AS Месяц,
  SUM(p.payment_value) AS Выручка
FROM Orders AS o
INNER JOIN Payments AS p ON p.order_id = o.order_id
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY Месяц
ORDER BY Месяц ASC;
