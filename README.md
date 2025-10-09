TaskFlow - Local Run Instructions

This repository contains the TaskFlow single-file web app. Use the included PowerShell helper to run the app locally.

Quickstart (Windows / PowerShell):

1. Ensure Python 3.x is installed and available on PATH (python --version).
2. From the repository root, run:

   ./run-local.ps1

3. The script starts a simple static file server on port 8000 and opens the app in your default browser.

Manual alternative:

- Start a server manually:

  python -m http.server 8000

- Then open http://localhost:8000 in your browser.

Notes:
- The app uses Firebase and Google APIs; to fully use features like Google Sign-In / Calendar, make sure your Firebase project and Google OAuth clients are correctly configured and the current origin (http://localhost:8000) is authorized.
- If you make changes to `index.html`, refresh the browser to see updates.
