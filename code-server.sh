echo ""
echo ""    
echo ""


clear

echo ""
echo ""    
echo ""
echo ""
echo ""
echo "       ####     Install Last Ver From Code Server     ######       "
echo ""
echo ""
echo ""


sudo sudo apt update && sudo apt upgrade -y

cd /
mkdir -p /odoo/code
cd /odoo/code


curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run


curl -fsSL https://code-server.dev/install.sh | sh



echo " "
echo " "
echo " "    
echo " "
echo " "
echo " "
echo "       ####     Create Service Unit For Code Server     ######       "
echo ""
echo ""
echo ""

touch /lib/systemd/system/code-server.service

cd  /lib/systemd/system

echo "[Unit]">>/lib/systemd/system/code-server.service
echo "Description=code-server">>/lib/systemd/system/code-server.service
echo "After=nginx.service">>/lib/systemd/system/code-server.service
echo "					">>/lib/systemd/system/code-server.service
echo "[Service]">>/lib/systemd/system/code-server.service
echo "Type=simple">>/lib/systemd/system/code-server.service
echo "Environment=PASSWORD=147258Sa">>/lib/systemd/system/code-server.service
echo "ExecStart=/usr/bin/code-server --bind-addr 127.0.0.1:3443 --user-data-dir /var/lib/code-server --auth password ">>/lib/systemd/system/code-server.service
echo "Restart=always ">>/lib/systemd/system/code-server.service
echo "					">>/lib/systemd/system/code-server.service
echo "[Install] ">>/lib/systemd/system/code-server.service
echo "WantedBy=multi-user.target ">>/lib/systemd/system/code-server.service




systemctl enable --now code-server


systemctl restart code-server



echo " "
echo " "
echo " "    
echo " "
echo " "
echo " "
echo "       ####     install nginx and create Config File For Code server in Nginx     ######       "
echo ""
echo ""
echo ""

apt install nginx -y

systemctl start nginx

systemctl enable --now nginx

systemctl restart nginx

rm -r -f /etc/nginx/sites-enabled/default

rm -r -f /etc/nginx/sites-available/default


touch /etc/nginx/sites-available/code-server


echo " "
echo " "
echo " "    
echo " "
echo " "
echo " "
echo "       ####     install nginx and create Config File For Code server in Nginx     ######       "
echo ""
echo ""
echo ""

cd /etc/nginx/sites-available

echo "server {">>/etc/nginx/sites-available/code-server
echo "	listen 80;">>/etc/nginx/sites-available/code-server
echo "	listen [::]:80;">>/etc/nginx/sites-available/code-server
echo "					">>/etc/nginx/sites-available/code-server
echo "	server_name code-server.localhost;">>/etc/nginx/sites-available/code-server
echo "					">>/etc/nginx/sites-available/code-server
echo "	location / {">>/etc/nginx/sites-available/code-server
echo "	  proxy_pass http://localhost:3443;">>/etc/nginx/sites-available/code-server
echo "	  proxy_set_header Host $host;">>/etc/nginx/sites-available/code-server
echo "	  proxy_set_header Upgrade $http_upgrade;">>/etc/nginx/sites-available/code-server
echo "	  proxy_set_header Connection "upgrade";">>/etc/nginx/sites-available/code-server
echo "	  proxy_set_header Accept-Encoding gzip;">>/etc/nginx/sites-available/code-server
echo "	  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;">>/etc/nginx/sites-available/code-server
echo "	  proxy_http_version 1.1;">>/etc/nginx/sites-available/code-server
echo "	}">>/etc/nginx/sites-available/code-server
echo "}">>/etc/nginx/sites-available/code-server


ln -s /etc/nginx/sites-available/code-server /etc/nginx/sites-enabled/code-server

systemctl restart nginx

systemctl restart code-server

sudo systemctl reload nginx


echo " "
echo " "
echo " "    
echo " "
echo " "
echo " "
echo "       ####     install Complete Success     ######       "
echo ""
echo ""
echo ""

cd /

rm -r -f code-server.sh


echo "    to get passWord :                    "

echo "    nano ~/.config/code-server/config.yaml  "

echo "    http:server-ip-address    "

echo "    or   "

echo "    http://your-domain    "



