# Zournel

A Flutter-based journal application that allows users to securely create, edit, and manage personal journal entries using Firebase services. The app provides authentication and cloud storage using Firebase.

---

## Features

* User authentication using Firebase Authentication  
* Create journal entries with title and description  
* Edit existing journal entries  
* Search journal entries
* Delete journal entries  
* Cloud data storage using Firebase Firestore  
* Clean and responsive Flutter UI  

---

## Tech Stack

* Flutter  
* Dart  
* Firebase Authentication  
* Cloud Firestore  

---

## Screenshots

<table>
  <tr>
    <td><img src="assets/screenshots/1.jpeg" width="250"></td>
    <td><img src="assets/screenshots/2.jpeg" width="250"></td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/3.jpeg" width="250"></td>
    <td><img src="assets/screenshots/4.jpeg" width="250"></td>
  </tr>
</table>

---

## Project Structure

```text
lib/
 ├── models/
 │    └── journal_entry.dart
 ├── screens/
 │    ├── addentry_screen.dart
 │    ├── editentry_screen.dart
 │    ├── home_screen.dart
 │    └── login_screen.dart
 ├── services/
 │    ├── auth_services.dart
 │    └── firestore_services.dart
 ├── widgets/
 │    ├── custom_input_decoration.dart
 │    └── journal_card.dart
 ├── const.dart
 └── main.dart


## Installation

1. Clone the repository

```bash
  git clone https://github.com/shiyascholayil/zournel.git
```

2. Navigate to the project

```bash
 cd zournel
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the application

```bash
flutter run
```
## Firebase Setup

Before running the project:

Create a Firebase project
Enable Firebase Authentication
Enable Cloud Firestore
Add google-services.json (Android) / GoogleService-Info.plist (iOS)

## Project Purpose

This project was developed as a beginner Flutter application to practice:

 * Flutter UI development
 * Firebase Authentication integration
 * Cloud Firestore CRUD operations
 * Basic mobile app architecture


## Future Enhancements

* Add image attachments to entries 📷  
* Add data backup and restore option ☁️  

## Author

Shiyas Cholayil

GitHub: https://github.com/shiyascholayil

