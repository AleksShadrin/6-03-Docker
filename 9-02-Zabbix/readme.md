# Домашнее задание к занятию "`Система мониторинга Zabbix`" - `Шадрин Алексей`

---

### Задание 1

Установите Zabbix Server с веб-интерфейсом.

#### Прикрепите в файл README.md скриншот авторизации в админке

![Админка zabbix](https://github.com/AleksShadrin/netology/blob/main/9-02-Zabbix/1.png)

#### Приложите в файл README.md текст использованных команд в GitHub:

    su
    apt update && apt install -y postgresql
    wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
    dpkg -i zabbix-release_6.4-1+debian11_all.deb
    apt update
    apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent
    sudo -u postgres createuser --pwprompt zabbix
    sudo -u postgres createdb -O zabbix zabbix
    zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
    nano /etc/zabbix/zabbix_server.conf  # добавляем пароль пользователя postgres
    systemctl restart zabbix-server zabbix-agent apache2
    systemctl enable zabbix-server zabbix-agent apache2

---

### Задание 2

Установите Zabbix Agent на два хоста.

#### Процесс выполнения

1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 виртмашины, одной из них может быть ваш Zabbix Server
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera
5. Проверьте что в разделе Latest Data начали появляться данные с добавленных агентов

#### Требования к результаты

1. Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу

![Hosts](https://github.com/AleksShadrin/netology/blob/main/9-02-Zabbix/2.png)

2. Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером

![Лог агента](https://github.com/AleksShadrin/netology/blob/main/9-02-Zabbix/3.png)

3. Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.

![Latest-data-zbx-agnt-01](https://github.com/AleksShadrin/netology/blob/main/9-02-Zabbix/4.png)
---
![Latest-data-zbx-srv-01](https://github.com/AleksShadrin/netology/blob/main/9-02-Zabbix/5.png)

4. Приложите в файл README.md текст использованных команд в GitHub

```
    su
    wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
    dpkg -i zabbix-release_6.4-1+debian11_all.deb
    apt update
    apt install zabbix-agent2 zabbix-agent2-plugin-\*
    nano /etc/zabbix/zabbix_agent2.conf # добавляем наш заббикс сервер
    systemctl restart zabbix-agent2
    systemctl enable zabbix-agent2
```

### Задание 3

#### Требования к результаты

Приложите в файл README.md скриншот раздела Latest Data, где видно свободное место на диске C:

![disk-c-space](https://github.com/AleksShadrin/netology/blob/main/9-02-Zabbix/6.png)
