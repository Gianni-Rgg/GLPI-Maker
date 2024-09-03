#!/bin/bash

clear

cd

HOMEpath="/root"

rep=""

echo -e "\n\n\n-------------------------\n| Welcome to GLPI-Maker |\n-------------------------\n\nBy Gianni Ruggiero\nhttps://www.linkedin.com/in/Gianni-Rgg\nhttps://www.youtube.com/channel/UC5ixKngUySH_5rEv5ghq5KA\nhttps://github.com/Gianni-Rgg/GLPI-Maker\n\n------------------------------------------------------------"

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to download GLPI ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    while [ -z $glpi_link ];
    do

        echo -e "\nPlease, put the url for downloading GLPI :"

        read glpi_link

    done

    UseWebForGLPI="True"

else

    while [ -z $glpi_link ];
    do

        echo -e "\nPlease, put the location of the compressed file of GLPI (put the full link with \".tgz\" at the end) :"

        read glpi_link

    done

    UseWebForGLPI="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to install MariaDB on this machine ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    InstallMariaDB="True"

    rep=""

    until [ "$rep" = "y" ] || [ "$rep" = "n" ];
    do

        echo -e "\nDo you want to generate secure passwords for the database ? (y/n)"

        read rep

    done

    if [ "$rep" = "y" ];
    then

        GenDBPass="True"

    else

        GenDBPass="False"

        var1=""
        var2=""

        while [ -z $var1 ] || [ -z $var2 ] || [ $var1 != $var2 ];
        do

            echo -e "\n\nPlease, enter the password for the user \"root\" for the database :"

            read -s -p "Password : " var1

            echo

            read -s -p "Repeat : " var2

            echo

        done

        DbRootPassword="$var1"

        var1=""
        var2=""

        while [ -z $var1 ] || [ -z $var2 ] || [ $var1 != $var2 ]; do

            echo -e "\n\nPlease, enter the password for the user \"glpi\" for the database :"

            read -s -p "Password : " var1

            echo

            read -s -p "Repeat : " var2

            echo

        done

        DbUserPassword="$var1"

    fi

else

    InstallMariaDB="False"

fi

echo -e "\nList of Supported Timezones : https://www.php.net/manual/en/timezones.php"
echo -e "Please, specify the continent of the time zone where the server is (For exemple \"Europe\") :"

read Tz1

if [ ! -z $Tz1 ];
then

        echo -e "\nPlease, specify the nearest city of the time zone where the server is (For exemple \"Paris\") :"

        read Tz2

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to install Fusion Inventory on GLPI ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    AddFusionInventory="True"

    rep=""

    until [ "$rep" = "y" ] || [ "$rep" = "n" ];
    do

        echo -e "\nDo you want to download Fusion Inventory ? (y/n)"

        read rep

    done

    if [ "$rep" = "y" ];
    then

        while [ -z $fi_link ];
        do

            echo -e "\nPlease, put the url for downloading Fusion Inventory :"

            read fi_link

        done

        UseWebForFI="True"

    else

        while [ -z $fi_link ];
        do

            echo -e "\nPlease, put the location of the compressed file of Fusion Inventory (put the full link with \".tar.bz2\" at the end) :"

            read fi_link

        done

        UseWebForFI="False"

    fi

else

    AddFusionInventory="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to configure SSL/TLS with a new Certification Authority (for HTTPS access) ? (y/n)\nThe script will automatically create a CA with signed certificate and configure apache for this.\nIn the case where you would already have a CA, you will be able to replace the certificates in the apache ssl configuration file."

    read rep

done

if [ "$rep" = "y" ];
then

        AddHTTPS="True"

        while [ -z $WebSiteName ];
        do

        echo -e "\nWhat will be the domain name of the website ? For exemple \"glpi.mydom.local\""
        read WebSiteName

        done

        HostName=$(echo "$WebSiteName" | cut -d'.' -f1)
        DomainName=$(echo "$WebSiteName" | cut -d'.' -f2-)

        while [ -z $Country ];
        do

        echo -e "\nWhat country code will be displayed on the certificate ? For example FR (for France)"
        read Country

        done

        while [ -z $State ];
        do

        echo -e "\nWhich state will be displayed on the certificate ? For exemple \"Ile-De-France\""
        read State

        done

        while [ -z $City ];
        do

        echo -e "\nWhich city will be displayed on the certificate ? For exemple \"Paris\""
        read City

        done

        while [ -z $Company ];
        do

        echo -e "\nWhich company will be displayed on the certificate ?"
        read Company

        done

