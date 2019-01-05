# See Section 6, Lecture 70 for more info.
# a -v switch specifies that a volume should be created.
# the volume points to a directory that should be either bookmarked (does not contain the :),
# or mapped to a particular directory.
# Setting up volumes allows for things like hotreloading (within create-react-app)
# since changes to the local filesystem are automatically reflected in the container.
docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app [container name]

# The command below allows you to run tests within a container
docker run -it [container id] npm run test