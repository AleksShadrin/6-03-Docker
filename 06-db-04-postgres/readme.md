# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД - `\l[+]`
- подключения к БД - `\c [db_name]`
- вывода списка таблиц - `\dt[+]`
- вывода описания содержимого таблиц `\d [table_name]`
- выхода из psql - `\q`

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

```sql
SELECT attname FROM pg_stats WHERE tablename = 'orders' ORDER BY avg_width DESC LIMIT 1;
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-04-postgres/files/2_1.png)

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

```sql
BEGIN;

CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);

SAVEPOINT created_new_tables;

INSERT INTO orders_1 SELECT * FROM orders WHERE price > 499;
DELETE FROM only orders WHERE price > 499;
INSERT INTO orders_2 SELECT * FROM orders WHERE price <= 499;
DELETE FROM only orders WHERE price <= 499;

COMMIT;
```

Результат выполнения: 

![](https://github.com/AleksShadrin/netology/blob/main/06-db-04-postgres/files/3_1.png)

Изначальная таблица при этом пуста: 

![](https://github.com/AleksShadrin/netology/blob/main/06-db-04-postgres/files/3_2.png)


Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Да, можно было изначально создать партицированную таблицу, вот пример транзакции с созданием такой таблицы и копированием данных из прошлой

```sql
BEGIN;

CREATE TABLE orders_copy ( 
    ordr_id serial not null,
    ordr_title varchar(100) not null,
    ordr_price smallint not null
 ) PARTITION BY RANGE (ordr_price);

CREATE TABLE orders_copy_1 PARTITION OF orders_copy FOR VALUES FROM ('0') TO ('498');
CREATE TABLE orders_copy_2 PARTITION OF orders_copy FOR VALUES FROM ('499') TO ('32767'); --ограничение 32767 возникло из-за выбранного типа данных smallint
CREATE TABLE orders_copy_default PARTITION OF orders_copy DEFAULT; -- таблица по умолчанию для значений, которые не попали в диапазоны партиций. 

SAVEPOINT created_new_tables;

INSERT into orders_copy (ordr_id, ordr_title, ordr_price) SELECT * from orders; -- копируем в нашу новую таблицу данные из старой
INSERT into orders_copy (ordr_title, ordr_price) VALUES ('super_mega_black_friday_sale', -9999); -- проверяем куда попадет значение не из диапазона


COMMIT;
```
Список таблиц до выполнения тразакции: 

![](https://github.com/AleksShadrin/netology/blob/main/06-db-04-postgres/files/3_3.png)

Список таблиц после выполнения транзакции (видно, что в самой партицированной таблице нет данных - все данные хранятся в ее партициях. Таблица orders_copy нужна только для доступа к своим партициям)

![](https://github.com/AleksShadrin/netology/blob/main/06-db-04-postgres/files/3_4.png)





## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```bash
pg_dump -U postgres test_database > /var/lib/postgresql/data/pgbackup/test_db.sql
```


Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

Добавил бы UNIQUE в описание столбца, ытбоы получилось: 

```sql
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE NOT NULL,
    price integer DEFAULT 0
);
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---


