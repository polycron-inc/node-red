# syntax=docker/dockerfile:1.4

FROM node:alpine3.22 AS build

WORKDIR /usr/src/app

RUN apk add --no-cache git python3 make g++

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM node:alpine3.22 AS runtime
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
CMD ["npm", "start"]
