# Travel Alarm - Flutter Onboarding App

A Flutter mobile application with onboarding screens, location permissions, and alarm/notification functionality.

## 📱 Features

- ✨ Beautiful onboarding experience with 3 screens
- 📍 Location permission handling
- ⏰ Alarm creation and management
- 🔔 Local notifications
- 💾 Persistent storage with GetStorage
- 🎨 Responsive UI following Figma design

## Preview
<img width="6000" height="3375" alt="Untitled design" src="https://github.com/user-attachments/assets/26dc7a39-0c5b-4170-997c-3ca54c8b9137" />

## 🛠️ Tools & Packages Used

### State Management & Navigation
- `get: ^4.6.6` - State management, dependency injection, and routing
- `get_storage: ^2.1.1` - Local storage solution

### UI & Utilities
- `flutter_screenutil: ^5.9.0` - Responsive UI scaling
- `smooth_page_indicator: ^1.1.0` - Onboarding page indicators

### Permissions & Location
- `permission_handler: ^11.3.0` - Handle runtime permissions
- `geolocator: ^11.0.0` - Get device location
- `geocoding: ^3.0.0` - Reverse geocoding for location names

### Alarms & Notifications
- `flutter_local_notifications: ^17.0.0` - Local notifications
- `timezone: ^0.9.2` - Timezone support for scheduled notifications

## 📁 Project Structure

```
lib/
├── common_widgets/
│   ├── custom_button.dart
│   └── alarm_card.dart
├── constants/
│   ├── app_colors.dart
│   ├── app_strings.dart
│   └── app_images.dart
├── features/
│   ├── onboarding/
│   │   ├── controllers/
│   │   │   └── onboarding_controller.dart
│   │   ├── views/
│   │   │   └── onboarding_screen.dart
│   │   └── widgets/
│   │       └── onboarding_page.dart
│   ├── location/
│   │   ├── controllers/
│   │   │   └── location_controller.dart
│   │   └── views/
│   │       └── location_screen.dart
│   └── home/
│       ├── controllers/
│       │   └── home_controller.dart
│       ├── views/
│       │   └── home_screen.dart
│       └── widgets/
│           └── alarm_list_item.dart
├── helpers/
│   ├── notification_helper.dart
│   └── storage_helper.dart
├── models/
│   └── alarm_model.dart
└── main.dart
```

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode
- VS Code (recommended)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd smart_travel_alarm
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Android Configuration**
   
   Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
   <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
   <uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
   ```

4. **iOS Configuration**
   
   Add to `ios/Runner/Info.plist`:
   ```xml
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>We need your location to provide travel alarms based on your timezone</string>
   <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
   <string>We need your location to provide travel alarms</string>
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Flow

1. **Onboarding Screens** - 3 screens introducing the app with skip option
2. **Location Permission** - Request and handle location access
3. **Home Screen** - Display location and manage alarms
4. **Add Alarm** - Set time and date for new alarms
5. **Notifications** - Receive notifications when alarms trigger

## 🎨 Design

Design follows the Figma specifications:
- Color scheme: Deep blue gradient background with vibrant purple accents
- Typography: Clean, modern fonts
- UI Components: Rounded buttons, cards, and smooth animations

## 📦 Key Dependencies Explained

- **GetX**: Provides reactive state management, navigation without context, and dependency injection
- **ScreenUtil**: Ensures UI looks consistent across different screen sizes
- **Permission Handler**: Manages runtime permissions for location access
- **Geolocator**: Fetches current device location coordinates
- **Flutter Local Notifications**: Schedules and displays notifications for alarms

## 🔧 Development Notes

- Minimum SDK version: Android 21 (Lollipop)
- iOS deployment target: 12.0
- State management pattern: GetX Controllers
- Architecture: Feature-based modular structure
- Storage: GetStorage for lightweight persistence

## 📝 License

This project is created as part of a Flutter developer interview task.

## 👨‍💻 Author

Hafizur Rahman

---

**Note**: This app demonstrates proficiency in Flutter development, state management, permissions handling, and following design specifications.
