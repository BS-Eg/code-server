sudo sudo apt update && sudo apt upgrade -y


curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run


curl -fsSL https://code-server.dev/install.sh | sh


nano /lib/systemd/system/code-server.service


[Unit]
Description=code-server
After=nginx.service

[Service]
Type=simple
Environment=PASSWORD=147258Sa
ExecStart=/usr/bin/code-server --bind-addr 127.0.0.1:3443 --user-data-dir /var/lib/code-server --auth password
Restart=always

[Install]
WantedBy=multi-user.target




systemctl enable --now code-server


systemctl start code-server


apt install nginx -y


systemctl start nginx


systemctl enable --now nginx


systemctl status nginx


rm /etc/nginx/sites-enabled/default


touch /etc/nginx/sites-available/code-server


ln -s /etc/nginx/sites-available/code-server /etc/nginx/sites-enabled/code-server


nano /etc/nginx/sites-available/code-server


server {
	listen 80;
	listen [::]:80;

	server_name code-server.localhost;

	location / {
	  proxy_pass http://localhost:3443;
	  proxy_set_header Host $host;
	  proxy_set_header Upgrade $http_upgrade;
	  proxy_set_header Connection "upgrade";
	  proxy_set_header Accept-Encoding gzip;
	  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	  proxy_http_version 1.1;
	}
}



systemctl restart nginx

systemctl restart code-server

sudo systemctl reload nginx
