FROM mcr.microsoft.com/playwright:v1.33.0

COPY package.json ./
COPY yarn.lock ./
COPY .npmrc ./

RUN npm install -g yarn \
  && echo "Yarn version:" \
  && yarn --version \
  && yarn install \
  && echo "Node.js version:" \
  && node --version

COPY . ./
