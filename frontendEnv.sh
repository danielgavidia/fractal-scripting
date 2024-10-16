#!/bin/sh
printf "\e[1;34mENVIRONMENT VARIABLES, FRONTEND:\e[0m\n"

# DB: VITE_EXPRESS_BASE_URL
printf "\e[34mVITE_EXPRESS_BASE_URL:\e[0m\n"
read VITE_EXPRESS_BASE_URL

# DB: VITE_API_KEY
printf "\e[34mVITE_FIREBASE_API_KEY:\e[0m\n"
read VITE_FIREBASE_API_KEY

# DB: VITE_AUTH_DOMAIN
printf "\e[34mVITE_FIREBASE_AUTH_DOMAIN:\e[0m\n"
read VITE_FIREBASE_AUTH_DOMAIN

# DB: VITE_PROJECT_ID
printf "\e[34mVITE_FIREBASE_PROJECT_ID:\e[0m\n"
read VITE_FIREBASE_PROJECT_ID

# DB: VITE_STORAGE_BUCKET
printf "\e[34mVITE_FIREBASE_STORAGE_BUCKET:\e[0m\n"
read VITE_FIREBASE_STORAGE_BUCKET

# DB: VITE_MESSAGING_SENDER_ID
printf "\e[34mVITE_FIREBASE_MESSAGING_SENDER_ID:\e[0m\n"
read VITE_FIREBASE_MESSAGING_SENDER_ID

# DB: VITE_APP_ID
printf "\e[34mVITE_FIREBASE_APP_ID:\e[0m\n"
read VITE_FIREBASE_APP_ID

# DB: VITE_MEASUREMENT_ID
printf "\e[34mVITE_FIREBASE_MEASUREMENT_ID:\e[0m\n"
read VITE_FIREBASE_MEASUREMENT_ID

# Override env file
cat > frontend/.env <<EOL
# Express
VITE_EXPRESS_BASE_URL="$VITE_EXPRESS_BASE_URL"

# Firebase authentication
VITE_FIREBASE_API_KEY="$VITE_FIREBASE_API_KEY"
VITE_FIREBASE_AUTH_DOMAIN="$VITE_FIREBASE_AUTH_DOMAIN"
VITE_FIREBASE_PROJECT_ID="$VITE_FIREBASE_PROJECT_ID"
VITE_FIREBASE_STORAGE_BUCKET="$VITE_FIREBASE_STORAGE_BUCKET"
VITE_FIREBASE_MESSAGING_SENDER_ID="$VITE_FIREBASE_MESSAGING_SENDER_ID"
VITE_FIREBASE_APP_ID="$VITE_FIREBASE_APP_ID"
VITE_FIREBASE_MEASUREMENT_ID="$VITE_FIREBASE_MEASUREMENT_ID"
EOL