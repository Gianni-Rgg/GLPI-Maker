#!/bin/bash

clear

cd

HOMEpath="/root"

echo -e "\n\n\n-------------------------\n| Welcome to GLPI-Maker |\n-------------------------\n\nBy Gianni Ruggiero\nhttps://www.linkedin.com/in/Gianni-Rgg\nhttps://www.youtube.com/channel/UC5ixKngUySH_5rEv5ghq5KA\nhttps://github.com/Gianni-Rgg/GLPI-Maker\n\nPlease, be sure to launch this script with the command \"bash\" and not \"sh\".\n\nPlease, never put spaces in answers. You can replace them with \"-\" or \"_\".\n"

echo -e "\nDo you want to download GLPI ? (y/n)"

read rep

if [ -z $rep ];
then

    rep="y"

fi

if [ $rep = "y" ] || [ $rep = "Y" ] || [ $rep = "yes" ] || [ $rep = "Yes" ] || [ $rep = "YES" ] || [ $rep = "o" ] || [ $rep = "O" ] || [ $rep = "oui" ] || [ $rep = "Oui" ] || [ $rep = "OUI" ];
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

echo -e "\nDo you want to generate secure passwords for the database ? (y/n)"

read rep

if [ -z $rep ];
then

    rep="y"

fi

if [ $rep = "y" ] || [ $rep = "Y" ] || [ $rep = "yes" ] || [ $rep = "Yes" ] || [ $rep = "YES" ] || [ $rep = "o" ] || [ $rep = "O" ] || [ $rep = "oui" ] || [ $rep = "Oui" ] || [ $rep = "OUI" ];
then

    DbRootPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

    echo -e "\n\nThe password for the user \"root\" for the database is : $DbRootPassword" > $HOMEpath/PASSWORDS.txt

    DbUserPassword=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 20; echo)

    echo -e "\nThe password for the user \"glpi\" for the database is : $DbUserPassword\n\nPlease, delete this file after recovering the passwords.\n\n" >> $HOMEpath/PASSWORDS.txt

    chmod 700 $HOMEpath/PASSWORDS.txt

else

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

    DbRootPassword=$var1

    var1=""
    var2=""

    while [ -z $var1 ] || [ -z $var2 ] || [ $var1 != $var2 ]; do

        echo -e "\n\nPlease, enter the password for the user \"glpi\" for the database :"

        read -s -p "Password : " var1

        echo

        read -s -p "Repeat : " var2

        echo

    done

    DbUserPassword=$var1

fi

echo -e "\nList of Supported Timezones : https://www.php.net/manual/en/timezones.php"
echo -e "Please, specify the continent of the time zone where the server is (For exemple \"Europe\") :"

read Tz1

if [ ! -z $Tz1 ];
then

	echo -e "\nPlease, specify the nearest city of the time zone where the server is (For exemple \"Paris\") :"

	read Tz2

fi

echo -e "\nDo you want to install Fusion Inventory on GLPI ? (y/n)"

read rep

if [ -z $rep ];
then

    rep="y"

fi

if [ $rep = "y" ] || [ $rep = "Y" ] || [ $rep = "yes" ] || [ $rep = "Yes" ] || [ $rep = "YES" ] || [ $rep = "o" ] || [ $rep = "O" ] || [ $rep = "oui" ] || [ $rep = "Oui" ] || [ $rep = "OUI" ];
then

    AddFusionInventory="True"
    
    echo -e "\nDo you want to download Fusion Inventory ? (y/n)"

    read rep

    if [ -z $rep ];
    then

        rep="y"

    fi

    if [ $rep = "y" ] || [ $rep = "Y" ] || [ $rep = "yes" ] || [ $rep = "Yes" ] || [ $rep = "YES" ] || [ $rep = "o" ] || [ $rep = "O" ] || [ $rep = "oui" ] || [ $rep = "Oui" ] || [ $rep = "OUI" ];
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

