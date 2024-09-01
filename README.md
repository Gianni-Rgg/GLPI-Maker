# GLPI-Maker

A simple script to deploy GLPI very quickly and easily.

You only have to prepare the url of GLPI or the full path of the compressed file.

The type of url is :
```
https://github.com/glpi-project/glpi/releases/download/9.5.6/glpi-9.5.6.tgz
```

The type of path is :
```
/home/username/glpi-9.5.6.tgz
```

Follow the instructions and everything's gonna be alright ! ;)

### This script is developed to work on Linux Debian.

## HTTPS

If you choose to configure HTTPS access with the script, the certificates will be available in your root directory.

All the files used to generate the certificates are available in :
```
/etc/ssl/glpi
```

## Commands

To get/run the script use :
```
wget https://raw.githubusercontent.com/Gianni-Rgg/GLPI-Maker/main/GLPI-Maker.sh && sudo bash GLPI-Maker.sh
```

You can display the generated passwords with :
```
sudo cat /root/PASSWORDS.txt
```

Enjoy !
