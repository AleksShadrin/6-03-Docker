# Домашнее задание к занятию «7.2. Ansible.Часть 2»

### Задание 1

**Выполните действия, приложите файлы с плейбуками и вывод выполнения.**

Напишите три плейбука. При написании рекомендуем использовать текстовый редактор с подсветкой синтаксиса YAML.

Плейбуки должны: 

1. Скачать какой-либо архив, создать папку для распаковки и распаковать скаченный архив. Например, можете использовать [официальный сайт](https://kafka.apache.org/downloads) и зеркало Apache Kafka. При этом можно скачать как исходный код, так и бинарные файлы, запакованные в архив — в нашем задании не принципиально.

![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/1.1.png)
![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/1.01.png)

2. Установить пакет tuned из стандартного репозитория вашей ОС. Запустить его, как демон — конфигурационный файл systemd появится автоматически при установке. Добавить tuned в автозагрузку.

![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/1.2.png)
![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/1.02.png)

3. Изменить приветствие системы (motd) при входе на любое другое. Пожалуйста, в этом задании используйте переменную для задания приветствия. Переменную можно задавать любым удобным способом.

![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/1.3.png)
![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/1.03.png)

### [Код плейбука](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/playbook.yaml)


### Задание 2

**Выполните действия, приложите файлы с модифицированным плейбуком и вывод выполнения.** 

Модифицируйте плейбук из пункта 3, задания 1. В качестве приветствия он должен установить IP-адрес и hostname управляемого хоста, пожелание хорошего дня системному администратору. 

    - name: Play 3
      hosts: servers
      become: yes
      tasks:
        - name: backup motd
          copy:
            src: /etc/motd
            dest: ~/
            remote_src: yes
            backup: yes
        - name: delete motd
          file:
            path: /etc/motd
            state: absent
        - name: new motd
          blockinfile:
            path: /etc/motd
            create: true
            block: "ipv4_address: {{ ansible_all_ipv4_addresses[1] }}\n hostname: {{ ansible_hostname  }}\n  Have a nice day!"
            mode: '644'
    tags: play3


![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/2.png)



### Задание 3

**Выполните действия, приложите архив с ролью и вывод выполнения.**

Ознакомьтесь со статьей [bashsible](https://habr.com/ru/post/494738/), сделайте соответствующие выводы и не используйте модули **shell** или **command** при выполнении задания.

Создайте плейбук, который будет включать в себя одну, созданную вами роль. Роль должна:

1. Установить веб-сервер Apache на управляемые хосты.
2. Сконфигурировать файл index.html c выводом характеристик для каждого компьютера. Необходимо включить CPU, RAM, величину первого HDD, IP-адрес. Используйте [Ansible facts](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html) и [jinja2-template](https://linuxways.net/centos/how-to-use-the-jinja2-template-in-ansible/)
3. Открыть порт 80, если необходимо, запустить сервер и добавить его в автозагрузку.
4. Сделать проверку доступности веб-сайта (ответ 200, модуль uri).

### [Код роли](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/apache)
### [Код плейбука](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/install_apache_playbook.yaml)
![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/3.1.png)
![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/3.2.png)
![](https://github.com/AleksShadrin/netology/blob/main/7-02-AnsiblePart2/3.3.png)