# ✅ TaskFlow v3.0 Firebase Testing Checklist

## Pre-Flight Check

### 1. Firebase Configuration
- [ ] Firebase config replaced in TaskFlow3.0-firebase.html (line ~45-54)
- [ ] All values are real (no "YOUR_API_KEY" placeholders)
- [ ] Firestore security rules published
- [ ] Authentication providers enabled (Google + Email/Password)

## Authentication Testing

### 2. Google Sign-In
- [ ] Click "Sign in with Google" button
- [ ] Google OAuth popup appears
- [ ] Select Google account
- [ ] Successfully redirected to app
- [ ] User email appears in header
- [ ] User avatar shows first letter of email

### 3. Email/Password Sign-Up
- [ ] Click "Create account" link
- [ ] Enter email and password
- [ ] Password confirmation works
- [ ] Account created successfully
- [ ] Automatically signed in
- [ ] User email appears in header

### 4. Email/Password Sign-In
- [ ] Sign out
- [ ] Click "Sign in with email"
- [ ] Enter existing credentials
- [ ] Successfully signed in

## Data Migration Testing

### 5. First-Time Login (LocalStorage Migration)
- [ ] Create some tasks in v2.22/v2-stable first
- [ ] Open TaskFlow3.0-firebase.html
- [ ] Sign in for the first time
- [ ] Check: All old tasks appear in the app
- [ ] Check Firebase Console: Tasks appear in Firestore
- [ ] Check: Projects also migrated

## Core Functionality

### 6. Task Creation
- [ ] Click "Add Task" button
- [ ] Fill in task details
- [ ] Save task
- [ ] Check: Task appears in UI
- [ ] Check Firebase Console: Task in Firestore
- [ ] Check: Task ID matches between UI and Firestore

### 7. Task Editing
- [ ] Click a task to open details
- [ ] Edit title, priority, due date
- [ ] Save changes
- [ ] Check: Changes appear in UI
- [ ] Check Firebase Console: Changes in Firestore

### 8. Task Deletion
- [ ] Delete a task
- [ ] Confirm deletion
- [ ] Check: Task removed from UI
- [ ] Check Firebase Console: Task deleted from Firestore

## Real-Time Sync Testing

### 9. Multi-Tab Sync
- [ ] Open TaskFlow in two browser tabs
- [ ] Sign in to same account in both tabs
- [ ] **Tab 1**: Create a new task
- [ ] **Tab 2**: Task appears automatically (within 1-2 seconds)
- [ ] **Tab 2**: Edit the task
- [ ] **Tab 1**: Changes appear automatically
- [ ] **Tab 1**: Delete the task
- [ ] **Tab 2**: Task disappears automatically

### 10. Multi-Device Sync (Optional)
- [ ] Open TaskFlow on Phone browser
- [ ] Sign in with same account
- [ ] Check: All tasks appear
- [ ] Create task on phone
- [ ] Check desktop: Task appears
- [ ] Edit task on desktop
- [ ] Check phone: Changes appear

## UI/UX Testing

### 11. User Profile
- [ ] User avatar shows correct letter
- [ ] Email displays correctly
- [ ] Dropdown menu opens on click
- [ ] "Sign out" button works
- [ ] After sign-out, login modal appears

### 12. Loading States
- [ ] Login shows loading indicator (if implemented)
- [ ] Tasks load smoothly
- [ ] No flickering or duplicate data

### 13. Error Handling
- [ ] Try signing in with wrong password
- [ ] Check: Error message displays
- [ ] Try creating account with existing email
- [ ] Check: Appropriate error shown
- [ ] Disconnect internet, try saving task
- [ ] Check: Graceful degradation (localStorage still works)

## Google Calendar Integration

### 14. Calendar Features Still Work
- [ ] Connect Google Calendar
- [ ] Create task with calendar reminder
- [ ] Check: Event created in Google Calendar
- [ ] Delete task
- [ ] Check: Event deleted from calendar (if auto-delete enabled)

## All Features Preserved from v2.22

### 15. AI Date Parsing
- [ ] Type "tomorrow" in task title
- [ ] Check: Due date auto-set
- [ ] Type "two days from now"
- [ ] Check: Correct date parsed

### 16. Projects & Tags
- [ ] Create task with project
- [ ] Check: Project chip appears
- [ ] Type keywords like "urgent", "meeting"
- [ ] Check: Tags auto-detected

### 17. Priority Matrix View
- [ ] Switch to Board view
- [ ] Check: Tasks organized by priority/urgency
- [ ] Drag task between quadrants
- [ ] Check: Priority updates

### 18. Dark Mode
- [ ] Toggle dark theme
- [ ] Check: All modals are dark
- [ ] Check: Login modal is dark
- [ ] Check: Colors consistent (#1e293b slate)

## Firebase Console Verification

### 19. Firestore Data Structure
- [ ] Open Firebase Console → Firestore
- [ ] Navigate to: `users/{userId}/tasks`
- [ ] Check: Tasks stored correctly
- [ ] Navigate to: `users/{userId}/projects`
- [ ] Check: Projects stored correctly
- [ ] Verify: Each user's data is isolated

### 20. Authentication Users
- [ ] Open Firebase Console → Authentication
- [ ] Check: Your account appears in users list
- [ ] Check: Sign-in method correct (Google or Email)
- [ ] Check: Last sign-in timestamp

## Performance Testing

### 21. Load Times
- [ ] Measure initial load time
- [ ] Check: App responsive within 2-3 seconds
- [ ] Check: No excessive Firebase API calls
- [ ] Check: Real-time updates don't lag

### 22. Offline Behavior
- [ ] Disconnect internet
- [ ] Try creating/editing tasks
- [ ] Check: Works locally (localStorage fallback)
- [ ] Reconnect internet
- [ ] Check: Changes sync to Firestore

## Final Validation

### 23. Complete User Journey
1. [ ] New user signs up with email
2. [ ] Creates 5 tasks with different priorities
3. [ ] Adds projects and tags
4. [ ] Connects Google Calendar
5. [ ] Creates task with calendar reminder
6. [ ] Opens app on different device
7. [ ] Edits task on new device
8. [ ] Changes appear on original device
9. [ ] Deletes task
10. [ ] Signs out
11. [ ] Signs back in
12. [ ] All data still present

## 🎉 Success Criteria

✅ **All checks passed** = Ready for production!

⚠️ **Some checks failed** = Review errors and fix

❌ **Critical failures** = Check Firebase config and console

---

## Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Tasks not syncing | Check Firestore rules, ensure signed in |
| Login fails | Verify Firebase config, check auth providers |
| Duplicate tasks | Clear localStorage, refresh page |
| Real-time sync delayed | Normal if on slow connection (<5s is ok) |
| Can't sign in with Google | Check popup blockers, try incognito mode |

## Next Steps After Testing

1. ✅ Deploy to GitHub Pages or Firebase Hosting
2. ✅ Share with beta testers
3. ✅ Monitor Firebase Console for errors
4. ✅ Check usage quotas (stay under free tier limits)
5. ✅ Collect user feedback

**Free Tier Limits:**
- 50,000 document reads/day ← You'll be fine
- 20,000 document writes/day ← Plenty for personal use
- 1 GB stored data ← Thousands of tasks
- 10 GB/month bandwidth ← More than enough
