FROM openresty/openresty:1.21.4.2-0-alpine-fat

RUN apk update && apk add ca-certificates openssl
RUN update-ca-certificates

RUN /usr/local/openresty/luajit/bin/luarocks install lunajson
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http

COPY mime.types /etc/nginx/mime.types
COPY mime.types /opt/nginx/mime.types
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

COPY start.sh /bin/start.sh
ENTRYPOINT ["/bin/start.sh"]