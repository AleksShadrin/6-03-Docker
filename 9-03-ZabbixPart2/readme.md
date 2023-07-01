# Домашнее задание к занятию "`Система мониторинга Zabbix. Часть 2`" - `Шадрин Алексей`

---

### Задание 1
Создайте свой шаблон, в котором будут элементы данных, мониторящие загрузку CPU и RAM хоста.

- [ ] Прикрепите в файл README.md скриншот страницы шаблона с названием «Задание 1»

![netology-task-1](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/1.png)

 ---

### Задание 2
Добавьте в Zabbix два хоста и задайте им имена <фамилия и инициалы-1> и <фамилия и инициалы-2>. Например: ivanovii-1 и ivanovii-2.

- [ ] Результат данного задания сдавайте вместе с заданием 3
 ---

### Задание 3
Привяжите созданный шаблон к двум хостам. Также привяжите к обоим хостам шаблон Linux by Zabbix Agent.

- [ ] Прикрепите в файл README.md скриншот страницы хостов, где будут видны привязки шаблонов с названиями «Задание 2-3». Хосты должны иметь зелёный статус подключения

![netology-task-2-3](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/2.png)
![netology-task-2-3-shadrinav-01](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/3.png)
![netology-task-2-3-shadrinav-02](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/4.png)
![netology-task-2-3-latest-data](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/5.png)
 ---

### Задание 4
Создайте свой кастомный дашборд.

- [ ] Прикрепите в файл README.md скриншот дашборда с названием «Задание 4»

![netology-task-4](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/6.png)
 ---

### Задание 5* со звёздочкой
Создайте карту и расположите на ней два своих хоста.

- [ ] Прикрепите в файл README.md скриншот карты, где видно, что триггер сработал, с названием «Задание 5» 

![netology-task-5](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/7.png)

 ---

### Задание 6* со звёздочкой
Создайте UserParameter на bash и прикрепите его к созданному вами ранее шаблону. Он должен вызывать скрипт, который:
- при получении 1 будет возвращать ваши ФИО,
- при получении 2 будет возвращать текущую дату.

#### Требования к результату
- [ ] Прикрепите в файл README.md код скрипта, а также скриншот Latest data с результатом работы скрипта на bash, чтобы был виден результат работы скрипта при отправке в него 1 и 2
 
 ---

### Задание 7* со звёздочкой
Доработайте Python-скрипт из лекции, создайте для него UserParameter и прикрепите его к созданному вами ранее шаблону. 
Скрипт должен:
- при получении 1 возвращать ваши ФИО,
- при получении 2 возвращать текущую дату,
- делать всё, что делал скрипт из лекции.

- [ ] Прикрепите в файл README.md код скрипта в Git. Приложите в Git скриншот Latest data с результатом работы скрипта на Python, чтобы были видны результаты работы скрипта при отправке в него 1, 2, -ping, а также -simple_print.*
 
````
    import sys
    import os
    import re
    import datetime 

    if (sys.argv[1] == '-ping'): # Если -ping
        result=os.popen("ping -c 1 " + sys.argv[2]).read() # Делаем пинг по заданному адресу
        result=re.findall(r"time=(.*) ms", result) # Выдёргиваем из результата время
        print(result[0]) # Выводим результат в консоль
    elif (sys.argv[1] == '-simple_print'): # Если simple_print
        print(sys.argv[2]) # Выводим в консоль содержимое sys.arvg[2]
    elif (sys.argv[1] == '1'): # Если simple_print
        print('Shadrin AV') # Выводим в консоль содержимое sys.arvg[2]
    elif (sys.argv[1] == '2'): # Если simple_print
        print(datetime.datetime.now()) # Выводим в консоль содержимое sys.arvg[2]
    else: # Во всех остальных случаях
        print(f"unknown input: {sys.argv[1]}") # Выводим непонятый запрос в консоль
````

![netology-task-7](https://github.com/AleksShadrin/netology/blob/main/9-03-ZabbixPart2/9.png)

 ---

### Задание 8* со звёздочкой

Настройте автообнаружение и прикрепление к хостам созданного вами ранее шаблона.

#### Требования к результату
- [ ] Прикрепите в файл README.md скриншот правила обнаружения, а также скриншот страницы Discover, где видны оба хоста.*

 ---

### Задание 9* со звёздочкой

Доработайте скрипты Vagrant для 2-х агентов, чтобы они были готовы к автообнаружению сервером, а также имели на борту разработанные вами ранее параметры пользователей.

- [ ] Приложите в GitHub файлы Vagrantfile и zabbix-agent.sh.*