else

        AddHTTPS="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to configure the firewall (ufw) ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    AddFirewall="True"

else

    AddFirewall="False"

fi

echo -e "\nWhat port do you want to use for SSH ? (Port 22 by default)"

read SSHPort

if [ -z $SSHPort ];
then

    SSHPort="22"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    echo -e "\nDo you want to configure ModSecurity ? (y/n)"

    read rep

done

if [ "$rep" = "y" ];
then

    AddModSec="True"

else

    AddModSec="False"

fi

rep=""

until [ "$rep" = "y" ] || [ "$rep" = "n" ];
do

    clear

    echo -e "\nLink for GLPI : $glpi_link\n"

    echo -e "Add MariaDB : $InstallMariaDB\n"

    if [ "$InstallMariaDB" = "True" ];
    then

        echo -e "Generate passwords for db : $GenDBPass\n"

    fi

    if [ -z $Tz1 ];
    then

        echo -e "Timezone : No timezone\n"

    else

        echo -e "Timezone : $Tz1/$Tz2\n"

    fi

    echo -e "Add Fusion Inventory : $AddFusionInventory\n"

    if [[ "$AddFusionInventory" == "True" ]];
    then

        echo -e "Link for FI : $fi_link\n"

    fi

    echo -e "Add HTTPS : $AddHTTPS\n"

    if [[ "$AddHTTPS" == "True" ]];
    then

        echo -e "Web site name : $WebSiteName\nCountry : $Country\nState : $State\nCity : $City\nCompany : $Company\n"

    fi

    echo -e "Add firewall : $AddFirewall\n"

    echo -e "SSH port : $SSHPort\n"

    echo -e "Add ModSecurity : $AddModSec\n"

    echo -e "\n\nDo you confirm ? (y/n)\n----------------------"

    read rep

done

if [ "$rep" = "n" ];
then

    exit

fi

echo -e "\n---------------------------------------------------------\nUpdating the packages...\n"

apt update -y
apt upgrade -y

echo -e "\n---------------------------------------------------------\nInstalling web services...\n"

apt install apache2 -y
apt install php -y
apt install libapache2-mod-php -y

if [ "$InstallMariaDB" = "True" ];
then

    apt install mariadb-server -y

fi

echo -e "\n---------------------------------------------------------\nInstalling php...\n"

apt install php-mysqli -y
apt install php-mbstring -y
apt install php-curl -y
apt install php-gd -y
apt install php-simplexml -y
apt install php-intl -y
apt install php-ldap -y
apt install php-apcu -y
apt install php-xmlrpc -y
apt install php-cas -y
apt install php-zip -y
apt install php-bz2 -y
apt install php-ldap -y
apt install php-imap -y

echo -e "\n---------------------------------------------------------\nConfiguring OS...\n"

apt autoremove -y

timedatectl set-timezone "$Tz1"/"$Tz2"

if [ "$InstallMariaDB" == "True" ];
then

    echo -e "\n---------------------------------------------------------\nConfiguring database...\n"

    if [[ "$GenDBPass" == "True" ]];
    then

        DbRootPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

        echo -e "\n\nThe password for the user \"root\" from the database is : $DbRootPassword" > $HOMEpath/PASSWORDS.txt

        DbUserPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

        echo -e "\nThe password for the user \"glpi\" from the database is : $DbUserPassword\n" >> $HOMEpath/PASSWORDS.txt

    fi

    mysql -u root -e "CREATE DATABASE glpi;"

    mysql -u root -e "GRANT ALL PRIVILEGES ON glpi.* to 'glpi'@'localhost' IDENTIFIED BY '$DbUserPassword';"

    mysql -u root -e "DROP USER IF EXISTS ''@'localhost';"

    mysql -u root -e "DROP DATABASE IF EXISTS test;"

    mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

    mysql -u root -e "GRANT SELECT ON \`mysql\`.\`time_zone_name\` TO 'glpi'@'localhost';"

    mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

    mysql -u root -e "FLUSH PRIVILEGES;"

    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DbRootPassword';"

