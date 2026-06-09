# AI Image Studio — Android app

A **standalone** Android app version of the studio. It generates images from prompts,
does image-to-image, enhance/upscale, and image-to-video across **FLUX.2** (Black Forest
Labs), Replicate, fal.ai, OpenAI and Grok.

No server required. Provider logic runs on the device; calls go straight to each API
using Capacitor's **native HTTP** (so there's no browser CORS problem). Your API keys are
stored only on the phone (localStorage) and sent directly to each provider.

```
mobile/
├── capacitor.config.json     # app id, name, native-HTTP plugin enabled
├── package.json              # Capacitor deps + build scripts
├── build-apk.sh              # one-shot build helper
└── www/
    ├── index.html            # phone-optimized UI
    └── providers.js          # all provider adapters (ported from providers.py)
```

## Build the APK

You need **Node.js**, a **JDK 17**, and the **Android SDK**. The simplest way to get the
SDK + JDK is to install **Android Studio** and open it once.

### Option A — one command

```bash
cd mobile
./build-apk.sh
```

Resulting file: `mobile/android/app/build/outputs/apk/debug/app-debug.apk`

### Option B — step by step

```bash
cd mobile
npm install
npx cap add android      # creates the native android/ project (first time only)
npx cap sync android     # copies www/ into the app + installs plugins
npx cap open android     # opens Android Studio → press ▶ Run, or Build > Build APK
```

Or build from the command line without opening the IDE:

```bash
cd android
./gradlew assembleDebug
```

## Install on your phone

- **USB:** enable Developer Options → USB debugging, then
  `adb install -r android/app/build/outputs/apk/debug/app-debug.apk`
- **Manual:** copy the `.apk` to the phone, tap it, allow "install unknown apps".

## Using it

1. Tap **⚙ Keys**, paste keys for the providers you use:
   Replicate (`r8_…`), fal.ai, BFL (`dashboard.bfl.ai`), OpenAI (`sk-…`), xAI (`xai-…`).
2. Pick a tab → provider → model, add a prompt and/or pick an image, tap **Generate**.
3. Tap **⬇ Save** to store the result to Documents and share it.

## Notes

- **FLUX.2** models (pro / flex / max / klein / dev) appear under both **Text → Image**
  and **Image → Image** — on BFL the same endpoint does generation and editing.
- App id is `com.kr.aistudio` (change in `capacitor.config.json` before publishing).
- A **debug** APK is fine for personal install. For Play Store you'd build a signed
  release (`./gradlew assembleRelease` + a keystore).
- App icon: defaults to Capacitor's. To set your own, drop a 1024×1024 PNG and run
  `npx @capacitor/assets generate --android`.
- OpenAI/Grok here are text-to-image only on mobile (image editing needs multipart
  upload, which the native HTTP layer doesn't send cleanly); use FLUX.2 for editing.
