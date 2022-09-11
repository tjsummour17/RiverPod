import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = {
    apiKey: "AIzaSyDV7KJSyQ-EvNud3M9bGu4VGSR0M-tVlp8",
    authDomain: "riverpod-application.firebaseapp.com",
    projectId: "riverpod-application",
    storageBucket: "riverpod-application.appspot.com",
    messagingSenderId: "991135240586",
    appId: "1:991135240586:web:6f2ccab4d917e7004cb873",
    measurementId: "G-2SRHDJKRPK"
};

const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);