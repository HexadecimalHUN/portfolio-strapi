# Creating multi-stage build for production
# Build stage
FROM node:18-alpine as build
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev git > /dev/null 2>&1
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Working directory for the build stage
WORKDIR /srv/app
COPY package.json yarn.lock ./
RUN npm install -g node-gyp
RUN npm config set fetch-retry-maxtimeout 600000 -g && npm install --only=production
ENV PATH /srv/app/node_modules/.bin:$PATH
COPY . .
RUN npm run build

# Final Stage
# Creating final production image
FROM node:18-alpine
RUN apk add --no-cache vips-dev
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

#Working directory for the final stage
WORKDIR /srv/app

#Copying dependencies and build files from the build stage
COPY --from=build /srv/app/node_modules ./node_modules
COPY --from=build /srv/app ./

# Set path to include node_modules
ENV PATH /srv/node_modules/.bin:$PATH

#Chane ownership to non-root user for security
RUN chown -R node:node /srv/app
USER node
EXPOSE 1337

# Start the app
CMD ["npm", "run", "start"]