echo -e "\nDo you want to configure SSL/TLS with a new Certification Authority (for HTTPS access) ? (y/n)\nThe script will automatically create self signed CA certificates and configure apache for this.\nIn the case where you would already have a CA, you will be able to replace the certificates in the apache ssl configuration file."

read rep

if [ -z $rep ];
then

    rep="y"

fi

if [ $rep = "y" ] || [ $rep = "Y" ] || [ $rep = "yes" ] || [ $rep = "Yes" ] || [ $rep = "YES" ] || [ $rep = "o" ] || [ $rep = "O" ] || [ $rep = "oui" ] || [ $rep = "Oui" ] || [ $rep = "OUI" ];
then

	AddHTTPS="True"

	while [ -z $HostName ];
	do

	echo -e "\nwhat will be the host name of the website ? For exemple in \"glpi.mydom.local\" : this will be \"glpi\""
	read HostName

	done

    while [ -z $DomainName ];
	do

	echo -e "\nwhat will be the domain name of the website ? For exemple in \"glpi.mydom.local\" : this will be \"mydom.local\""
	read DomainName

	done

    WebSiteName=$(echo "$HostName.$DomainName")

	while [ -z $Country ];
	do

	echo -e "\nWhat country code will be displayed on the certificate ? For example : FR (for France)"
	read Country

	done

	while [ -z $State ];
	do

	echo -e "\nWhich state will be displayed on the certificate ? For exemple : \"Ile-De-France\""
	read State

	done

	while [ -z $City ];
	do

	echo -e "\nWhich city will be displayed on the certificate ? For exemple : \"Paris\""
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


echo -e "\n---------------------------------------------------------\nUpdating the packages...\n"

apt update -y && apt upgrade -y

echo -e "\n---------------------------------------------------------\nInstalling web services...\n"

apt install apache2 php libapache2-mod-php mariadb-server -y

echo -e "\n---------------------------------------------------------\nInstalling php...\n"

apt install php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-ldap php-imap -y

echo -e "\n---------------------------------------------------------\nRemoving useless packages...\n"

apt autoremove -y

echo -e "\n---------------------------------------------------------\nConfiguring databases...\n"

mysql -u root -e "CREATE DATABASE glpi;"

mysql -u root -e "GRANT ALL PRIVILEGES ON glpi.* to 'glpi'@'localhost' IDENTIFIED BY '$DbUserPassword';"

mysql -u root -e "DROP USER IF EXISTS ''@'localhost';"

mysql -u root -e "DROP DATABASE IF EXISTS test;"

mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DbRootPassword';"

echo -e "---------------------------------------------------------\nConfiguring apache...\n"

sed -i "/DocumentRoot/a\\
\t<Directory /var/www/html>\n\
\tOptions Indexes FollowSymLinks\n\
\tAllowOverride All\n\
\tRequire all granted\n\
\t</Directory>\n" /etc/apache2/sites-available/000-default.conf

echo -e "---------------------------------------------------------\nInstallating GLPI...\n"

if [ -d "/tmp/install" ]; 
then

    rm -rf /tmp/install

fi

mkdir -p /tmp/install/GLPI-Sources

cd /tmp/install/GLPI-Sources

if [ $UseWebForGLPI = "True" ];
then

    wget $glpi_link

else

    mv $glpi_link .

fi

tar -xvzf $(ls)

rm /var/www/html/index.html

cp -r glpi/* /var/www/html/

chown -R www-data:www-data /var/www/html

echo -e "\n---------------------------------------------------------\nConfiguring php...\n"

phpv=$(ls /etc/php/)

if [ ! -z $Tz2 ];
then

	sed -i -e "s/;date.timezone =/date.timezone = $Tz1\/$Tz2/g" /etc/php/$phpv/cli/php.ini

fi

sed -i -e "s/max_execution_time = 30/max_execution_time = 600/g" /etc/php/$phpv/cli/php.ini

sed -i -e "s/file_uploads = off/file_uploads = on/g" /etc/php/$phpv/cli/php.ini

sed -i -e "s/memory_limit =.*/memory_limit = -1/g" /etc/php/$phpv/cli/php.ini

