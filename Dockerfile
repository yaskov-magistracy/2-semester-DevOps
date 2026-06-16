FROM nginx:latest

# копируем каталог настроек
COPY ./conf/ /etc/nginx/conf.d/
# копируем index.html
COPY ./index.html /usr/share/nginx/html/index.html

# открываем 80 порт
EXPOSE 80