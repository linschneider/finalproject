# Prometheus Installation

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- A running Linux-based server (e.g., Ubuntu, CentOS, or Debian).
- `sudo` or root access to the server.
- An internet connection for downloading Prometheus.

## Installation Steps

### Install Prometheus

Use the following commands to add the Prometheus APT repository and install Prometheus:

```bash
sudo apt update
sudo apt install -y prometheus
```
## Configure Prometheus

Prometheus configuration is stored in /etc/prometheus/prometheus.yml. You can edit this file to specify your targets and scraping configurations. Be sure to consult the Prometheus documentation for detailed configuration options.

## Start and Enable Prometheus
After configuration, start the Prometheus service and enable it to start on boot:

```bash
sudo systemctl start prometheus
sudo systemctl enable prometheus
```

## Access Prometheus Web Interface
Prometheus's web interface is available on port 9090 by default. You can access it via http://localhost:9090.

## Configure Data Sources and Alerts
To fully utilize Prometheus, you will need to configure data sources (targets) and set up alerts. Prometheus can scrape metrics from various services and applications. Consult the official Prometheus documentation for more details on setting up data sources and creating alerts: Prometheus Documentation

## Uninstallation of Prometheus
To uninstall Prometheus, you can use the following commands:

```bash
sudo systemctl stop prometheus
sudo systemctl disable prometheus
sudo apt remove --purge prometheus
sudo apt autoremove
```bash
