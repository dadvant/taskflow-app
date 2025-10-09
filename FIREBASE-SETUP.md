# TaskFlow v3.0 - Firebase Setup Guide

## 🚀 Step-by-Step Setup Instructions

### **Step 1: Create Firebase Project (5 minutes)**

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: `taskflow-app` (or your choice)
4. **Disable** Google Analytics (optional, can enable later)
5. Click **"Create project"**
6. Wait for project creation to complete

---

### **Step 2: Enable Authentication (3 minutes)**

1. In Firebase Console, click **"Authentication"** in left menu
2. Click **"Get started"**
3. Click **"Sign-in method"** tab
4. Enable **Google** sign-in:
   - Click on "Google"
   - Toggle **"Enable"**
   - Enter support email (your email)
   - Click **"Save"**
5. Enable **Email/Password**:
   - Click on "Email/Password"
   - Toggle **"Enable"** (first option only, not email link)
   - Click **"Save"**

---

### **Step 3: Create Firestore Database (3 minutes)**

1. Click **"Firestore Database"** in left menu
2. Click **"Create database"**
3. Choose **"Start in production mode"** (we'll add rules next)
4. Select region: Choose closest to you (e.g., `us-central1`)
5. Click **"Enable"**
6. Wait for database creation

---

### **Step 4: Set Security Rules (2 minutes)**

1. In Firestore Database, click **"Rules"** tab
2. Replace the rules with this code:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Tasks sub-collection
      match /tasks/{taskId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // Projects sub-collection
      match /projects/{projectId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // Settings sub-collection
      match /settings/{settingId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

3. Click **"Publish"**

---

### **Step 5: Get Firebase Configuration (5 minutes)**

1. Click **⚙️ Settings** icon (top left) → **"Project settings"**
2. Scroll down to **"Your apps"** section
3. Click **Web icon** (`</>`) to add a web app
4. Enter app nickname: `TaskFlow Web`
5. **Check** "Also set up Firebase Hosting" (optional)
6. Click **"Register app"**
7. **Copy the Firebase configuration object** - it looks like this:

```javascript
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "taskflow-app.firebaseapp.com",
  projectId: "taskflow-app",
  storageBucket: "taskflow-app.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

8. **Save this configuration** - you'll need it in Step 6!

---

### **Step 6: Add Configuration to TaskFlow (5 minutes)**

1. Open `TaskFlow3.0-firebase.html` in your editor
2. Find the line that says: `<!-- PASTE YOUR FIREBASE CONFIG HERE -->`
3. Replace the placeholder config with YOUR config from Step 5

**Before:**
```javascript
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  // ... etc
};
```

**After (with YOUR values):**
```javascript
const firebaseConfig = {
  apiKey: "AIzaSyC1234...",  // YOUR actual API key
  authDomain: "taskflow-app.firebaseapp.com",  // YOUR actual domain
  projectId: "taskflow-app",  // YOUR actual project ID
  // ... etc
};
```

4. Save the file

---

### **Step 7: Test Locally (2 minutes)**

1. Open terminal in TaskFlow folder
2. Run local server:
```bash
python -m http.server 8000
```
3. Open browser to: `http://localhost:8000/TaskFlow3.0-firebase.html`
4. Click **"Sign In with Google"** or **"Sign Up"**
5. Test creating a task - it should save to Firestore!

---

### **Step 8: Verify in Firebase Console (1 minute)**

1. Go back to Firebase Console
2. Click **"Firestore Database"**
3. You should see:
   ```
   users/
     └── [your-user-id]/
         ├── tasks/
         │   └── [task-id-1]
         │   └── [task-id-2]
         └── projects/
             └── [project-id-1]
   ```

---

## 🌐 Step 9: Deploy to GitHub Pages (Optional, 10 minutes)

### **A. Create GitHub Repository**

1. Go to [github.com](https://github.com)
2. Click **"New repository"**
3. Name: `taskflow`
4. Choose **Public** or **Private**
5. Click **"Create repository"**

### **B. Upload Files**

```bash
# Initialize git (if not already)
cd C:\Users\ofirn\Documents\TaskFlow
git init

# Add files
git add TaskFlow3.0-firebase.html
git add taskflow-styles.css
git add manifest.json

# Commit
git commit -m "Initial commit - TaskFlow v3.0 with Firebase"

# Add remote (replace YOUR-USERNAME)
git remote add origin https://github.com/YOUR-USERNAME/taskflow.git

# Push
git branch -M main
git push -u origin main
```

### **C. Enable GitHub Pages**

1. In GitHub repository, click **"Settings"**
2. Click **"Pages"** in left menu
3. Under "Source", select **"main"** branch
4. Click **"Save"**
5. Wait 1-2 minutes
6. Your app will be live at: `https://YOUR-USERNAME.github.io/taskflow/TaskFlow3.0-firebase.html`

### **D. Update Firebase Auth Domain**

1. Go back to Firebase Console
2. Click **"Authentication"** → **"Settings"** → **"Authorized domains"**
3. Click **"Add domain"**
4. Add: `YOUR-USERNAME.github.io`
5. Click **"Add"**

---

## ✅ **What You Get:**

✨ **Secure Authentication**
- Google Sign-In (one click)
- Email/Password registration
- Automatic session management

☁️ **Cloud Sync**
- Tasks sync across all devices
- Projects sync across all devices
- Settings sync across all devices
- Real-time updates (see changes instantly)

🔒 **Security**
- Each user can only see their own data
- HTTPS encryption
- Token-based authentication
- Firestore security rules

📱 **Multi-Device Access**
- Access from laptop, phone, tablet
- Always in sync
- Offline support (Firebase caching)

---

## 🆘 **Troubleshooting:**

### **Issue: "Firebase not defined"**
**Solution:** Check that you pasted your Firebase config correctly in Step 6

### **Issue: "Permission denied" when saving tasks**
**Solution:** Check Firestore rules in Step 4 are published correctly

### **Issue: "Auth domain not authorized"**
**Solution:** Add your domain to authorized domains in Firebase Console

### **Issue: Can't see tasks after login**
**Solution:** Open browser console (F12), check for errors. Make sure you're logged in.

---

## 📊 **Free Tier Limits:**

Firebase Free (Spark) Plan includes:
- ✅ **Authentication:** 10,000 users
- ✅ **Firestore:** 1 GB storage, 50K reads/day, 20K writes/day
- ✅ **Hosting:** 10 GB storage, 360 MB/day transfer
- ✅ **More than enough for personal use!**

---

## 🔄 **Data Migration from v2.22:**

Your existing localStorage data will be **automatically migrated** to Firestore on first login!

The app detects localStorage data and uploads it to your cloud account.

---

## 📞 **Need Help?**

Check the browser console (F12) for detailed error messages. All Firebase operations are logged.

---

**Ready to go cloud! 🚀**
