FROM node:22-alpine
# Line below added post security scan
RUN apk update && apk upgrade 
WORKDIR /app
COPY package*.json ./
# Added upgrade post security scan
RUN npm install -g npm@latest
COPY . .
EXPOSE 3000
USER node
CMD ["node", "src/index.js"]