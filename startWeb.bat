@echo off
wsl -e bash -c "sudo service mysql start && sudo service apache2 start && cd /var/www/html && exec bash"