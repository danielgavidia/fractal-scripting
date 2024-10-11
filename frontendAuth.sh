#!/bin/sh

# Create firebaseConfig.ts file
mkdir frontend/src/firebase
touch frontend/src/firebase/firebaseConfig.ts
cat > frontend/src/firebase/firebaseConfig.ts <<EOL
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";

const firebaseConfig = {
    apiKey: import.meta.env.VITE_API_KEY,
    authDomain: import.meta.env.VITE_AUTH_DOMAIN,
    projectId: import.meta.env.VITE_PROJECT_ID,
    storageBucket: import.meta.env.VITE_STORAGE_BUCKET,
    messagingSenderId: import.meta.env.VITE_MESSAGING_SENDER_ID,
    appId: import.meta.env.VITE_APP_ID,
    measurementId: import.meta.env.VITE_MEASUREMENT_ID,
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
EOL

# Create expressAuth.ts in ./utils
mkdir frontend/src/utils
touch frontend/src/utils/expressAuth.ts
cat > frontend/src/utils/expressAuth.ts <<EOL
import axios from "axios";
import {
	createUserWithEmailAndPassword,
	signInWithEmailAndPassword,
	UserCredential,
} from "firebase/auth";
import { auth } from "../firebase/firebaseConfig";

export const firebaseAuth = async (
	email: string,
	password: string,
	authOperation: "login" | "signup"
) => {
	if (authOperation === "login") {
		const userCredential: UserCredential = await signInWithEmailAndPassword(
			auth,
			email,
			password
		);
		const idToken: string = await userCredential.user.getIdToken();
		const res = await axios({
			method: "POST",
			url: \`\${import.meta.env.VITE_EXPRESS_BASE_URL}/user/login\`,
			headers: {
				Authorization: \`Bearer \${idToken}\`,
			},
		});
		const data = res.data;
		return data;
	} else {
		const userCredential: UserCredential = await createUserWithEmailAndPassword(
			auth,
			email,
			password
		);
		const idToken: string = await userCredential.user.getIdToken();
		const res = await axios({
			method: "POST",
			url: \`\${import.meta.env.VITE_EXPRESS_BASE_URL}/user/signup\`,
			headers: {
				Authorization: \`Bearer \${idToken}\`,
			},
		});
		const data = res.data;
		return data;
	}
};
EOL


# Create AuthForm component
mkdir frontend/src/components
touch frontend/src/components/AuthForm.tsx
cat > frontend/src/components/AuthForm.tsx <<EOL
import React, { useState } from "react";
import { firebaseAuth } from "../utils/expressAuth";
interface AuthProps {
    authOperation: "login" | "signup";
}
const AuthForm = ({ authOperation }: AuthProps) => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const handleFirebaseAuth = async (e: React.FormEvent): Promise<void> => {
        e.preventDefault();
        const res = await firebaseAuth(email, password, authOperation);
        console.log("Login for email: ", res.email);
        setEmail("");
        setPassword("");
    };
    return (
        <div>
            <form onSubmit={handleFirebaseAuth}>
                <input
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="email"
                />
                <input
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="password"
                />
                <button onClick={handleFirebaseAuth}>
                    {authOperation === "login" ? "Login" : "Signup"}
                </button>
            </form>
        </div>
    );
};
export default AuthForm;
EOL


