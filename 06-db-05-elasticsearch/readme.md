# Домашнее задание к занятию 5. «Elasticsearch» - Шадрин Алексей

## Задача 1

В этом задании вы потренируетесь в:

- установке Elasticsearch,
- первоначальном конфигурировании Elasticsearch,
- запуске Elasticsearch в Docker.

Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для Elasticsearch,
- соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.

Требования к `elasticsearch.yml`:

- данные `path` должны сохраняться в `/var/lib`,
- имя ноды должно быть `netology_test`.

В ответе приведите:

- текст Dockerfile-манифеста,

```bash
FROM centos:7
RUN yum -y install sudo wget perl-Digest-SHA
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.16-linux-x86_64.tar.gz && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.16-linux-x86_64.tar.gz.sha512 && \
  shasum -a 512 -c elasticsearch-7.17.16-linux-x86_64.tar.gz.sha512 
RUN tar -xzf elasticsearch-7.17.16-linux-x86_64.tar.gz && \
  rm -r elasticsearch-7.17.16-linux-x86_64.tar.gz && rm elasticsearch-7.17.16-linux-x86_64.tar.gz.sha512 && \
  cd elasticsearch-7.17.16/ 
RUN echo "node.name: netology_test" >> /elasticsearch-7.17.16/config/elasticsearch.yml && \
  echo "path.data: /var/lib" >> /elasticsearch-7.17.16/config/elasticsearch.yml && \
  echo "network.host: 0.0.0.0" >> /elasticsearch-7.17.16/config/elasticsearch.yml
RUN useradd -MU elastic && \
  chown -R elastic:elastic elasticsearch-7.17.16 && \
  mkdir /var/lib/nodes && \
  chown -R elastic:elastic /var/lib/nodes
VOLUME ./elk_path:/var/lib
EXPOSE 9200
EXPOSE 9300
CMD ["sudo", "-u", "elastic", "/elasticsearch-7.17.16/bin/elasticsearch"]
```

- ссылку на образ в репозитории dockerhub,

[репозитарий на dockerhub](https://hub.docker.com/repository/docker/aleks9292/netology/general)

- ответ `Elasticsearch` на запрос пути `/` в json-виде.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/1.png)

Подсказки:

- возможно, вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum,
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml,
- при некоторых проблемах вам поможет Docker-директива ulimit,
- Elasticsearch в логах обычно описывает проблему и пути её решения.

Далее мы будем работать с этим экземпляром Elasticsearch.

## Задача 2

В этом задании вы научитесь:

- создавать и удалять индексы,
- изучать состояние кластера,
- обосновывать причину деградации доступности данных.

Ознакомьтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `Elasticsearch` 3 индекса в соответствии с таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |


```bash
curl -X PUT "51.250.77.59:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {  
      "number_of_shards": 1, 
      "number_of_replicas": 0 
    }
  }
}
'

curl -X PUT "51.250.77.59:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 2,  
      "number_of_replicas": 1
    }
  }
}
'

curl -X PUT "51.250.77.59:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 4,  
      "number_of_replicas": 2 
    }
  }
}
'
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/2_1.png)

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/2_2.png)

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/2_3.png)


Получите список индексов и их статусов, используя API, и **приведите в ответе** на задание.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/2_5.png)

Получите состояние кластера `Elasticsearch`, используя API.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/2_4.png)

Как вы думаете, почему часть индексов и кластер находятся в состоянии yellow?

*Кластер находится в состояние yellow, т.к. есть индексы, в этом состоянии. Индексы ind-2 и ind-3 находятся в yellow т.к. имеют unassigned реплики, которые негде размещать*

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/2_6.png)

Удалите все индексы.

**Важно**

При проектировании кластера Elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В этом задании вы научитесь:

- создавать бэкапы данных,
- восстанавливать индексы из бэкапов.

Создайте директорию `{путь до корневой директории с Elasticsearch в образе}/snapshots`.

Используя API, [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
эту директорию как `snapshot repository` c именем `netology_backup`.

```bash
curl -X PUT "51.250.77.59:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/elasticsearch-7.17.12/snapshots"
  }
}
'
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_1.png)


**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.
```bash
curl -X PUT "51.250.77.59:9200/test?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {  
      "number_of_shards": 1, 
      "number_of_replicas": 0 
    }
  }
}
'
```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_2.png)


[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `Elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_3.png)

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_4.png)

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_5.png)

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `Elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```bash
curl -X POST "51.250.77.59:9200/_snapshot/netology_backup/my_snapshot_2023.12.20/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "indices": "test",
  "rename_pattern": "(.+)",
  "rename_replacement": "restored-$1"
}
'

```

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_6.png)

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_7.png)

*Т.к. мы указали в запросе, что восстанавливаем индекс test, то могли не указывать паттерн переименования - он бы восстановился как test.*
*Если выполнять запрос на восстаноыление без передачи json - он бы попытался восстановить все индексы, в том числе системные и упал бы в ошибку* 

![](https://github.com/AleksShadrin/netology/blob/main/06-db-05-elasticsearch/files/3_8.png)

Подсказки:

- возможно, вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `Elasticsearch`.

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
