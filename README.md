# 🐋 Inception

> A deep dive into system administration, virtualization, and containerized infrastructure.

## 💡 About the Project
This project involves setting up a small-scale, multi-service infrastructure using Docker and Docker Compose. The strict constraint of the project is that all services must be built from scratch using custom Dockerfiles (based on Debian Oldstable) without relying on pre-configured, ready-made images from Docker Hub (like the official `nginx` or `mariadb` images).

## 🚀 Features
* **Custom Containers:** Services are built entirely from a bare `debian:oldstable` base image.
* **Nginx Web Server:** Configured as the sole entry point to the infrastructure, strictly handling TLSv1.2/TLSv1.3 secure connections (HTTPS on port 443).
* **WordPress & PHP-FPM:** Installed and configured automatically upon container startup using `wp-cli`.
* **MariaDB Database:** Secured and initialized automatically to serve the WordPress site.
* **Internal Networking:** Services communicate securely over a dedicated internal Docker network (`inception`), isolating the database from direct external access.
* **Persistent Volumes:** Data (WordPress files and MariaDB databases) persists across container restarts using heavily defined Docker volumes mapped to local host directories.

## 🛠️ Tech Stack & Dependencies
* **Virtualization:** Docker, Docker Compose
* **OS Base:** Debian (Oldstable)
* **Services:** Nginx, MariaDB, WordPress, PHP-FPM (8.2)
* **Scripting:** Bash (for automated container initialization and `wp-cli` setup)

## ⚙️ Installation & Usage

### Prerequisites
* Docker & Docker Compose
* Make
* Root/Sudo privileges (for volume directory creation and `/etc/hosts` modification)

### Setup
Before running the project, you must set up your environment variables and local domain.

1. **Environment Variables:** Create a `.env` file in the `srcs/` directory containing your credentials:
```env
DOMAIN_NAME=msassi.42.fr
DB_NAME=wordpress_db
DB_USER=wp_user
DB_PASSWORD=your_db_password
WP_TITLE=Inception
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=admin@example.com
```

2. **Local Domain Mapping:** Add your domain to your `/etc/hosts` file:
```bash
sudo nano /etc/hosts
# Add the following line:
127.0.0.1 msassi.42.fr
```

### Compilation & Execution
Clone the repository and spin up the infrastructure using the provided Makefile:

```bash
git clone https://github.com/SASSI42/inception.git inception
cd inception
make up
```

### Accessing the Site
Once the containers are built and running, open your web browser and navigate to:
```text
https://msassi.42.fr
```
*(Note: Your browser will display a security warning because the SSL certificate is self-signed. Proceed past the warning to view the site).*

### Managing the Infrastructure
* `make down`: Stops and removes the containers and network.
* `make clean`: Stops containers and prunes the Docker system.
* `make fclean`: Removes containers, images, volumes, and permanently deletes the local data directories (`/home/msassi/data/`).

## 🧠 Architecture & Implementation Details

The architecture follows a strict microservices approach:

1. **Nginx:** Exposes port 443. It holds the self-signed SSL certificates generated via OpenSSL during the build process. It proxies PHP requests to the WordPress container via FastCGI on port 9000.
2. **WordPress:** Does not expose any ports to the host machine. It runs `php-fpm` and communicates with the database. On initialization, a bash script (`configure_wp.sh`) uses `wp-cli` to download the core files, configure the database connection, and set up the admin and regular users dynamically.
3. **MariaDB:** Does not expose any ports to the host machine. The initialization script (`init_db.sh`) starts the daemon, creates the database, grants user privileges, and securely restarts the server bound to `0.0.0.0` for internal network communication.

## 👨‍💻 Author
* [Mohammed Sassi](https://github.com/SASSI42)
