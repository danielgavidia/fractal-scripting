#!/bin/sh

# Create backend directory and navigate there
mkdir backend
cd backend

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

# Install Firebase-Admin (auth)
bun i firebase-admin

# Return to parent dir
cd ..

# Change: index.ts to include basic express setup
rm backend/index.ts
mkdir backend/express
touch backend/express/index.ts
cat > backend/express/index.ts <<EOL
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
cat > backend/docker-compose.yaml <<EOL
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
touch backend/prisma/prisma.ts
cat > backend/prisma/prisma.ts <<EOL
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
export default prisma;
EOL