fi

echo -e "---------------------------------------------------------\nConfiguring apache...\n"

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/glpi.conf

sed -i "/DocumentRoot/a\\\t<Directory \/var\/www\/glpi\/public>\n\t\t\tRequire all granted\n\t\t\tRewriteEngine On\n\t\t\tRewriteCond %{HTTP:Authorization} ^(.+)$\n\t\t\tRewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]\n\t\t\tRewriteCond %{REQUEST_FILENAME} !-f\n\t\t\tRewriteRule ^(.*)$ index.php [QSA,L]\n\t<\/Directory>\n" /etc/apache2/sites-available/glpi.conf

sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/glpi\/public/g" /etc/apache2/sites-available/glpi.conf

sed -i '/<\/Directory>/i\\t<IfModule mod_authz_core.c>\n\t\tRequire local\n\t<\/IfModule>\n\t<IfModule !mod_authz_core.c>\n\t\torder deny,allow\n\t\tdeny from all\n\t\tallow from 127.0.0.1\n\t\tallow from ::1\n\t<\/IfModule>\n\tErrorDocument 403 \"<p><b>Restricted area.<\/b><br \/>Only local access allowed.<br \/>Check your configuration or contact your administrator.<\/p>\"' /etc/apache2/sites-available/glpi.conf

sed -i "/DocumentRoot/a\\\tHeader always set X-Frame-Options DENY\n" /etc/apache2/sites-available/glpi.conf

sed -i "/DocumentRoot/a\\\tHeader always set X-Content-Type-Options nosniff\n" /etc/apache2/sites-available/glpi.conf

sed -i "/DocumentRoot/a\\\tHeader always set Content-Security-Policy \"default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://code.jquery.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; img-src 'self' data: blob: https://$WebSiteName; font-src 'self' data: https://fonts.gstatic.com; connect-src 'self'; media-src 'self'; object-src 'none'; frame-ancestors 'self';\"" /etc/apache2/sites-available/glpi.conf

a2enmod headers

a2ensite glpi

a2dissite 000-default.conf

a2enmod php*

a2enmod rewrite

echo -e "\n---------------------------------------------------------\nInstallating GLPI...\n"

tmp_install_path="/tmp/glpi_install"

if [ -d $tmp_install_path ];
then

    rm -rf "$tmp_install_path"

fi

mkdir -p "$tmp_install_path/GLPI-Sources"

if [ "$UseWebForGLPI" = "True" ];
then

    wget -P "$tmp_install_path/GLPI-Sources" "$glpi_link"

else

    mv "$glpi_link" "$tmp_install_path/GLPI-Sources"

fi

tar -xvzf "$tmp_install_path/GLPI-Sources/$(ls $tmp_install_path/GLPI-Sources | head -n 1)" -C "$tmp_install_path/GLPI-Sources"

cp -r "$tmp_install_path/GLPI-Sources/glpi" "/var/www"

echo -e "\n---------------------------------------------------------\nConfiguring php...\n"

phpv=$(ls -F /etc/php/ | grep / | head -n 1 | cut -d'/' -f1)

if [ ! -z $Tz2 ];
then

        sed -i -e "s/;date.timezone =/date.timezone = "$Tz1"\/"$Tz2"/g" /etc/php/$phpv/apache2/php.ini

	timedatectl set-timezone $Tz1/$Tz2

fi

sed -i -e "s/max_execution_time = 30/max_execution_time = 600/g" /etc/php/$phpv/apache2/php.ini

sed -i -e "s/file_uploads = off/file_uploads = on/g" /etc/php/$phpv/apache2/php.ini

sed -i -e "s/memory_limit =.*/memory_limit = -1/g" /etc/php/$phpv/apache2/php.ini

