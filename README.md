# Responsi Pemrograman Mobile – Profil Mahasiswa dengan Catatan Kuliah

## Cara pakai
1. Pasang Flutter SDK + Git, lalu: `bash setup.sh "$(pwd)"` dari folder induk
   (script membuat proyek `responsi_profil_mahasiswa`, menambah dependency,
   menyalin `lib/`, `.env`, `.gitignore`, mengatur AndroidManifest).
2. Pastikan `minSdk` >= 23 di `android/app/build.gradle(.kts)`.
3. `flutter pub get && flutter run`
4. Di dalam proyek: `bash ../git_workflow.sh` -> hasilnya 6 commit + 2 branch
   fitur yang di-merge. Screenshot: `git log --graph --oneline --all`.
5. Ganti nama repo menjadi `responsi-pemrograman-mobile-NIM`, push ke GitHub.
   (`.env` tidak ikut ter-push; `.env.example` ikut.)

## Arsitektur
UI (screens/widgets) -> AppProvider (InheritedWidget + StatefulWidget wrapper)
-> NoteRepository -> SharedPreferences (metadata) + SecureStorageService (isi).

## Catatan
- File tambahan di luar struktur wajib: `services/api_service.dart` dan
  `screens/users_screen.dart` (untuk tugas HTTP GET Soal 4).
- Log hanya mencetak status/jenis error, tidak pernah isi catatan / API key.
- Edit NIM/nama di `ProfileScreen` -> tersimpan di SharedPreferences.
