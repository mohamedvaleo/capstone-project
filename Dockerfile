FROM ubuntu:bionic-20200311


WORKDIR /app

RUN apt-get update -y &&\
    apt-get install --no-install-recommends apache2=2.4.29-1ubuntu4.13 -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*



RUN echo "ServerName 172.17.0.2" | tee /etc/apache2/conf-available/servername.conf


EXPOSE 80 443

COPY . index.html /var/www/html/

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://172.17.0.2 || exit 1

CMD apachectl -D FOREGROUND 
