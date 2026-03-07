# Matrix Synapse + Cinny — Self-Hosting Setup
> Replace YOUR_DOMAIN and YOUR_EMAIL in the configs before running anything.

---

## Option A — Docker Compose (works on any Linux)

### 1. Install Docker & Docker Compose
```bash
# Ubuntu/Debian
sudo apt install docker.io docker-compose-plugin -y
sudo systemctl enable --now docker

# Add your user to docker group
sudo usermod -aG docker $USER && newgrp docker
```

### 2. Set up folder structure
```bash
mkdir -p ~/matrix/{synapse-data,postgres-data,nginx/conf.d,nginx/certbot/conf,nginx/certbot/www}
cd ~/matrix
```

### 3. Generate Synapse config
```bash
docker run -it --rm \
  -v ~/matrix/synapse-data:/data \
  -e SYNAPSE_SERVER_NAME=YOUR_DOMAIN \
  -e SYNAPSE_REPORT_STATS=no \
  matrixdotorg/synapse:latest generate
```

### 4. Edit synapse-data/homeserver.yaml
Change the database section to use PostgreSQL:
```yaml
database:
  name: psycopg2
  args:
    user: synapse
    password: changeme123
    database: synapse
    host: db
    cp_min: 5
    cp_max: 10

enable_registration: true
enable_registration_without_verification: true
```

### 5. Copy config files
```bash
# Copy docker-compose.yml to ~/matrix/
# Copy nginx/conf.d/matrix.conf to ~/matrix/nginx/conf.d/
# Edit both files replacing YOUR_DOMAIN
```

### 6. Get TLS certificate (do this before starting nginx)
```bash
# Start everything except nginx first
docker compose up -d synapse db cinny

# Get certificate
docker compose run certbot certonly --webroot \
  -w /var/www/certbot \
  -d YOUR_DOMAIN \
  --email YOUR_EMAIL \
  --agree-tos --no-eff-email

# Now start nginx
docker compose up -d nginx
```

### 7. Create admin user
```bash
docker exec -it synapse register_new_matrix_user \
  -c /data/homeserver.yaml \
  -u admin -p yourpassword --admin \
  http://localhost:8008
```

### 8. Disable open registration (after creating your account!)
In `synapse-data/homeserver.yaml`, set:
```yaml
enable_registration: false
```
Then restart: `docker compose restart synapse`

---

## Option B — NixOS Flake (if your server runs NixOS)

### 1. Copy files to your server
```bash
scp flake.nix configuration.nix user@YOUR_SERVER:/etc/nixos/
```

### 2. Edit the config
```bash
# On the server, edit /etc/nixos/configuration.nix
# Replace YOUR_DOMAIN and YOUR_EMAIL
nano /etc/nixos/configuration.nix
```

### 3. Enable flakes (if not already enabled)
In `/etc/nixos/configuration.nix` add:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

### 4. Deploy
```bash
sudo nixos-rebuild switch --flake /etc/nixos#matrix-server
```

### 5. Create admin user
```bash
sudo -u matrix-synapse register_new_matrix_user \
  -c /etc/matrix-synapse/homeserver.yaml \
  -u admin -p yourpassword --admin \
  http://localhost:8008
```

---

## Router port forwarding (required for both options!)
Forward these ports to your server's local IP:
| Port | Protocol | Service              |
|------|----------|----------------------|
| 80   | TCP      | HTTP / Let's Encrypt |
| 443  | TCP      | HTTPS                |
| 8448 | TCP      | Matrix Federation    |

---

## Checklist before going public
- [ ] Domain DNS A record pointing to your home IP
- [ ] Router ports 80, 443, 8448 forwarded to server
- [ ] TLS certificate obtained
- [ ] `enable_registration: false` set after creating accounts
- [ ] Test federation: https://federationtester.matrix.org
- [ ] Test client discovery: https://federationtester.matrix.org/api/report?server_name=YOUR_DOMAIN
