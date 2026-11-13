#!/usr/bin/env bash
# Jalankan di dalam folder proyek (setelah setup.sh). Menghasilkan >=5 commit & 2 branch fitur.
set -euo pipefail

git init -b main
git add .gitignore pubspec.yaml pubspec.lock analysis_options.yaml README.md android ios web linux macos windows test .metadata 2>/dev/null || git add -A -- . ':!lib' ':!.env'
git commit -m "chore: inisialisasi proyek Flutter dan .gitignore"

git add lib/config lib/models lib/utils lib/providers .env.example
git commit -m "feat: tambah AppConfig (.env), model Student/Note, Validators, AppProvider"

git switch -c fitur-profil
git add lib/widgets/profile_card.dart lib/screens/profile_screen.dart
git commit -m "feat(profil): ProfileCard dan ProfileScreen dengan edit profil"
git switch main
git merge --no-ff fitur-profil -m "merge: fitur-profil ke main"

git switch -c fitur-catatan
git add lib/services/secure_storage_service.dart lib/repositories
git commit -m "feat(catatan): SecureStorageService dan NoteRepository"
git add lib/widgets/note_card.dart lib/widgets/empty_state.dart lib/screens/note_form_screen.dart
git commit -m "feat(catatan): NoteCard, EmptyState, NoteFormScreen dengan validasi"
git add lib/services/api_service.dart lib/screens/users_screen.dart
git commit -m "feat(http): ApiService GET /users dengan error handling dan UsersScreen"
git switch main
git merge --no-ff fitur-catatan -m "merge: fitur-catatan ke main"

git add lib/main.dart lib/screens/home_screen.dart
git commit -m "feat: HomeScreen, navigasi, dan tema terpusat"

git log --graph --oneline --all
