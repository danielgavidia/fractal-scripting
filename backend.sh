#!/bin/sh

# Create backend directory and navigate there
echo "Enter backend directory name:"
read backend_dir
mkdir $backend_dir
cd $backend_dir

# Initialize bun app (with default package name)
bun init -y

# Install express (with cors and types)
bun i express
bun i @types/express @types/node
bun i cors

# Install prisma
npx prisma
npx prisma init
bun i @prisma/client

# Install Docker DB
touch docker-compose.yaml

# Go back to parent directory
cd ..
