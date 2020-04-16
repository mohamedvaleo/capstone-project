FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    # Install apache
    apache2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*



RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf


EXPOSE 80 443

WORKDIR /app

COPY . index.html /var/www/html/

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost || exit 1

CMD apachectl -D FOREGROUND 
