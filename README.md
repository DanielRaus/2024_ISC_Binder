# BookSwipe - A Book Discovery App

A Flutter application that helps users discover books through a Tinder-like swiping interface. Users can create accounts, swipe through books, and save their preferences.

## Setup Requirements

### Prerequisites
```
- Flutter
- Node.js
- PostgreSQL
- npm
```

### Database Setup
1. Install PostgreSQL
2. Create database named "BinderDBTest"
3. Run the provided SQL scripts to create tables and insert sample data

### Server Setup
```bash
# Install dependencies
npm install express pg cors

# Start the server
node server.js


# Token
npm install jsonwebtoken
```

### Flutter App Setup
```bash
# Install dependencies
flutter pub get
```

**Important**: Add Internet permission to `android/app/src/main/AndroidManifest.xml` right after the opening `<manifest>` tag:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application
        ...
```

Update the server IP address in the Flutter app to match your local network.

### Running the App
```bash
flutter run
```

## Features
- User authentication (login/signup)
- Book swiping interface
- Book details display (title, author, rating, etc.)
- Like/Dislike functionality

## Technical Stack
```
- Frontend: Flutter
- Backend: Node.js with Express
- Database: PostgreSQL
```

## Note
This is a demo application with sample book data. For production use, you would need to:
- Add proper security measures
- Include real book cover images
- Implement proper error handling
- Add more comprehensive user features
