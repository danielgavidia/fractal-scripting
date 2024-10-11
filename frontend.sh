#!/bin/sh

# Create frontend directory and navigate there
echo "Frontend dir name:"
read frontend_dir
mkdir $frontend_dir
cd $frontend_dir

# Install React-TS project with Vite
bun create vite . --template react-ts
bun install

# Install axios
bun i axios

# Install React Router
bun i react-router-dom

# Install tailwind
bun i -D tailwindcss postcss autoprefixer
bunx tailwindcss init -p

# Install DaisyUI
bun add -D daisyui@latest