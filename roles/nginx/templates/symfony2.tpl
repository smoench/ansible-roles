server {
    listen 80;
 
    root {{ doc_root }};
    server_name {{ servername }};
 
    rewrite ^/app\.php/?(.*)$ /$1 permanent;
 
    location / {
        index app.php;
        try_files $uri @rewriteapp;
    }
 
    location @rewriteapp {
        rewrite ^(.*)$ /app.php/$1 last;
    }
 
    location ~ ^/(app|app_dev|config)\.php(/|$) {
        fastcgi_pass phpfcgi;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param  HTTPS off;
    }
}
