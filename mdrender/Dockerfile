FROM leakypixel/node-alpine-git
WORKDIR /app
RUN git clone https://git.lpapi.io/leakypixel/mdrender
WORKDIR /app/mdrender
RUN npm i
ENTRYPOINT ["npm", "run", "watch"]
