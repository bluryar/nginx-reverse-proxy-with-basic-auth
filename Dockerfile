FROM nginx:1-alpine

RUN apk add --no-cache apache2-utils

# Add Basic Auth
ENV AUTH_USERNAME admin
ENV AUTH_PASSWORD password
RUN htpasswd -bc /etc/nginx/.htpasswd $AUTH_USERNAME $AUTH_PASSWORD

COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENV CLIENT_MAX_BODY_SIZE 20M

CMD ["sh", "/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
