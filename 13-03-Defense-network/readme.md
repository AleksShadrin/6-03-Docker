# Домашнее задание к занятию «Защита сети» - Шадрин Алексей

### Подготовка к выполнению заданий

1. Подготовка защищаемой системы:

- установите **Suricata**,
- установите **Fail2Ban**.

2. Подготовка системы злоумышленника: установите **nmap** и **thc-hydra** либо скачайте и установите **Kali linux**.

Обе системы должны находится в одной подсети.

------

### Задание 1

Проведите разведку системы и определите, какие сетевые службы запущены на защищаемой системе:

**sudo nmap -sA 192.168.33.102**

- Результат сканирования:

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sA_res.png)

- Логи suricata fail2ban пустые


**sudo nmap -sT 192.168.33.102**

- Результат сканирования:

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sT_res.png)

- Лог suricata: 

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sT_suricata-log.png)

- Лог fail2ban пуст

**sudo nmap -sS 192.168.33.102**

- Результат сканирования:

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sS_res.png)

- Лог suricata: 

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sS_suricata-log.png)

- Лог fail2ban пуст

**sudo nmap -sV 192.168.33.102**

- Результат сканирования:

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sV_res.png)

- Лог suricata: 

![](https://github.com/AleksShadrin/netology/blob/main/13-03-Defense-network/sV_suricata-log.png)

- Лог fail2ban пуст

По желанию можете поэкспериментировать с опциями: https://nmap.org/man/ru/man-briefoptions.html.


*В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.*

------

### Задание 2

Проведите атаку на подбор пароля для службы SSH:

**hydra -L users.txt -P pass.txt < ip-адрес > ssh**

1. Настройка **hydra**: 
 
 - создайте два файла: **users.txt** и **pass.txt**;
 - в каждой строчке первого файла должны быть имена пользователей, второго — пароли. В нашем случае это могут быть случайные строки, но ради эксперимента можете добавить имя и пароль существующего пользователя.

Дополнительная информация по **hydra**: https://kali.tools/?p=1847.

2. Включение защиты SSH для Fail2Ban:

-  открыть файл /etc/fail2ban/jail.conf,
-  найти секцию **ssh**,
-  установить **enabled**  в **true**.

Дополнительная информация по **Fail2Ban**:https://putty.org.ru/articles/fail2ban-ssh.html.



*В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.*