# Домашнее задание к занятию «6.4. Docker. Часть 2»

### Задание 1
Напишите ответ в свободной форме, не больше одного абзаца текста.

Установите Docker Compose и опишите, для чего он нужен и как может улучшить вашу жизнь.

Docker Compose нужен для управления сложными приложениями состоящими из нескольких контейнеров. 
Он упрощает процесс развертывания, тестирования, деплоя, отката. 

### Задание 2
Выполните действия и приложите текст конфига на этом этапе.

Создайте файл docker-compose.yml и внесите туда первичные настройки:

version;
services;
networks.
При выполнении задания используйте подсеть 172.22.0.0. Ваша подсеть должна называться: <ваши фамилия и инициалы>-my-netology-hw.

    version: '3.1'
    services:
    networks:  
      shadrinav-my-netology-hw:    
        driver: bridge    
        ipam:      
          config:      
          - subnet: 172.22.0.0/24

### Задание 3
Выполните действия и приложите текст конфига текущего сервиса:

Установите PostgreSQL с именем контейнера <ваши фамилия и инициалы>-netology-db.
Предсоздайте БД <ваши фамилия и инициалы>-db.
Задайте пароль пользователя postgres, как <ваши фамилия и инициалы>12!3!!
Пример названия контейнера: ivanovii-netology-db.
Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

    db:
      image: postgres:latest
      container_name: shadrinav-netology-db 
      ports: 
        - 5432:5432
      volumes:
        - ./pg_data:/var/lib/postgresql/data/pgdata  
      environment:
        POSTGRES_PASSWORD: shadrinav12!3!!
        POSTRGRES_DB: shadrinav-db
        PGDATA: /var/lib/postgresql/data/pgdata
      networks:      
        shadrinav-my-netology-hw:        
          ipv4_address: 172.22.0.2    
      restart: always

### Задание 4
Выполните действия:

Установите pgAdmin с именем контейнера <ваши фамилия и инициалы>-pgadmin.
Задайте логин администратора pgAdmin <ваши фамилия и инициалы>@ilove-netology.com и пароль на выбор.
Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.
Прокиньте на 80 порт контейнера порт 61231.
В качестве решения приложите:

текст конфига текущего сервиса;
скриншот админки pgAdmin.

    pgadmin:
      image: dpage/pgadmin4
      container_name: shadrinav-pgadmin
      environment:
        PGADMIN_DEFAULT_EMAIL: shadrinav@ilove-netology.com
        PGADMIN_DEFAULT_PASSWORD: 123
        ports:
        - "61231:80"
      networks:
        shadrinav-my-netology-hw:
          ipv4_address: 172.22.0.3
      restart: always

![](https://github.com/AleksShadrin/netology/blob/main/6-04-DockerPart2/screenshots/4.png)

### Задание 5
Выполните действия и приложите текст конфига текущего сервиса:

Установите Zabbix Server с именем контейнера <ваши фамилия и инициалы>-zabbix-netology.
Настройте его подключение к вашему СУБД.
Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

    zabbix-server:
      image: zabbix/zabbix-server-pgsql:ubuntu-6.4.0
      container_name: shadrinav-zabbix-netology
      environment:
        DB_SERVER_HOST: '172.22.0.2'
        POSTGRES_USER: postgres
        POSTGRES_PASSWORD: shadrinav12!3!!
      ports:
        - "10051:10051"
      networks:
        shadrinav-my-netology-hw:
          ipv4_address: 172.22.0.4
      restart: always 

### Задание 6
Выполните действия и приложите текст конфига текущего сервиса:

Установите Zabbix Frontend с именем контейнера <ваши фамилия и инициалы>-netology-zabbix-frontend.
Настройте его подключение к вашему СУБД.
Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

    zabbix_wgui:
      image: zabbix/zabbix-web-nginx-pgsql
      container_name: shadrinav-netology-zabbix-frontend
      environment:
        DB_SERVER_HOST: '172.18.0.2'
        POSTGRES_USER: 'postgres'
        POSTGRES_PASSWORD: shadrinav12!3!!
        ZBX_SERVER_HOST: "172.18.0.4"
      ports:
        - "80:8080"
        - "443:8443"
      networks:
        shadrinav-my-netology-hw:
          ipv4_address: 172.22.0.5
      restart: always

### Задание 7

Выполните действия.

Настройте линки, чтобы контейнеры запускались только в момент, когда запущены контейнеры, от которых они зависят.

В качестве решения приложите:

текст конфига целиком;

    version: '3.1'

    services:
    db:
        image: postgres:latest
        container_name: shadrinav-netology-db 
        ports: 
        - 5432:5432
        volumes:
        - ./pg_data:/var/lib/postgresql/data/pgdata  
        environment:
        POSTGRES_PASSWORD: shadrinav12!3!!
        POSTRGRES_DB: shadrinav-db
        PGDATA: /var/lib/postgresql/data/pgdata
        networks:      
        shadrinav-my-netology-hw:        
            ipv4_address: 172.22.0.2    
        restart: always

    pgadmin:
        image: dpage/pgadmin4
        container_name: shadrinav-pgadmin
        environment:
        PGADMIN_DEFAULT_EMAIL: shadrinav@ilove-netology.com
        PGADMIN_DEFAULT_PASSWORD: 123
        ports:
        - "61231:80"
        networks:
        shadrinav-my-netology-hw:
            ipv4_address: 172.22.0.3
        restart: always

    zabbix-server:
        image: zabbix/zabbix-server-pgsql:ubuntu-6.4.0
        container_name: shadrinav-zabbix-netology
        links:
        - db
        environment:
        DB_SERVER_HOST: '172.22.0.2'
        POSTGRES_USER: postgres
        POSTGRES_PASSWORD: shadrinav12!3!!
        ports:
        - "10051:10051"
        networks:
        shadrinav-my-netology-hw:
            ipv4_address: 172.22.0.4
        restart: always 

    zabbix_wgui:
        image: zabbix/zabbix-web-nginx-pgsql
        links:
        - db
        - zabbix-server
        container_name: shadrinav-netology-zabbix-frontend
        environment:
        DB_SERVER_HOST: '172.18.0.2'
        POSTGRES_USER: 'postgres'
        POSTGRES_PASSWORD: shadrinav12!3!!
        ZBX_SERVER_HOST: "172.18.0.4"
        ports:
        - "80:8080"
        - "443:8443"
        networks:
        shadrinav-my-netology-hw:
            ipv4_address: 172.22.0.5
        restart: always

    networks:  
    shadrinav-my-netology-hw:    
        driver: bridge    
        ipam:      
        config:      
        - subnet: 172.22.0.0/24

скриншот команды docker ps;
скриншот авторизации в админке Zabbix.

![](https://github.com/AleksShadrin/netology/blob/main/6-04-DockerPart2/screenshots/7.png)
![](https://github.com/AleksShadrin/netology/blob/main/6-04-DockerPart2/screenshots/7_1.png)

# Задание 8
Выполните действия:

Убейте все контейнеры и потом удалите их.
Приложите скриншот консоли с проделанными действиями.

![](https://github.com/AleksShadrin/netology/blob/main/6-04-DockerPart2/screenshots/8.png)
![](https://github.com/AleksShadrin/netology/blob/main/6-04-DockerPart2/screenshots/8_1.png)