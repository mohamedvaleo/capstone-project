FROM ubuntu:18.04

## Step 1:
# Create a working directory
WORKDIR /app


## Step 2:
# Install apache2
RUN apt-get update -y &&\
    apt-get install --no-install-recommends apache2=2.4.29-1ubuntu4.13 -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Step 3:
# Copy index html to apache2 html folder
COPY . index.html /var/www/html/


## Step 4:
# Expose port 80
Expose 80

## Step 5:
# Run Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
