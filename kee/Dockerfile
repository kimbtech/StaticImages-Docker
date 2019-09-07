FROM nginx:alpine

RUN echo "server_tokens off;" > /etc/nginx/conf.d/token-off.conf

COPY ./web/ /usr/share/nginx/html/