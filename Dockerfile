FROM ubuntu

## Step 1:
# Create a working directory
WORKDIR /app


## Step 2:
# Install apache2
RUN apt-get update
RUN apt-get install -y apache2 && apt-get clean

## Step 3:
# Copy index html to apache2 html folder
COPY . index.html /var/www/html/


## Step 4:
# Expose port 80
Expose 80

## Step 5:
# Run Apache in the foreground
CMD apachectl -D FOREGROUND
