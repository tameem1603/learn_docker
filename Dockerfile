FROM node:15 AS build


#ARG PORT = 8000
#ENV PORT = $PORT
WORKDIR app
COPY src src 
COPY pacakge.json .
RUN npm install
RUN npm run build
FROM gcr.io/distroless/nodejs:15
WORKDIR app
COPY --from=build app/node_modules ./node_modules
COPY --from=build app .

EXPOSE 3000
CMD ["index.js"]
