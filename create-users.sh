#!/bin/bash
for name in `cat info-alunos | awk -F ':' '{print $1}'` ; do
    docker exec ${name}_db mysql -uroot -pproject-sql -e "GRANT ALL PRIVILEGES ON *.* TO '${name}'@'%'; FLUSH PRIVILEGES;"
done