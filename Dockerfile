FROM node:14
# Install dependencies
RUN apt-get update && apt-get install -y wget gnupg ca-certificates git
RUN apt-get update && apt-get install -y \
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb \
    x11-xserver-utils

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . /app
EXPOSE 8080
RUN npm run build
CMD ["npm","start"]

