# 🎬 Flutter TMDB Movie App

Sebuah aplikasi pencarian film (*movie discovery*) yang dibangun menggunakan Flutter. Proyek ini menggunakan implementasi arsitektur **Feature-First**, manajemen *state* reaktif dengan **MobX**, manipulasi *stream* dengan **RxDart**, dan *Dependency Injection* menggunakan **GetIt**. 

Aplikasi ini mengonsumsi data langsung dari [The Movie Database (TMDB) API](https://developer.themoviedb.org/reference/intro/getting-started).

## ✨ Fitur Utama

* **Beranda (Dashboard):** Menampilkan *Carousel* untuk film *Now Playing*, serta daftar gulir horizontal untuk film *Popular* dan *Upcoming*.
* **Eksplorasi (Discover):** Grid responsif dengan dukungan Pagination (*infinite scroll*). Dilengkapi dengan fitur pengurutan (Sort) dan penyaringan (Filter) berdasarkan Genre resmi TMDB dan Tahun rilis.
* **Pencarian Cerdas (Search):** Halaman pencarian terpisah yang dioptimalkan dengan *Debounce* dari RxDart untuk mencegah *spam* panggilan API saat pengguna mengetik.
* **Detail Film:** Menampilkan informasi komprehensif (poster *slivers*, rating, sinopsis, dan genre) menggunakan arsitektur *Factory* pada *Store* agar alur memori tetap bersih.
* **Bookmark Luring:** Simpan film favorit Anda. Data persisten menggunakan `SharedPreferences`.
* **Pengaturan Global yang Reaktif:**
  * **Tema:** Mendukung Mode Gelap (Dark Mode) dan Mode Terang (Light Mode).
  * **Lokalisasi:** Mendukung 3 Bahasa (Indonesia, English, 日本語). Perubahan bahasa akan otomatis memicu pengambilan ulang data API (menggunakan *query* `language`) untuk menyesuaikan judul dan sinopsis film.
* **UI/UX Premium:** Dilengkapi transisi efek *Shimmer skeleton loading* dan notifikasi *SnackBar* bergaya *toast* modern dengan aksen warna `#0033EE`.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [MobX](https://mobx.netlify.app/) & `flutter_mobx`
* **Reactive Streams:** [RxDart](https://pub.dev/packages/rxdart)
* **Dependency Injection:** [GetIt](https://pub.dev/packages/get_it)
* **Networking:** [Dio](https://pub.dev/packages/dio)
* **Local Storage:** [SharedPreferences](https://pub.dev/packages/shared_preferences)
* **UI Skeleton:** [Shimmer](https://pub.dev/packages/shimmer)
* **Code Generation:** `build_runner` & `mobx_codegen`

## 📂 Struktur Direktori (Feature-First)

Proyek ini dipisahkan berdasarkan fitur aplikasi untuk memastikan skalabilitas kode:

```text
lib/
├── core/
│   ├── di/               # Setup GetIt (locator)
│   ├── stores/           # AppStore (Global state: Tema, Bahasa, Bookmark)
│   └── utils/            # Helper global (misal: SnackbarUtils)
├── features/
│   ├── bookmark/         # Halaman daftar film tersimpan
│   ├── home/             # Navigasi bawah & Dashboard Now Playing/Popular
│   ├── movie/            # Logika API TMDB, Store Discover, Detail, dan UI Card/Grid
│   ├── search/           # Halaman pencarian independen & SearchStore (RxDart)
│   └── settings/         # Halaman pengaturan Tema & Bahasa
└── main.dart             # Entry point & Inisialisasi awal