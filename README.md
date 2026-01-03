# GLPI-Maker

🚀 **A simple and powerful automated script to deploy GLPI very quickly and securely.**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Debian](https://img.shields.io/badge/OS-Debian-red.svg)](https://www.debian.org/)
[![GLPI](https://img.shields.io/badge/GLPI-Compatible-orange.svg)](https://glpi-project.org/)

---

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [What This Script Does](#-what-this-script-does)
- [Security Features](#-security-features)
- [Configuration Options](#-configuration-options)
- [Post-Installation](#-post-installation)
- [HTTPS Configuration](#-https-configuration)
- [Troubleshooting](#-troubleshooting)
- [Useful Commands](#-useful-commands)
- [Contributing](#-contributing)
- [Author](#-author)

---

## ✨ Features

- 🎯 **Fully automated GLPI installation** with interactive setup
- 🔒 **Enterprise-grade security** with multiple protection layers
- 🗄️ **MariaDB database** installation and configuration
- 🔐 **Automatic secure password generation** for all accounts
- 🛡️ **Multiple security modules**: ModSecurity, Fail2ban, AppArmor, UFW
- 📦 **FusionInventory plugin** optional installation
- 🌐 **SSL/TLS support** with automatic certificate generation
- ⚙️ **Apache hardening** with security headers
- 🕐 **Automated cron tasks** configuration
- 📝 **Comprehensive logging** of all credentials

---

## 📋 Prerequisites

### ⚠️ IMPORTANT WARNING

**This script is designed for a dedicated server/VM for GLPI only.**

- ❌ **DO NOT run this script on a server hosting other services or websites**
- ❌ **DO NOT run on a production server with existing applications**
- ✅ **Use a fresh, dedicated Debian/Ubuntu installation**
- ✅ **Ideal for VMs, containers, or dedicated servers**

The script will modify system configurations (Apache, firewall, security modules) that may conflict with existing services.

### System Requirements

- **Operating System**: Debian-based Linux (Debian 10+, Ubuntu 20.04+)
- **Architecture**: x86_64
- **RAM**: Minimum 2GB (4GB recommended)
- **Disk Space**: Minimum 10GB free
- **Network**: Internet connection (for downloading packages)
- **Server Type**: **Dedicated server or VM for GLPI only**

### Required Access

- Root or sudo privileges
- SSH access to the server

### Before Running

1. Ensure your system is up to date
2. Have the GLPI download URL ready (e.g., from [GLPI Releases](https://github.com/glpi-project/glpi/releases))
3. Decide on your configuration preferences (HTTPS, firewall, etc.)

---

## 🚀 Quick Start

### One-Line Installation

```bash
wget https://raw.githubusercontent.com/Gianni-Rgg/GLPI-Maker/main/GLPI-Maker.sh && sudo bash GLPI-Maker.sh
```

### Step-by-Step Installation

1. **Download the script**:
   ```bash
   wget https://raw.githubusercontent.com/Gianni-Rgg/GLPI-Maker/main/GLPI-Maker.sh
   ```

2. **Make it executable** (optional):
   ```bash
   chmod +x GLPI-Maker.sh
   ```

3. **Run the script**:
   ```bash
   sudo bash GLPI-Maker.sh
   ```

4. **Follow the interactive prompts** to configure your installation

5. **Save your passwords** from `/root/PASSWORDS.txt`

---

## 🔧 What This Script Does

### Installation & Configuration

1. **System Updates**: Updates all packages to latest versions
2. **Web Server**: Installs and configures Apache2
3. **PHP Installation**: Installs PHP with all required extensions for GLPI
4. **Database Setup** (optional): Installs and secures MariaDB
5. **GLPI Deployment**: Downloads, extracts, and configures GLPI
6. **Plugin Installation** (optional): Adds FusionInventory plugin
7. **Security Hardening**: Applies multiple security layers
8. **Service Configuration**: Sets up cron jobs and automated tasks

### PHP Extensions Installed

- mysqli, mbstring, curl, gd, simplexml
- intl, ldap, apcu, xmlrpc, cas
- zip, bz2, imap

---

## 🔒 Security Features

This script implements **enterprise-grade security** with multiple protection layers:

### 🛡️ Web Application Firewall
- **ModSecurity** (optional): WAF with custom GLPI-Agent rules
- Protects against common web attacks (XSS, SQL injection, etc.)

### 🚫 Intrusion Prevention
- **Fail2ban**: Automatic IP banning after failed login attempts
- SSH and web service protection

### 🔐 Application Isolation
- **AppArmor** (optional): Mandatory Access Control for Apache
- Restricts Apache process capabilities
- Custom profile for GLPI security

### 🧱 Network Security
- **UFW Firewall** (optional): Only necessary ports open
- Default deny incoming, allow outgoing policy
- Custom SSH port configuration

### 🔑 Password Security
- Automatic generation of 20-character random passwords
- All passwords stored securely in `/root/PASSWORDS.txt` (mode 700)
- Unique passwords for each service and user

### 🌐 HTTP Security Headers
- `X-Frame-Options: DENY` (clickjacking protection)
- `X-Content-Type-Options: nosniff` (MIME sniffing protection)
- `Content-Security-Policy` (XSS protection)
- Secure cookie settings (HttpOnly, Secure, SameSite)

### 🗄️ Database Security
- Removal of anonymous users
- Removal of test database
- Root access restricted to localhost
- Dedicated GLPI user with minimal privileges

---

## ⚙️ Configuration Options

The script will ask you to configure:

| Option | Description | Default |
|--------|-------------|---------|
| **GLPI Source** | Download from URL or use local file | - |
| **MariaDB** | Install database on this machine | - |
| **Auto Passwords** | Generate secure random passwords | - |
| **Timezone** | Server timezone configuration | - |
| **FusionInventory** | Install inventory plugin | - |
| **HTTPS/SSL** | Configure SSL with auto-generated certificates | - |
| **Firewall (UFW)** | Enable and configure firewall | - |
| **SSH Port** | Custom SSH port | 22 |
| **ModSecurity** | Web Application Firewall | - |
| **AppArmor** | Mandatory Access Control | - |

---

## 📦 Post-Installation

### Access Your GLPI Instance

**HTTP Access**:
```
http://your-server-ip/
```

**HTTPS Access** (if configured):
```
https://your-domain-name/
```

### Retrieve Generated Passwords

```bash
sudo cat /root/PASSWORDS.txt
```

**⚠️ IMPORTANT**: Save these passwords in a secure password manager and delete the file:
```bash
sudo rm /root/PASSWORDS.txt
```

### Default GLPI Users

After installation, you'll have access to these users (with generated passwords):

- **glpi** - Administrator account
- **tech** - Technician account  
- **normal** - Normal user account
- **post-only** - Post-only account

---

## 🔐 HTTPS Configuration

### Certificate Location

If you choose HTTPS configuration, the script will:

1. Create a self-signed Certificate Authority (CA)
2. Generate a signed certificate for your domain
3. Configure Apache for HTTPS

**Certificate files are located in**:
```
/etc/ssl/glpi/
```

**Certificates available in root directory**:
```
/root/rootCA.crt
/root/rootCA.pem
```

### Installing the CA Certificate

To avoid browser warnings, install `rootCA.crt` on client machines:

#### Windows
1. Double-click `rootCA.crt`
2. Click "Install Certificate"
3. Choose "Local Machine"
4. Select "Trusted Root Certification Authorities"

#### Linux
```bash
sudo cp rootCA.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

#### macOS
```bash
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain rootCA.crt
```

### Production Environments

For production, consider using **Let's Encrypt** instead of self-signed certificates:
```bash
sudo apt install certbot python3-certbot-apache
sudo certbot --apache -d your-domain.com
```

---

## 🐛 Troubleshooting

### Apache Won't Start

**Check Apache status**:
```bash
sudo systemctl status apache2
sudo apache2ctl configtest
```

**View error logs**:
```bash
sudo tail -f /var/log/apache2/error.log
```

### Firewall Blocks Access

If you can't access GLPI after installation:
```bash
# Check UFW status
sudo ufw status

# Allow HTTP/HTTPS temporarily
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### Permission Issues

Fix GLPI file permissions:
```bash
sudo chown -R www-data:www-data /var/www/glpi
sudo chmod -R 755 /var/www/glpi
```

### AppArmor Blocks Apache

Check AppArmor logs:
```bash
sudo tail -f /var/log/syslog | grep apparmor
```

Temporarily disable AppArmor profile:
```bash
sudo aa-complain /etc/apparmor.d/usr.sbin.apache2
```

---

## 💻 Useful Commands

### View Generated Passwords
```bash
sudo cat /root/PASSWORDS.txt
```

### Restart Services
```bash
sudo service apache2 restart
sudo service mariadb restart
sudo service fail2ban restart
```

### Check Service Status
```bash
sudo systemctl status apache2
sudo systemctl status mariadb
sudo systemctl status fail2ban
```

### View Apache Logs
```bash
# Error logs
sudo tail -f /var/log/apache2/error.log

# Access logs
sudo tail -f /var/log/apache2/access.log

# SSL logs (if configured)
sudo tail -f /var/log/apache2/ssl_error.log
```

### Database Access
```bash
sudo mysql -u root -p
# Or for GLPI database
sudo mysql -u glpi -p glpi
```

### Backup GLPI Database
```bash
sudo mysqldump -u root -p glpi > glpi_backup_$(date +%Y%m%d).sql
```

### Update GLPI
1. Backup database (see above)
2. Backup files: `sudo tar -czf glpi_files_backup.tar.gz /var/www/glpi`
3. Download new GLPI version
4. Follow GLPI upgrade documentation

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

- 🐛 Report bugs
- 💡 Suggest new features
- 🔧 Submit pull requests
- 📖 Improve documentation

### Reporting Issues

When reporting issues, please include:
- Your Debian/Ubuntu version
- GLPI version attempted
- Error messages or logs
- Steps to reproduce

---

## 👤 Author

**Gianni Ruggiero**

- 🔗 LinkedIn: [linkedin.com/in/Gianni-Rgg](https://www.linkedin.com/in/Gianni-Rgg)
- 📺 YouTube: [Gianni Ruggiero Channel](https://www.youtube.com/channel/UC5ixKngUySH_5rEv5ghq5KA)
- 💻 GitHub: [github.com/Gianni-Rgg](https://github.com/Gianni-Rgg)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## ⚠️ Disclaimer

**⚠️ CRITICAL: This script is designed for dedicated GLPI servers only.**

This script will:
- Modify Apache configuration files
- Configure firewall rules (UFW)
- Install and configure security modules (ModSecurity, AppArmor, Fail2ban)
- Change SSH port (if configured)
- Modify system-wide PHP settings

**DO NOT use this script on:**
- Servers hosting multiple websites or applications
- Production servers with existing services
- Shared hosting environments
- Servers you don't fully control

**Always:**
- Use a fresh, dedicated VM or server
- Test in a non-production environment first
- Backup your system before running

This script is provided "as is" without warranty. The author is not responsible for any data loss, system issues, or service disruptions.

---

## 🙏 Acknowledgments

- GLPI Project Team
- FusionInventory Team
- The open-source community

---

**Made with ❤️ for the GLPI community**

**Enjoy your GLPI installation! 🎉**
