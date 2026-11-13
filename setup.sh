#!/usr/bin/env bash
# Jalankan di folder TEMPAT proyek akan dibuat (bukan di dalam source_code ini):
#   bash setup.sh /path/ke/responsi_profil_mahasiswa_source
set -euo pipefail
SRC="${1:?Beri path folder source code ini}"

flutter create --org id.ac.amikom --project-name responsi_profil_mahasiswa responsi_profil_mahasiswa
cd responsi_profil_mahasiswa

flutter pub add shared_preferences flutter_secure_storage flutter_dotenv http intl

# Salin kode
rm -rf lib && cp -r "$SRC/lib" ./lib
cp "$SRC/.env" "$SRC/.env.example" "$SRC/.gitignore" .

# Daftarkan .env sebagai asset
sed -i 's/^  uses-material-design: true/  uses-material-design: true\n\n  assets:\n    - .env/' pubspec.yaml

# AndroidManifest: INTERNET + allowBackup=false
python3 - <<'PY'
p = "android/app/src/main/AndroidManifest.xml"
s = open(p).read()
if "android.permission.INTERNET" not in s:
    s = s.replace("<application",
        '<uses-permission android:name="android.permission.INTERNET"/>\n    <application', 1)
if "android:allowBackup" not in s:
    s = s.replace("<application", '<application\n        android:allowBackup="false"', 1)
open(p, "w").write(s)
PY

echo
echo "Selesai. Cek manual:"
echo " 1) android/app/build.gradle(.kts): minSdk minimal 23 (flutter_secure_storage)"
echo " 2) flutter pub get && flutter run"
