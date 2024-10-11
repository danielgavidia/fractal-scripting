#!/bin/sh

# Create frontend directory and navigate there
echo "Enter frontend directory name:"
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

# Change: update tailwind config
cat > tailwind.config.js <<EOL
/** @type {import('tailwindcss').Config} */
export default {
	content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
	theme: {
		extend: {},
	},
	plugins: [require("daisyui")],
	daisyui: {
		themes: ["light", "dark"],
	},
};
EOL

# Change: replace index.css with tailwind starter
cd src
cat > index.css <<EOL
@tailwind base; 
@tailwind components; 
@tailwind utilities; 
EOL

# Change: replace default App.tsx with blank App.tsx
cat > App.tsx <<EOL
const App = () => {
	return <div>App</div>;
};

export default App;
EOL

# Change: delete App.css
rm App.css

# Go back to parent directory
cd ../../