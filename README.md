# Edge Scan

Edge Scan is a mobile application built with Flutter that allows users to scan receipt images, save scanned data locally, and view the scan history. It also features an interactive tutorial for first-time users.

## 🚀 How to Run the Project

### Prerequisites

- ✅ [Flutter](https://flutter.dev/docs/get-started/install) SDK installed (3.10+ recommended)
- ✅ Dart SDK (comes with Flutter)
- ✅ An IDE like Android Studio or VS Code
- ✅ A physical or virtual Android device
- ✅ Android device with camera and storage permissions enabled

### 🔧 Installation & Setup

```bash
# 1. Clone the project
git clone https://github.com/HaticeDilmac/EdgeScan-app.git
cd edge_scan

# 2. Get dependencies
flutter pub get

# 3. Generate localization files (required if you use flutter_gen/gen_l10n)
flutter gen-l10n

# 4. Run the app on a device
flutter run


## Features

- Scan receipts using the device camera
- Save scanned images to local history
- Save image to gallery
- Blur detection for better image quality
- First-time onboarding tutorial with highlights
- Localization support (English + Turkish)