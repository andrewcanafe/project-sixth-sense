FROM base as chefmoji
LABEL author wfehrnstrom@gmail.com 

COPY --chown=chefdev:chefteam frontend/public /var/www/chefmoji

WORKDIR /app
COPY backend .

RUN rm README

COPY backend/nginx/conf/nginx.dev.conf /etc/nginx/nginx.conf
COPY backend/nginx/proxy_params /etc/nginx/proxy_params
COPY backend/uwsgi/conf/chefmoji.ini /etc/uwsgi/chefmoji.ini
COPY backend/supervisord/conf/supervisord.conf /etc/supervisord.conf

RUN chown -R chefdev:chefteam /app /tmp /etc/nginx /etc/uwsgi /var/tmp/nginx /var/lib/nginx /var/log/nginx /var/run/nginx.pid 
RUN chmod -R ug=rwx /etc/nginx /etc/uwsgi /var/tmp/nginx /var/lib/nginx 
RUN chmod -R 755 /var/log/nginx /var/run/nginx.pid
RUN chmod ugoa=r /etc/supervisord.conf /etc/nginx/nginx.conf /etc/uwsgi/chefmoji.ini
RUN chmod -R ug+rwx /app

ENV FLASK_ENV=development

EXPOSE 8080

CMD ["supervisord", "-c", "/etc/supervisord.conf"]