echo "* * * * * php /var/www/html/front/cron.php &>/dev/null" >> /var/spool/cron/crontabs/www-data

chown -R www-data:crontab /var/spool/cron/crontabs/www-data

if [ $AddFusionInventory = "True" ];
then

    echo -e "---------------------------------------------------------\nInstalling Fusion Inventory...\n"

    mkdir -p /tmp/install/FusionInventory-Sources

    cd /tmp/install/FusionInventory-Sources

    if [ $UseWebForFI = "True" ];
    then

        wget $fi_link

    else

        mv $fi_link .

    fi

    tar -xvf $(ls)

    cp -r fusioninventory /var/www/html/plugins/

    chown -R www-data:www-data /var/www/html/plugins

    rm /var/www/html/plugins/remove.txt

fi

addr=$(hostname -I | awk '$1=$1')

if [ $AddHTTPS = "True" ];
then

	echo -e "\n---------------------------------------------------------\nConfiguring SSL/TLS...\n"

	apt-get install libnss3-tools -y

	mkdir /etc/ssl/glpi

	cd /etc/ssl/glpi

	openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout CAroot.key -out CAroot.pem -subj "/C=$Country/ST=$State/L=$City/O=$Company/CN=$WebSiteName"

	openssl x509 -outform pem -in CAroot.pem -out CAroot.crt

	echo -e "authorityKeyIdentifier=keyid,issuer\nbasicConstraints=CA:FALSE\nkeyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment\nsubjectAltName = @alt_names\n[alt_names]\nIP.1 = $addr\nDNS.1 = $WebSiteName\nDNS.2 = $HostName" > domains.ext

	openssl req -new -nodes -newkey rsa:2048 -keyout GLPI.key -out GLPI.csr -subj "/C=$Country/ST=$State/L=$City/O=$Company/CN=$WebSiteName"

	cp GLPI.key /etc/ssl/private/

	openssl x509 -req -sha256 -days 1024 -in GLPI.csr -CA CAroot.pem -CAkey CAroot.key -CAcreateserial -extfile domains.ext -out GLPI.crt

	cp GLPI.crt /etc/ssl/certs/

	sed -i "/DocumentRoot/i\\\t\tServerName $WebSiteName" /etc/apache2/sites-available/default-ssl.conf

	sed -i -e "s/SSLCertificateFile.*/SSLCertificateFile\t\/etc\/ssl\/certs\/GLPI.crt/g" /etc/apache2/sites-available/default-ssl.conf

	sed -i -e "s/SSLCertificateKeyFile.*/SSLCertificateKeyFile\t\/etc\/ssl\/private\/GLPI.key/g" /etc/apache2/sites-available/default-ssl.conf

	sed -i "/DocumentRoot/a\\\t\t<Directory \/var\/www\/html>\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t\t<\/Directory>" /etc/apache2/sites-available/default-ssl.conf

	sed -i "/DocumentRoot/i\\\tServerName $WebSiteName\n\tRedirect \/ https:\/\/$addr\/" /etc/apache2/sites-available/000-default.conf

	echo "ServerName $WebSiteName" >> /etc/apache2/apache2.conf

	a2enmod ssl

	a2ensite default-ssl

	cp /etc/ssl/glpi/CAroot.crt $HOMEpath

	cp /etc/ssl/glpi/CAroot.pem $HOMEpath

fi

source /etc/apache2/envvars

echo -e "\n---------------------------------------------------------\nRestarting services...\n"

service cron restart

service apache2 restart

echo -e "----------------------------------------------------------------\n\nTo continue the installation, go to : http://$addr/\n"
