# Домашнее задание к занятию «SQL. Часть 2» - Шадрин Алексей
---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина;
- город нахождения магазина;
- количество пользователей, закреплённых в этом магазине.

```sql
SELECT s.store_id, CONCAT(s2.first_name, ' ', s2.last_name) AS 'Manager', c2.city, COUNT(c3.store_id)
FROM store s
JOIN staff s2 ON s2.staff_id = s.manager_staff_id 
JOIN address a ON s.address_id = a.address_id 
JOIN city c2 ON c2.city_id = a.city_id
JOIN customer c3 ON s.store_id = c3.store_id 
GROUP BY s.store_id
HAVING COUNT(s.store_id) > 300;
```

![](https://github.com/AleksShadrin/netology/blob/main/12-04-SQL-Part2/1.png)

### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

```sql
SELECT COUNT(film_id) 
FROM film 
WHERE length > (
    SELECT AVG(length) 
    FROM film);
```

![](https://github.com/AleksShadrin/netology/blob/main/12-04-SQL-Part2/2.png)

### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

```sql
SELECT SUM(amount), MONTHNAME(payment_date), COUNT(r.rental_id) 
FROM payment AS p 
JOIN rental AS r ON r.rental_id = p.rental_id  
GROUP BY MONTHNAME(payment_date)
ORDER BY SUM(amount) DESC 
LIMIT 1
```
![](https://github.com/AleksShadrin/netology/blob/main/12-04-SQL-Part2/3.png)