sed -i -e "s/;session.cookie_secure =/session.cookie_secure = On/g" /etc/php/$phpv/apache2/php.ini

sed -i -e "s/^session.cookie_httponly =*$/session.cookie_httponly = On/g" /etc/php/$phpv/apache2/php.ini

sed -i -e "s/^session.cookie_samesite =*$/session.cookie_samesite = Lax/g" /etc/php/$phpv/apache2/php.ini

echo "* * * * * php /var/www/glpi/front/cron.php &>/dev/null" >> /var/spool/cron/crontabs/www-data

chown www-data:crontab /var/spool/cron/crontabs/www-data

chmod 600 /var/spool/cron/crontabs/www-data

chmod 744 /var/www/glpi/front/cron.php

if [ "$AddFusionInventory" = "True" ];
then

    echo -e "---------------------------------------------------------\nInstalling Fusion Inventory...\n"

    mkdir -p "$tmp_install_path/FusionInventory-Sources"

    if [ "$UseWebForFI" = "True" ];
    then

        wget -P "$tmp_install_path/FusionInventory-Sources" "$fi_link"

    else

        mv "$fi_link" "$tmp_install_path/FusionInventory-Sources"

    fi

    tar -xvf "$tmp_install_path/FusionInventory-Sources/$(ls $tmp_install_path/FusionInventory-Sources/ | head -n 1)" -C "$tmp_install_path/FusionInventory-Sources"

    cp -r "$tmp_install_path/FusionInventory-Sources/fusioninventory" "/var/www/glpi/plugins/"

    rm "/var/www/glpi/plugins/remove.txt"

fi

addr=$(hostname -I | grep -oP '^\S+' | awk '/^[0-9]/ {print $1}')

