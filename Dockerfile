FROM base as chefmoji-prod
LABEL author wfehrnstrom@gmail.com 

COPY --chown=chefdev:chefteam frontend/public /var/www/data

WORKDIR /app
COPY backend .

RUN rm README

COPY backend/nginx/conf/nginx.conf /etc/nginx/nginx.conf
COPY backend/nginx/proxy_params /etc/nginx/proxy_params
COPY backend/uwsgi/conf/chefmoji.ini /etc/uwsgi/chefmoji.ini
COPY backend/supervisord/conf/supervisord.conf /etc/supervisord.conf

ENV FLASK_ENV=production

EXPOSE 8080

CMD ["supervisord", "-c", "/etc/supervisord.conf"]


