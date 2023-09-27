# MongoDB Installation

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- A running Linux-based server (e.g., Ubuntu, CentOS, or Debian).
- `sudo` or root access to the server.
- An internet connection for downloading MongoDB.

## Installation Steps

### Add MongoDB Repository

Use the following commands to add the MongoDB repository and import the GPG key:

```bash
sudo apt update
sudo apt install -y gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
```

## Install MongoDB
Now, you can install MongoDB using the following commands:

```bash
sudo apt update
sudo apt install -y mongodb-org
```

## Start and Enable MongoDB
After installation, start the MongoDB service and enable it to start on boot:

```bash
sudo systemctl start mongod
sudo systemctl enable mongod
```

## Access MongoDB
MongoDB should now be running. You can access it using the MongoDB shell:
```bash
mongo
```

This will open a MongoDB shell where you can interact with the database.

##Configure MongoDB

By default, MongoDB should be accessible on port 27017. Ensure your firewall and security settings are configured to meet your needs. MongoDB provides extensive documentation for configuration options: MongoDB Configuration

## Uninstallation of MongoDB
To uninstall MongoDB, you can use the following commands:

```bash
sudo systemctl stop mongod
sudo systemctl disable mongod
sudo apt remove --purge mongodb-org*
sudo apt autoremove
```
