FROM node:alpine as build

WORKDIR /app

COPY . .

RUN npm install --silent
RUN npm run-script build

CMD ["npm", "start"]

