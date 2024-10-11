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

# Change: index.ts to include basic express setup
cat > index.ts <<EOL
import express from 'express';

const app = express();
const cors = require("cors");
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello World!');
});
app.listen(port, () => {
  console.log("Express running at http://localhost: ", port);
});
EOL

# Change: add basic DB setup to docker-compose.yaml file
cat > docker-compose.yaml <<EOL
version: "3.9"
services:
    postgres1:
        image: postgres:13
        environment:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: postgres
        command: -c fsync=off -c full_page_writes=off -c synchronous_commit=off -c max_connections=500
        ports:
            - 10001:5432
EOL

# Change: add prisma client code
cd prisma
touch prisma.ts
cat > prisma.ts <<EOL
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
export default prisma;
EOL

# Go back to parent directory
cd ../../
