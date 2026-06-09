# How to get the installable APK

There is no `.apk` in this folder yet — an Android binary must be **compiled**. Pick whichever
path fits you. Both produce the same file: `app-debug.apk`, which installs on your phone.

---

## Path 1 — Cloud build with GitHub Actions (no software to install)

You only need a free GitHub account. GitHub compiles the APK for you and gives you a download.

1. Go to https://github.com/new and create a repository (e.g. `ai-image-studio`). Keep it Private if you like.
2. Upload the contents of **this `mobile` folder** as the repo root (so `package.json` and the
   `.github` folder sit at the top level of the repo). Two ways:
   - **Web:** on the new repo page click **uploading an existing file**, then drag in everything
     inside `mobile/` (including the hidden `.github` folder). If the web uploader hides dotfiles,
     use the Git method below.
   - **Git (terminal):**
     ```bash
     cd "Image generator/mobile"
     git init && git add -A && git commit -m "AI Image Studio"
     git branch -M main
     git remote add origin https://github.com/<your-username>/ai-image-studio.git
     git push -u origin main
     ```
3. On GitHub open the **Actions** tab. The "Build Android APK" workflow runs automatically
   (or click it → **Run workflow**). Wait ~3–5 min for the green check.
4. Click the finished run → scroll to **Artifacts** → download **ai-image-studio-apk** (a .zip).
   Unzip it to get **app-debug.apk**.
5. Copy that file to your phone, tap it, allow "install unknown apps". Done.

---

## Path 2 — Build on your own computer

Install **Android Studio** (https://developer.android.com/studio) — it bundles the Android SDK
and JDK. Open it once so it finishes setup, then:

```bash
cd "Image generator/mobile"
./build-apk.sh
```

The APK lands at:
`mobile/android/app/build/outputs/apk/debug/app-debug.apk`

Install over USB (Developer Options → USB debugging on):
```bash
adb install -r android/app/build/outputs/apk/debug/app-debug.apk
```
or just copy the `.apk` to the phone and tap it.

---

### Notes
- This is a **debug** APK — perfect for installing on your own phone. (Play Store needs a signed
  release build, which is a separate step.)
- First launch: tap **⚙ Keys**, paste your provider API keys, and start generating.
