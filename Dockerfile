# 2-phase Dockerfile: builder phase (alpine) and run phase (nginx)
# this should build the app and output it to the app/build/ folder 
# to be used by phase 2
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# by specifying a new FROM, it implicitly says the previous phase is done
FROM nginx

# Need to explicitly expose port 80.
# On host machine, this command does nothing additional
# but when deployed to AWS, Elasticbeanstalk explicitly looks for this 
# EXPOSE instruction to determine which ports get exposed.
EXPOSE 80

# Refer to https://hub.docker.com/_/nginx under the "Hosting some simple static content"
# section, which defines which folder is used by the nginx image for hosting static content
COPY --from=builder /app/build /usr/share/nginx/html
# Also note: the default CMD of the nginx message starts up nginx, so we don't
# have to specify it here.

# Note: to run this image, we will still need to open up some ports for nginx