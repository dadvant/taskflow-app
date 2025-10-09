# 🔥 Firebase Configuration Guide for TaskFlow v3.0

## Quick Start - 5 Steps to Deploy

### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Name it: `TaskFlow` (or any name you like)
4. Disable Google Analytics (optional, not needed)
5. Click **"Create project"**

### Step 2: Enable Authentication
1. In Firebase Console, click **"Authentication"** in left sidebar
2. Click **"Get started"**
3. Click **"Sign-in method"** tab
4. Enable **"Google"** provider:
   - Click on "Google"
   - Toggle to **"Enable"**
   - Select a support email
   - Click **"Save"**
5. Enable **"Email/Password"** provider:
   - Click on "Email/Password"
   - Toggle to **"Enable"**
   - Click **"Save"**

### Step 3: Create Firestore Database
1. Click **"Firestore Database"** in left sidebar
2. Click **"Create database"**
3. Select **"Start in production mode"**
4. Choose a location (closest to your users)
5. Click **"Enable"**
6. Go to **"Rules"** tab
7. Replace the rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

8. Click **"Publish"**

### Step 4: Get Your Firebase Config
1. Click the **gear icon** ⚙️ next to "Project Overview" → **"Project settings"**
2. Scroll down to **"Your apps"** section
3. Click the **Web icon** `</>` to add a web app
4. Register app:
   - App nickname: `TaskFlow Web`
   - Check **"Also set up Firebase Hosting"** (optional)
   - Click **"Register app"**
5. **Copy the firebaseConfig object** - you'll see something like:

```javascript
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "taskflow-xxxxx.firebaseapp.com",
  projectId: "taskflow-xxxxx",
  storageBucket: "taskflow-xxxxx.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

### Step 5: Add Config to TaskFlow
1. Open **TaskFlow3.0-firebase.html** in a text editor
2. Find this section near the top (around line 45-54):

```javascript
// TODO: Replace with your Firebase project configuration
const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
};
```

3. **Replace it with your copied config** from Step 4
4. Save the file

## ✅ You're Done!

### Test Locally
1. Open **TaskFlow3.0-firebase.html** in your browser
2. Click **"Sign in with Google"** or create an account with email
3. Your tasks will now sync to the cloud! ☁️

### Test Multi-Device Sync
1. Open the same file in another browser or device
2. Sign in with the same account
3. Add a task - it should appear on all devices instantly!

## 🚀 Deploy to Web (Optional)

### Option A: GitHub Pages (Free)
1. Create a GitHub repository
2. Upload **TaskFlow3.0-firebase.html** (rename to `index.html`)
3. Go to Settings → Pages → Source: `main` branch
4. Your app will be live at: `https://USERNAME.github.io/REPO-NAME/`

### Option B: Firebase Hosting (Free)
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Run: `firebase login`
3. Run: `firebase init hosting`
   - Select your Firebase project
   - Public directory: `public`
   - Single-page app: `Yes`
4. Copy **TaskFlow3.0-firebase.html** to `public/index.html`
5. Run: `firebase deploy`
6. Your app will be live at: `https://PROJECT-ID.web.app/`

## 🔒 Security Notes

- ✅ **User data is isolated** - each user can only access their own tasks
- ✅ **Firestore security rules** prevent unauthorized access
- ✅ **Authentication required** - no anonymous access
- ✅ **Automatic data migration** - your localStorage data moves to cloud on first login

## 🆘 Troubleshooting

### "Firebase not configured" error
- Make sure you replaced the firebaseConfig with your actual values
- Check that all fields have real values (not "YOUR_API_KEY")

### "Permission denied" error
- Check Firestore Rules are published correctly
- Make sure you're signed in
- Try signing out and back in

### Tasks not syncing
- Check browser console for errors (F12)
- Make sure you're connected to internet
- Check Firebase Console → Firestore for your data

### Google sign-in not working
- Make sure Google provider is enabled in Authentication
- Check that authDomain is correct in config
- Try in incognito mode (some extensions block popups)

## 📞 Need Help?

Check the Firebase Console for:
- **Authentication** → Users (see who's signed up)
- **Firestore Database** → Data (see your tasks)
- **Usage** → Dashboard (check quotas)

**Free tier limits:**
- 50,000 reads/day
- 20,000 writes/day
- 1 GB storage
- More than enough for personal use! 🎉
