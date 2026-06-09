#!/usr/bin/env bash
# Build a debug APK for AI Image Studio.
# Prereqs (one-time): Node.js, a JDK 17, and the Android SDK.
#   - Easiest: install Android Studio (bundles the SDK + JDK), open it once.
#   - Or set ANDROID_HOME / ANDROID_SDK_ROOT to your SDK and JAVA_HOME to a JDK 17.
set -e
cd "$(dirname "$0")"

echo "==> Installing JS dependencies"
npm install

if [ ! -d "android" ]; then
  echo "==> Adding Android platform"
  npx cap add android
fi

echo "==> Syncing web assets into the Android project"
npx cap sync android

echo "==> Building debug APK with Gradle"
cd android
chmod +x ./gradlew
./gradlew assembleDebug

APK="app/build/outputs/apk/debug/app-debug.apk"
echo ""
echo "==> Done. APK at:"
echo "    mobile/android/$APK"
echo ""
echo "Install on a phone (USB debugging on):  adb install -r $APK"
echo "Or copy the .apk to the phone and open it (allow 'install unknown apps')."
