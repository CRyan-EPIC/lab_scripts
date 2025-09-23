#!/bin/bash

# Variables
IMAGE_NAME="apache-ssl"
CONTAINER_NAME="caddy"

# Step 1: Generate Dockerfile
cat > Dockerfile <<'EOF'
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, and SSL deps
RUN apt update && \
    apt install -y nano vim sudo adduser apache2 systemctl openssl php libapache2-mod-php && \
    rm -rf /var/lib/apt/lists/*

# Add 'student' user with sudo privileges
RUN adduser --disabled-password --gecos '' student && \
    echo 'student ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    usermod -aG sudo student

# Enable SSL and PHP modules
RUN a2enmod ssl rewrite php*

# Generate TLS certificate
RUN mkdir -p /etc/apache2/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
      -keyout /etc/apache2/ssl/apache-selfsigned.key \
      -out /etc/apache2/ssl/apache-selfsigned.crt \
      -subj "/C=US/ST=Test/L=Test/O=TestOrg/OU=IT/CN=localhost"

# Enable default SSL site
RUN a2ensite default-ssl

# Redirect HTTP to HTTPS
RUN echo '<VirtualHost *:80>\n\
    ServerName localhost\n\
    Redirect permanent / https://localhost/\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Add custom index.html
RUN echo '<!DOCTYPE html> \
<html> \
<body> \
<img src="https://blog.smu.edu/itconnect/files/2018/08/Tux-Banner-1024x400-2g55u6j.png" width=50%/> \
<h2>HTTPS is better than HTTP, but with proxy’s like Burpsuite you can still grab passwords!</h2> \
<form action="/action_page.php" method="post"> \
  <label for="name">Name:</label><br> \
  <input type="text" id="name" name="name" value="Tux"><br> \
  <label for="password">Password:</label><br> \
  <input type="password" id="pwd" name="pwd"><br><br> \
  <input type="submit" value="Submit"> \
</form> \
<p>If you click the \"Submit\" button, the form-data can be recorded by Wireshark.</p> \
</body> \
</html>' > /var/www/html/index.html

# Add simple PHP handler
RUN echo '<?php \
echo "<h2>Form Submission Received</h2>"; \
echo "Name: " . htmlspecialchars($_POST["name"]) . "<br>"; \
echo "Password: " . htmlspecialchars($_POST["pwd"]) . "<br>"; \
?>' > /var/www/html/action_page.php

# Expose ports (80 for redirect, 443 for HTTPS)
EXPOSE 80 443

# Start Apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EOF

# Step 2: Build Docker image
echo "Building Docker image: $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

# Step 3: Run container
echo "Starting container: $CONTAINER_NAME on ports 80 and 443..."
docker run -it --rm -p 80:80 -p 443:443 --name $CONTAINER_NAME $IMAGE_NAME
