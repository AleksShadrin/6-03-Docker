# Домашнее задание к занятию «Уязвимости и атаки на информационные системы» - Шадрин Алексей

### Задание 1

Скачайте и установите виртуальную машину Metasploitable: https://sourceforge.net/projects/metasploitable/.

Это типовая ОС для экспериментов в области информационной безопасности, с которой следует начать при анализе уязвимостей.

Просканируйте эту виртуальную машину, используя **nmap**.

Попробуйте найти уязвимости, которым подвержена эта виртуальная машина.

Сами уязвимости можно поискать на сайте https://www.exploit-db.com/.

Для этого нужно в поиске ввести название сетевой службы, обнаруженной на атакуемой машине, и выбрать подходящие по версии уязвимости.

Ответьте на следующие вопросы:

- Какие сетевые службы в ней разрешены?

ftp
ssh
telnet
smtp
domain
http
rpcbind
netbios-ssn
microsoft-ds
exec
login
shell
rmiregistry
ingreslock
nfs
ccproxy-ftp
mysql
postgresql
vnc
X11
irc
ajp13

- Какие уязвимости были вами обнаружены? (список со ссылками: достаточно трёх уязвимостей)

#### vsftpd 2.3.4 - Backdoor Command Execution

*https://www.exploit-db.com/exploits/49757*

![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/8.png)

#### Apache 2.4.x - Buffer Overflow

*https://www.exploit-db.com/exploits/51193*

![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/9.png)

#### ProFTPd 1.3.5 - 'mod_copy' Remote Command Execution (2)

*https://www.exploit-db.com/exploits/49908*

### Задание 2

Проведите сканирование Metasploitable в режимах SYN, FIN, Xmas, UDP.

Запишите сеансы сканирования в Wireshark.

Ответьте на следующие вопросы:

- Чем отличаются эти режимы сканирования с точки зрения сетевого трафика?
- Как отвечает сервер?

*Приведите ответ в свободной форме.*

#### SYN режим:

*В SYN режиме nmap посылает на каждый порт пакет c установленным битом syn, и если в ответ получает ack, то отправляет rst и порт считается открытым. Если в ответ получает rst - порт считается закрытым*

![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/1.png)

#### FIN

*В FIN режиме nmap посылает на каждый порт пакет c установленным битом fin, и если если не получает ответ то порт считается открытым, либо filtered. Если в ответ получает rst - порт считается закрытым. Однако некоторые системы отправляют rst в любом случае и тогда все порты помечаются как закрытые. На скриншоте как раз этот случай*

![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/2.png)
![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/3.png)

#### Xmas 

*Xmas работает аналогично FIN, только выставляем флаг fin, urg, psh. Соотвественно резальтат сканирования тот же*

![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/5.png)
![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/4.png)

#### UDP

*UDP сканирование отправляет пустой upd заголовок на каждый порт. Если в ответ приходит ошибка о недоступности - порт закрыт. Если никакого ответа нет - порт открыт*

![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/6.png)
![](https://github.com/AleksShadrin/netology/blob/main/13-01-Attacks/7.png)