FROM mysql:5.7.27

MAINTAINER 应卓 yingzhor@gmail.com

ARG VERSION

ENV \
    MYSQL_DATABASE=regioncn \
    MYSQL_USER=regioncn \
    MYSQL_PASSWORD=regioncn \
    MYSQL_RANDOM_ROOT_PASSWORD=yes \
    REGIONCNMYSQL_VERSION=$VERSION

COPY ./cnf/docker.cnf /etc/mysql/conf.d/docker.cnf

COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
