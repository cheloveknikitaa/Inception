FROM        alpine:latest
RUN         apk update && apk upgrade
EXPOSE      443

RUN         apk add nginx openssl

ADD ./tools/conf.d /etc/nginx/conf.d
ADD ./tools/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/ssl/nginx-selfsigned.key \
    -out /etc/ssl/nginx-selfsigned.crt \
    -subj "/C=RU/ST=KAZAN/L=KAZAN/O=SCHOOL21/CN=caugusta" 

CMD         ["nginx", "-g", "daemon off;"]