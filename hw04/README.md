### Создание аналитических дэшбордов

* Начиная с ДЗ№3, команда: Ижевская Александра, Хабирзянова Алия

В директории hw04:
1. `sh docker-init.sh` - поднимает два контейнера postgres_master и postgres_slave
2. `docker pull metabase/metabase:latest` - подгружаем metabase
3. `docker run -d -p 3000:3000 --name metabase metabase/metabase` - подключаемся к metabase
4. Переходим в http://localhost:3000/, вводим данные о нашей базе, создаем дэшборды: 
        Display name: postgres

        Host: host.docker.internal

        Port: 5432

        Database name: postgres

        Username: postgres
        
        Password: postgres

5. Готовые дэшборды можно увидеть на видео - dashboard.mov