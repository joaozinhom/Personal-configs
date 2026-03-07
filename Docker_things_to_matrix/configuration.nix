# NixOS configuration for Matrix Synapse + Cinny
# Replace YOUR_DOMAIN with your actual domain e.g. matrix.vinteum.org
# Replace YOUR_EMAIL with your email for Let's Encrypt

{ config, pkgs, ... }:

let
  domain = "YOUR_DOMAIN";       # ← change this!
  email  = "YOUR_EMAIL";        # ← change this!
in {

  # ─── Synapse ──────────────────────────────────────────────────────────────
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = domain;
      public_baseurl = "https://${domain}";

      # Listeners
      listeners = [{
        port = 8008;
        bind_addresses = [ "127.0.0.1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = false;
        }];
      }];

      # Database (PostgreSQL — much better than SQLite for production)
      database = {
        name = "psycopg2";
        args = {
          user = "matrix-synapse";
          database = "matrix-synapse";
          host = "/run/postgresql";
        };
      };

      # Registration — set to false after creating your admin account!
      enable_registration = true;
      enable_registration_without_verification = true;

      # Rate limiting — increase for your own server
      rc_message = {
        per_second = 10;
        burst_count = 50;
      };
      rc_registration.per_second = 0.1;
    };
  };

  # ─── PostgreSQL ───────────────────────────────────────────────────────────
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "matrix-synapse" ];
    ensureUsers = [{
      name = "matrix-synapse";
      ensureDBOwnership = true;
    }];
  };

  # ─── Cinny (served as static files via Nginx) ─────────────────────────────
  # Cinny doesn't have a NixOS module, we serve the Docker image via a container
  # OR you can build it from source — using Docker here for simplicity
  virtualisation.docker.enable = true;

  systemd.services.cinny = {
    description = "Cinny Matrix Web Client";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.docker}/bin/docker pull ajbura/cinny:latest";
      ExecStart = "${pkgs.docker}/bin/docker run --rm --name cinny -p 127.0.0.1:8080:80 ajbura/cinny:latest";
      ExecStop = "${pkgs.docker}/bin/docker stop cinny";
      Restart = "always";
    };
  };

  # ─── Nginx reverse proxy ──────────────────────────────────────────────────
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${domain}" = {
      enableACME = true;
      forceSSL = true;

      # Matrix client & federation API
      locations."/_matrix" = {
        proxyPass = "http://127.0.0.1:8008";
        extraConfig = "client_max_body_size 50M;";
      };
      locations."/_synapse" = {
        proxyPass = "http://127.0.0.1:8008";
      };

      # Well-known for auto-discovery
      locations."/.well-known/matrix/server" = {
        return = "200 '{\"m.server\": \"${domain}:443\"}'";
        extraConfig = "add_header Content-Type application/json;";
      };
      locations."/.well-known/matrix/client" = {
        return = "200 '{\"m.homeserver\": {\"base_url\": \"https://${domain}\"}}'";
        extraConfig = ''
          add_header Content-Type application/json;
          add_header Access-Control-Allow-Origin *;
        '';
      };

      # Cinny web client
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
      };
    };

    # Federation port
    virtualHosts."${domain}_federation" = {
      serverName = domain;
      listen = [{ port = 8448; ssl = true; }];
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8008";
      };
    };
  };

  # ─── Let's Encrypt (ACME) ─────────────────────────────────────────────────
  security.acme = {
    acceptTerms = true;
    defaults.email = email;
  };

  # ─── Firewall ─────────────────────────────────────────────────────────────
  networking.firewall.allowedTCPPorts = [ 80 443 8448 ];

  # ─── After setup: create your admin user ──────────────────────────────────
  # Run this once after deploying:
  # sudo -u matrix-synapse register_new_matrix_user \
  #   -c /etc/matrix-synapse/homeserver.yaml \
  #   -u admin -p yourpassword --admin \
  #   http://localhost:8008
}
