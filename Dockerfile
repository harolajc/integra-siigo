# Etapa 1: Construcción

FROM node:22-alpine AS build
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build --prod && ls -la /app/dist

# Etapa 2: Servidor web
FROM nginx:alpine
COPY --from=build /app/dist/integra-siigo /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf