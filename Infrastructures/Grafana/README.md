# Grafana Installation

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- A running Linux-based server (e.g., Ubuntu, CentOS, or Debian).
- `sudo` or root access to the server.
- An internet connection for downloading Grafana.

## Installation Steps

### Install Grafana

Use the following commands to add the Grafana APT repository and install Grafana:

```bash
sudo apt install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt update
sudo apt install grafana
