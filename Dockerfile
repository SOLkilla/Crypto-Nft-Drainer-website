FROM node:hydrogen-slim

# creating an application directory
WORKDIR /usr/src/app

# This product has been developed and made publicly available by https://t.me/SoliditySorcerer
# The asterisk symbol ("*") is used to
# copy both files: package.json and package-lock.json
COPY package*.json ./

RUN npm install
# If you are building an assembly for production
# RUN npm ci --only=production

# copy the source code
COPY . .

# obfuscate the source code
RUN npm install javascript-obfuscator -g
RUN cd public/scripts/ && \
    javascript-obfuscator . --output ../scripts-obf && \
    cd .. && \
    rm -rf scripts && \
    mv scripts-obf scripts

EXPOSE 3000
CMD [ "node", "app.js" ]