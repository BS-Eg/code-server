echo " "
echo " "
echo " "    
echo " "
echo " "
echo " "
echo "       ####     Install Last Ver From Code Server     ######       "
echo ""
echo ""
echo ""


sudo sudo apt update && sudo apt upgrade -y


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

touch /lib/systemd/system/odoo.service

cd  /lib/systemd/system

echo "[Unit]">code-server.service
echo "Description=code-server">>code-server.service
echo "After=nginx.service">>code-server.service
echo "					">>code-server.conf
echo "[Service]">>code-server.service
echo "Type=simple">>code-server.service
echo "Environment=PASSWORD=147258Sa">>code-server.service
echo "ExecStart=/usr/bin/code-server --bind-addr 127.0.0.1:3443 --user-data-dir /var/lib/code-server --auth password ">>code-server.service
echo "Restart=always ">>code-server.service
echo "					">>code-server.conf
echo "[Install] ">>code-server.service
echo "WantedBy=multi-user.target ">>code-server.service




systemctl enable --now code-server


systemctl start code-server



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

systemctl status nginx

rm -r -f /etc/nginx/sites-enabled/default

rm -r -f /etc/nginx/sites-available/default

touch /etc/nginx/sites-available/code-server


ln -s /etc/nginx/sites-available/code-server /etc/nginx/sites-enabled/code-server


touch /etc/nginx/sites-available/code-server.conf


echo "server {">>code-server.conf
echo "	listen 80;">>code-server.conf
echo "	listen [::]:80;">>code-server.conf
echo "					">>code-server.conf
echo "	server_name code-server.localhost;">>code-server.conf
echo "					">>code-server.conf
echo "	location / {">>code-server.conf
echo "	  proxy_pass http://localhost:3443;">>code-server.conf
echo "	  proxy_set_header Host $host;">>code-server.conf
echo "	  proxy_set_header Upgrade $http_upgrade;">>code-server.conf
echo "	  proxy_set_header Connection "upgrade";">>code-server.conf
echo "	  proxy_set_header Accept-Encoding gzip;">>code-server.conf
echo "	  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;">>code-server.conf
echo "	  proxy_http_version 1.1;">>code-server.conf
echo "	}">>code-server.conf
echo "}">>code-server.conf



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
