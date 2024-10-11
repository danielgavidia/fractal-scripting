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

# Install firebase
bun i firebase

# Return to parents dir
cd ..

# Change: update tailwind config
cat > frontend/tailwind.config.js <<EOL
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
cat > frontend/src/index.css <<EOL
@tailwind base; 
@tailwind components; 
@tailwind utilities; 
EOL

# Change: replace default App.tsx with blank App.tsx
cat > frontend/src/App.tsx <<EOL
const App = () => {
	return <div>App</div>;
};

export default App;
EOL

# Change: delete App.css
rm frontend/src/App.css

# Run frontendAuth.sh script
source frontendAuth.sh