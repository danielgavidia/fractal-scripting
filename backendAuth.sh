#!/bin/sh

# Create prisma model for users
cat > backend/prisma/schema.prisma <<EOL
generator client {
    provider = "prisma-client-js"
}

datasource db {
    provider  = "postgresql"
    url       = env("DATABASE_URL")
}

model User {
    // defaults
    id        String   @id @default(uuid()) // or cuid
    createdAt DateTime @default(now())
    updatedAt DateTime @updatedAt

    // fields
    firebaseId String @unique @default("")
    email      String @default("")

    // relationships
}
EOL

# Create prisma auth utils
touch backend/prisma/utilsAuth.ts
cat > backend/prisma/utilsAuth.ts <<EOL
import prisma from "./prisma";
// Login
export const getUserLogin = async (firebaseId: string, email: string) => {
    const user = await prisma.user.findUnique({
        where: {
            firebaseId: firebaseId,
        },
    });
    if (!user) {
        const userNew = await prisma.user.create({
            data: {
                firebaseId: firebaseId,
                email: email,
            },
        });
        return userNew;
    }
    return user;
};
// Signup
export const getUserSignup = async (firebaseId: string, email: string) => {
    const userNew = await prisma.user.create({
        data: {
            firebaseId: firebaseId,
            email: email,
        },
    });
    return userNew;
};
EOL

# Create firebase express middleware file
touch backend/express/middleware.ts
FILE_URL="https://raw.githubusercontent.com/danielgavidia/fractal-favorites/refs/heads/main/backend/express/middleware.ts"
curl -o backend/express/middleware.ts "$FILE_URL"

# Add base auth, login, and sign up routes in Express
cat >> backend/express/index.ts <<EOL

import { verifyFirebaseToken } from "./middleware";
import { getUserLogin, getUserSignup } from "../prisma/utilsAuth";

app.post("/authenticate", verifyFirebaseToken, (req, res) => {
    const firebaseId = req.body.firebaseId;
    res.status(200).json({ firebaseId: firebaseId });
});

app.post("/user/login", verifyFirebaseToken, async (req, res) => {
    const { firebaseId, email } = req.body;
    const user = await getUserLogin(firebaseId, email);
    res.status(200).json({ user: user });
});

app.post("/user/signup", verifyFirebaseToken, async (req, res) => {
    const { firebaseId, email } = req.body;
    const user = await getUserSignup(firebaseId, email);
    res.status(200).json({ user: user });
});
EOL


