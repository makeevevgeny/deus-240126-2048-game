FROM node:18-alpine AS first

WORKDIR /usr/src/app

COPY . . 
RUN npm install && npm run build

FROM nginx:1.25.2-alpine 
COPY --from=first /usr/src/app/dist /var/www/myapp
COPY --from=first /usr/src/app/default.conf /etc/nginx/conf.d/
EXPOSE 80

CMD [ "nginx", "-g", "daemon off;"]

