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
			url: `${import.meta.env.VITE_EXPRESS_BASE_URL}/user/login`,
			headers: {
				Authorization: `Bearer ${idToken}`,
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
			url: `${import.meta.env.VITE_EXPRESS_BASE_URL}/user/signup`,
			headers: {
				Authorization: `Bearer ${idToken}`,
			},
		});
		const data = res.data;
		return data;
	}
};
