FROM node:16.13.2 AS build

WORKDIR /usr/src/RemoveBackground
ENV PATH /usr/src/RemoveBackground/node_modules/.bin:$PATH
COPY package.json ./
COPY package-lock.json ./
RUN npm ci --silent
# RUN npm install react-scripts@4.0.1 -g --silent
COPY . ./
RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /usr/src/RemoveBackground/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# more basic production env
# FROM mhart/alpine-node
# RUN yarn global add serve
# WORKDIR /app
# COPY --from=builder /app/build .
# CMD ["serve", "-p", "80", "-s", "."]