if [ "$AddHTTPS" = "True" ];
then

        echo -e "\n---------------------------------------------------------\nConfiguring SSL/TLS...\n"

        sed -i -e "s/;session.cookie_secure =/session.cookie_secure = On/g" /etc/php/$phpv/apache2/php.ini

        sed -i -e "s/session.cookie_httponly =/session.cookie_httponly = On/g" /etc/php/$phpv/apache2/php.ini

        apt-get install libnss3-tools -y

        ssl_install_path="/etc/ssl/glpi"

        mkdir $ssl_install_path

        openssl req -x509 -nodes -new -sha256 -days 5475 -newkey rsa:2048 -keyout "$ssl_install_path/rootCA.key" -out "$ssl_install_path/rootCA.pem" -subj "/C=$Country/ST=$State/L=$City/O=$Company/CN=$Company Root CA/OU=CA"

        openssl x509 -outform pem -in "$ssl_install_path/rootCA.pem" -out "$ssl_install_path/rootCA.crt"

        echo -e "authorityKeyIdentifier=keyid,issuer\nbasicConstraints=CA:FALSE\nkeyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment\nsubjectAltName = @alt_names\n[alt_names]\nIP.1 = $addr\nDNS.1 = $WebSiteName\nDNS.2 = $HostName" > "$ssl_install_path/domains.ext"

        openssl req -new -nodes -newkey rsa:2048 -keyout "$ssl_install_path/GLPI.key" -out "$ssl_install_path/GLPI.csr" -subj "/C=$Country/ST=$State/L=$City/O=$Company/CN=$WebSiteName/OU=Web Site"

        cp "$ssl_install_path/GLPI.key" "/etc/ssl/private/"

        openssl x509 -req -sha256 -days 1825 -in "$ssl_install_path/GLPI.csr" -CA "$ssl_install_path/rootCA.pem" -CAkey "$ssl_install_path/rootCA.key" -CAcreateserial -extfile "$ssl_install_path/domains.ext" -out "$ssl_install_path/GLPI.crt"

        cp "$ssl_install_path/GLPI.crt" "/etc/ssl/certs/"

        cp "/etc/apache2/sites-available/default-ssl.conf" "/etc/apache2/sites-available/glpi-ssl.conf"

        sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/glpi\/public/g" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i "/DocumentRoot/i\\\tServerName $WebSiteName" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i -e "s/SSLCertificateFile.*/SSLCertificateFile\t\/etc\/ssl\/certs\/GLPI.crt/g" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i -e "s/SSLCertificateKeyFile.*/SSLCertificateKeyFile\t\/etc\/ssl\/private\/GLPI.key/g" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i "/DocumentRoot/a\\\t<Directory \/var\/www\/glpi\/public>\n\t\t\tRequire all granted\n\t\t\tRewriteEngine On\n\t\t\tRewriteCond %{HTTP:Authorization} ^(.+)$\n\t\t\tRewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]\n\t\t\tRewriteCond %{REQUEST_FILENAME} !-f\n\t\t\tRewriteRule ^(.*)$ index.php [QSA,L]\n\t<\/Directory>\n" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i "/DocumentRoot/a\\\tHeader always set X-Frame-Options DENY\n" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i "/DocumentRoot/a\\\tHeader always set X-Content-Type-Options nosniff\n" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i "/DocumentRoot/a\\\tHeader always set Content-Security-Policy \"default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://code.jquery.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; img-src 'self' data: blob: https://$WebSiteName; font-src 'self' data: https://fonts.gstatic.com; connect-src 'self'; media-src 'self'; object-src 'none'; frame-ancestors 'self';\"\n" /etc/apache2/sites-available/glpi-ssl.conf

        sed -i "/DocumentRoot/i\\\tServerName $WebSiteName\n\tRedirect \/ https:\/\/$WebSiteName\/" /etc/apache2/sites-available/glpi.conf

        sed -i '/<\/Directory>/i\\t<IfModule mod_authz_core.c>\n\t\tRequire local\n\t<\/IfModule>\n\t<IfModule !mod_authz_core.c>\n\t\torder deny,allow\n\t\tdeny from all\n\t\tallow from 127.0.0.1\n\t\tallow from ::1\n\t<\/IfModule>\n\tErrorDocument 403 \"<p><b>Restricted area.<\/b><br \/>Only local access allowed.<br \/>Check your configuration or contact your administrator.<\/p>\"' /etc/apache2/sites-available/glpi-ssl.conf

        sed -i '/<\/VirtualHost>/i \ \ \ \ ErrorLog ${APACHE_LOG_DIR}/ssl_error.log\n\ \ \ \ CustomLog ${APACHE_LOG_DIR}/ssl_access.log combined\n' /etc/apache2/sites-available/glpi-ssl.conf

        sed -i '/ErrorLog ${APACHE_LOG_DIR}\/error.log/d; /CustomLog ${APACHE_LOG_DIR}\/access.log combined/d' /etc/apache2/sites-available/glpi-ssl.conf

        sed -i '/<FilesMatch/,/<\/FilesMatch>/d; /<Directory \/usr\/lib\/cgi-bin/,/<\/Directory>/d' /etc/apache2/sites-available/glpi-ssl.conf

        a2enmod ssl

        a2ensite glpi-ssl

        cp "$ssl_install_path/rootCA.crt" "$HOMEpath"

        cp "$ssl_install_path/rootCA.pem" "$HOMEpath"

fi

if [ "$InstallMariaDB" = "True" ];
then

    echo -e "\n---------------------------------------------------------\nConfiguring GLPI...\n"

    php /var/www/glpi/bin/console db:install --db-name=glpi --db-user=glpi --db-password=$DbUserPassword -n

    chown -R www-data:www-data /var/www/glpi

    mv /var/www/glpi/install/install.php /var/www/glpi/install/install.php.old

    WebGLPIpassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

    echo -e "\nThe password for the user \"glpi\" from the website is : $WebGLPIpassword" >> $HOMEpath/PASSWORDS.txt

    WebPostOnlyPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

    echo -e "\nThe password for the user \"post-only\" from the website is : $WebPostOnlyPassword" >> $HOMEpath/PASSWORDS.txt

    WebTechPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

    echo -e "\nThe password for the user \"tech\" from the website is : $WebTechPassword" >> $HOMEpath/PASSWORDS.txt

    WebNormalPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

    echo -e "\nThe password for the user \"normal\" from the website is : $WebNormalPassword\n\n" >> $HOMEpath/PASSWORDS.txt

    mysql -u glpi -p"$DbUserPassword" -e "USE glpi; UPDATE glpi_users SET password=MD5('$WebGLPIpassword') WHERE name='glpi';"

    mysql -u glpi -p"$DbUserPassword" -e "USE glpi; UPDATE glpi_users SET password=MD5('$WebPostOnlyPassword') WHERE name='post-only';"

    mysql -u glpi -p"$DbUserPassword" -e "USE glpi; UPDATE glpi_users SET password=MD5('$WebTechPassword') WHERE name='tech';"

    mysql -u glpi -p"$DbUserPassword" -e "USE glpi; UPDATE glpi_users SET password=MD5('$WebNormalPassword') WHERE name='normal';"

    echo -e "\nPlease, delete this file after recovering the passwords.\n\n" >> $HOMEpath/PASSWORDS.txt

    chmod 700 $HOMEpath/PASSWORDS.txt

