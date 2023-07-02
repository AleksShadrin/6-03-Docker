# Домашнее задание к занятию 10.1 «Keepalived/vrrp» - «Шадрин Алексей»

---

### Задание 1

Разверните топологию из лекции и выполните установку и настройку сервиса Keepalived. 

*В качестве решения предоставьте:*   
*- рабочую конфигурацию обеих нод, оформленную как блок кода в вашем md-файле;*   

### нода1
```
vrrp_instance test {
  state MASTER
  interface eth3
  virtual_router_id 51
  priority 255
  advert_int 4
  authentication {
    auth_type PASS
    auth_pass 12345
  }
  unicast_peer {
    192.168.1.22
  }
  virtual_ipaddress {
    192.168.1.100/24  dev eth3  label test:vip
  }
}
```

### нода2
```
vrrp_instance test {
  state BACKUP
  interface eth3
  virtual_router_id 51
  priority 254
  advert_int 4
  authentication {
    auth_type PASS
    auth_pass 12345
  }
  unicast_peer {
    192.168.1.21
  }
  virtual_ipaddress {
    192.168.1.100/24  dev eth3  label test:vip
  }
}
```

*- скриншоты статуса сервисов, на которых видно, что одна нода перешла в MASTER, а вторая в BACKUP state.* 

### нода1
![node1](https://github.com/AleksShadrin/netology/blob/main/10-01-Keepalived/1.png)
### нода2
![node2](https://github.com/AleksShadrin/netology/blob/main/10-01-Keepalived/2.png)