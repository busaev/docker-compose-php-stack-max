 Основано на
 * https://github.com/deviantony/docker-elk
 * https://phpdocker.io/generator
 * https://github.com/jorge07/symfony-4-es-cqrs-boilerplate
 
 Service|Hostname|Port number
 ------|---------|-----------
 php-fpm|php-fpm|9000
 MySQL|mysql|3306 (default)
 PostgreSQL|postgres|5432 (default)
 pgadmin4|localhost|2084
 Memcached|memcached|11211 (default)
 Redis|redis|6379 (default)
 Elasticsearch|elasticsearch|9200 (HTTP default) / 9300 (ES transport default)
 Logstash|logstash|5000 (TCP input)
 Kibana|kibana|5601
 SMTP (Mailhog)|mailhog|1025 (default)


В контейнер php-fpm установлены:
* https://getcomposer.org
* https://nodejs.org/en/


# Настройка Xdebug и  PHPSTORM

### В docker-compose.yml:
В конфиге php-fpm нужно пробросить переменную окружения, примерно так:
    
    PHP_IDE_CONFIG: serverName=docker
    

А в PHPSTORM, в настройках проекта:

`Languages & Frameworks` > `PHP` > `Servers`:

  * Name: имя сервера должно ровняться значению  переменной `PHP_IDE_CONFIG` (`docker` в нашем случае)

Перезапускаем дебагер, все должно работать