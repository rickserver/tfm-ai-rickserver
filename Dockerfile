# Etapa 1: Build
FROM node:20-alpine AS build

WORKDIR /app

# Copiar dependencias
COPY package.json package-lock.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código
COPY . .

# Construir el frontend
RUN npm run build

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiar build al servidor web
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer puerto
EXPOSE 90

# Nginx arranca automáticamente