fi

echo -e "\n---------------------------------------------------------\nConfiguring SSH...\n"

sed -i "s/#Port 22/Port $SSHPort/g" /etc/ssh/sshd_config

if [ "$AddFirewall" = "True" ];
then

    echo -e "\n---------------------------------------------------------\nConfiguring firewall...\n"

    apt install ufw -y

    ufw allow $SSHPort/tcp

    ufw allow 80/tcp

    ufw allow 443/tcp

    ufw default allow outgoing

    ufw default deny incoming

    yes | ufw enable

fi

echo -e "\n---------------------------------------------------------\nConfiguring fail2ban...\n"

apt install fail2ban -y

cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

sed -i "s/port    = ssh/port    = $SSHPort/g" /etc/fail2ban/jail.local

if [ "$AddModSec" = "True" ];
then

    echo -e "\n---------------------------------------------------------\nConfiguring ModSecurity...\n"

    apt install libapache2-mod-security2 -y

    cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf

    echo -e "# Exclusion rules for GLPI-Agent queries\nSecRule REQUEST_HEADERS:User-Agent \"GLPI-Agent\" \"id:1000001,phase:1,pass,nolog,ctl:ruleRemoveById=920420,msg:'Rule excluded for GLPI-Agent queries'\"" >> /etc/modsecurity/modsecurity.conf

    echo -e "\nSecRule REQUEST_HEADERS:User-Agent \"GLPI-Agent\" \"id:1000002,phase:1,pass,nolog,ctl:ruleRemoveById=949110,msg:'Rule excluded for GLPI-Agent queries'\"" >> /etc/modsecurity/modsecurity.conf

    echo -e "\nSecRule REQUEST_HEADERS:User-Agent \"GLPI-Agent\" \"id:1000003,phase:1,pass,nolog,ctl:ruleRemoveById=980130,msg:'Rule excluded for GLPI-Agent queries'\"" >> /etc/modsecurity/modsecurity.conf

    sed -i "s/SecRuleEngine DetectionOnly/SecRuleEngine On/g" /etc/modsecurity/modsecurity.conf

fi

echo -e "\n---------------------------------------------------------\nConfiguring AppArmor...\n"

apt install apparmor-utils -y

apt install rsyslog -y

if [ ! -f "/etc/apparmor.d/usr.sbin.apache2" ]; then

    wget https://raw.githubusercontent.com/Gianni-Rgg/GLPI-Maker/main/config/usr.sbin.apache2 -P /etc/apparmor.d/

    aa-enforce /etc/apparmor.d/usr.sbin.apache2

    apparmor_parser -r /etc/apparmor.d/usr.sbin.apache2

else

    echo -e "\n\nThe file \"/etc/apparmor.d/usr.sbin.apache2\" already exists.\nPlease consider configuring it for GLPI and enabling AppArmor.\n\n"

fi

echo -e "\n---------------------------------------------------------\nRestarting services...\n"

service ssh restart

service cron restart

service fail2ban restart

service apache2 restart

echo -e "----------------------------------------------------------------\n\nYou can now access to : http://$WebSiteName/\n"
