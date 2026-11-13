#!/usr/bin/env bash
set -e

# 1. Reset riwayat commit awal tanpa menghapus file proyek dan buat commit dasar main
git checkout main 2>/dev/null || git checkout -b main
git branch -D fitur-profil fitur-catatan 2>/dev/null || true

git checkout --orphan temp-main
git reset
git add .gitignore pubspec.yaml
git commit -m "chore: inisialisasi proyek Flutter dan .gitignore"
git branch -M temp-main main

git add lib/config/app_config.dart lib/utils/validators.dart
git commit -m "feat: tambah AppConfig (.env) dan validators"

# 2. Buat branch fitur-profil dan simpan commit fitur profil
git checkout -b fitur-profil
git add lib/models/student.dart lib/widgets/profile_card.dart
git commit -m "feat(profil): model Student dan ProfileCard"

git add lib/screens/profile_screen.dart
git commit -m "feat(profil): ProfileScreen dengan edit profil"

# 3. Gabungkan (merge) fitur-profil ke main
git checkout main
git merge fitur-profil --no-ff -m "merge: fitur-profil"

# 4. Buat branch fitur-catatan dan simpan commit fitur catatan
git checkout -b fitur-catatan
git add lib/models/note.dart lib/services/secure_storage_service.dart lib/repositories/note_repository.dart
git commit -m "feat(catatan): model Note, SecureStorageService, NoteRepository"

git add lib/providers/app_provider.dart lib/screens/note_form_screen.dart
git commit -m "feat(catatan): AppProvider dan NoteFormScreen dengan validasi"

git add lib/screens/home_screen.dart lib/widgets/note_card.dart lib/widgets/empty_state.dart
git commit -m "feat(catatan): HomeScreen, NoteCard, EmptyState, tema"

# 5. Gabungkan (merge) fitur-catatan ke main & buat commit final
git checkout main
git merge fitur-catatan --no-ff -m "merge: fitur-catatan"

git add lib/services/api_service.dart lib/screens/users_screen.dart
git commit -m "feat: HTTP GET /users dengan error handling"

git add .
git commit -m "docs: finalisasi proyek"

# 6. Push ulang ke GitHub dan tampilkan grafik log
git push -f -u origin --all
git log --graph --oneline --all
