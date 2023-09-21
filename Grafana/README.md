**Prerequisites**
Before you begin, make sure you have the following prerequisites:
A running Linux-based server (e.g., Ubuntu, CentOS, or Debian).
sudo or root access to the server.
An internet connection for downloading Grafana.

**Installation Steps**

**Install Grafana**
use the following commands to add the Grafana APT repository and install Grafana:

sudo apt install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt update
sudo apt install grafana

**Start and Enable Grafana**
After installation, start the Grafana service and enable it to start on boot:

sudo systemctl start grafana-server
sudo systemctl enable grafana-server

**Access Grafana Web Interface**
Grafana's web interface is available on port 3000 by default. Open a web browser and navigate to your server's IP address or hostname, followed by port 3000 (e.g., http://your-server-ip:3000).
Log in with the default credentials:
Username: admin
Password: admin
Then, change your password upon first login.

**Configure Data Sources and Dashboards**
Now that Grafana is installed, you can configure data sources and create dashboards to visualize your data. Grafana supports various data sources, including Prometheus, InfluxDB, and many others. Follow the official documentation to set up your preferred data source and create custom dashboards: Grafana Documentation

**Uninstallation Grafana**
To uninstall Grafana, you can use the following commands:

sudo systemctl stop grafana-server
sudo systemctl disable grafana-server
sudo apt remove --purge grafana
sudo apt autoremove
