server {
    listen  80;

    root {{ doc_root }};
    server_name {{ servername }};

    location / {
        try_files $uri /index.php$is_args$args;
    }

    location ~ ^/index.php(/|$) {
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param HTTPS off;
    }
}
