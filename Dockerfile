FROM ubuntu:20.04

RUN apt update&&apt upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
# 建立 python3 环境
RUN apt install python3 python3-pip libmysqlclient-dev cron vim libssl-dev libcurl4-openssl-dev curl -y
RUN /etc/init.d/cron start
# 设置 python 环境变量
ENV PYTHONUNBUFFERED 1

# install oracle instant client
RUN apt-get install -y libaio1 wget unzip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
            && unzip instantclient-basiclite-linuxx64.zip \
            && rm -f instantclient-basiclite-linuxx64.zip \
            && cd instantclient_21_6 \
            && pwd \
            && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
            && echo /instantclient_21_6 > /etc/ld.so.conf.d/oracle-instantclient.conf \
            && ldconfig
