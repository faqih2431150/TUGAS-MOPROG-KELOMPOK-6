# TUGAS-MOPROG-KELOMPOK-6
EcoGrid Dashboard  Aplikasi Flutter dashboard energi terbarukan (PLTS, PLTB, PLTMH, Biomassa) yang mendukung SDG 7: Affordable and Clean Energy.
# EcoGrid Dashboard

Aplikasi Flutter dashboard energi terbarukan (PLTS, PLTB, PLTMH, Biomassa)
yang mendukung **SDG 7: Affordable and Clean Energy**.

## Fitur Gesture
| Gesture | Lokasi | Efek visual |
|---|---|---|
| Double Tap | Kartu pembangkit | ON/OFF: warna kartu, status, dan daya berubah; total & grafik ikut update |
| Scale / Pinch | Grafik produksi 24 jam | Grafik membesar/mengecil 1x-3x, label zoom berubah |
| Swipe (Horizontal Drag) | Kartu pembangkit | Kartu bergeser, latar memerah; lewat ambang -> diarsipkan (bisa dibatalkan) |

## Struktur
- `lib/models/energy_source.dart`
- `lib/screens/home_screen.dart`
- `lib/widgets/` (energy_card, zoomable_chart, summary_header)

## Menjalankan
```
flutter pub get
flutter run
```
State dikelola dengan `setState` pada `StatefulWidget`.

## Anggota
- HAFIZHUL FAQIH (202431150)
- ARMANDO SIANIPAR (202431144)
