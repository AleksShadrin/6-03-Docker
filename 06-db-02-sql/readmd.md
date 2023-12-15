# Домашнее задание к занятию 2. «SQL» - Шадрин Алексей

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.


```yml
version: '3.1'
services:
  db:
    image: postgres:12-bullseye
    volumes:
      - ./pg_data:/var/lib/postgresql/data/pgdata
      - ./pg_backup:/var/lib/postgresql/data/pgbackup
    restart: always
    environment:
      POSTGRES_PASSWORD: netology
      PGDATA: /var/lib/postgresql/data/pgdata
```

## Задача 2

В БД из задачи 1: 

- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.

Таблица orders:

- id (serial primary key);
- наименование (string);
- цена (integer).

Таблица clients:

- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);
- заказ (foreign key orders).

Приведите:

- итоговый список БД после выполнения пунктов выше;

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/1_1.png)

- описание таблиц (describe);

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/1_2.png)
![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/1_3.png)
![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/1_4.png)


- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;

```sql
SELECT table_name,grantee,privilege_type 
FROM information_schema.table_privileges
WHERE table_schema = 'public';
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/1_5.png)


- список пользователей с правами над таблицами test_db.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/1_6.png)

## Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL-синтаксис:
- вычислите количество записей для каждой таблицы.

```sql
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM clients;
```

Приведите в ответе:

    - запросы,

```sql
INSERT INTO orders (product, price) VALUES
('Шоколад','10'),
('Принтер','3000'),
('Книга','500'),
('Монитор','7000'),
('Гитара','4000');
```

```sql
INSERT INTO clients (surname, country, order_id) VALUES 
('Иванов Иван Иванович','USA', NULL),
('Петров Петр Петрович','Canada', NULL),
('Иоганн Себастьян Бах','Japan', NULL),
('Ронни Джеймс Дио','Russia', NULL),
('Ritchie Blackmore','Russia', NULL);
```

    - результаты их выполнения.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/2_1.png)
![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/2_2.png)

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения этих операций.

```sql
UPDATE clients SET order_id = (SELECT id FROM orders WHERE product = 'Книга') WHERE surname = 'Иванов Иван Иванович';
UPDATE clients SET order_id = (SELECT id FROM orders WHERE product = 'Монитор') WHERE surname = 'Петров Петр Петрович';
UPDATE clients SET order_id = (SELECT id FROM orders WHERE product = 'Гитара') WHERE surname = 'Иоганн Себастьян Бах';
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/4_1.png)

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.
 
```sql
SELECT * FROM clients WHERE order_id IS NOT NULL;
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/4_2.png)

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните, что значат полученные значения.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/5_1.png)

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

```bash
#бэкапим базу
pg_dump -U postgres test_db > /var/lib/postgresql/data/pgbackup/test_db.dump

# отключаемся от контейнера и удаляем его
sudo docker-compose down

# чистим volume pg_data, т.к. иначе старая база будет доступна
sudo rm -r pg_data

# поднимаем новый контейнер
sudo docker-compose up -d

# заходим в него
sudo  docker exec -it 375f97a6ae94 bash

# создаем новую базу, в которую будем восстанасливать
psql -U postgres
CREATE DATABASE test_db_restored;

# восстанасливаем 
pg_restore -U postgres -d test_db_restored < /var/lib/postgresql/data/pgbackup/test_db.dump
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-02-sql/files/6_1.png)