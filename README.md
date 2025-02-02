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

## API contents

1. Dependencies and Setup

    Express.js: Used to create the server.

    CORS: Enables Cross-Origin Resource Sharing.

    PostgreSQL (pg): Used to interact with the database.

    JWT (JSON Web Tokens): Used for user authentication.

    Database Configuration: Connects to a PostgreSQL database with the provided credentials.

2. Middleware

    CORS: Allows cross-origin requests.

    JSON and URL-encoded Parsing: Parses incoming request bodies.

3. Database Connection

    The server connects to the PostgreSQL database and logs the connection status.

4. Authentication

    JWT-based Authentication: Users can log in and receive a JWT token, which is used to authenticate subsequent requests.

    Token Verification: Middleware (authenticateToken) verifies the JWT token in protected routes.

5. Routes

    Root (/): Basic route to check if the server is running.

    Login (/login): Authenticates users by checking their credentials against the database.

    Signup (/signup): Registers new users by storing their username and hashed password in the database.

    Verify Token (/verify-token): Verifies the validity of a JWT token.

    Books (/books): Fetches a list of available books with detailed information.

    User Preferences (/user/:userId/preferences): Fetches or updates a user's preferences (genres, languages, book lengths, authors).

    Available Preferences (/available-preferences): Fetches all available preferences from the database.

    Liked Books (/user/:userId/liked-books): Fetches a list of books liked by a specific user.

    Like Book (/user/:userId/like-book): Allows a user to like a book.

6. Utility Functions

    getPassword: Retrieves a user's hashed password from the database.

    resetPreferences: Resets a user's preferences in the database.

7. Server Startup

    The server listens on port 8080 and logs its status.

    Handles errors related to port conflicts and other server issues.

8. Error Handling

    Uncaught Exceptions: Logs and exits the process on uncaught exceptions.

    Unhandled Rejections: Logs and exits the process on unhandled promise rejections.

9. Security Considerations

    Password Hashing: Uses SHA-256 for password hashing (though stronger hashing algorithms like bcrypt are recommended in production).

    JWT Secret: The JWT secret is hardcoded, but it should be stored in an environment variable in production.

10. Database Queries

    The server performs various SQL queries to interact with the database, including fetching user data, preferences, and book details.

11. Logging

    Extensive logging is used throughout the code to help with debugging and monitoring.

12. Error Responses

    The server provides detailed error responses for various scenarios, such as invalid credentials, missing fields, and server errors.

13. Concurrency

    The server uses Promise.all to execute multiple database queries concurrently, improving performance.

14. Transaction Management

    The resetPreferences function uses database transactions to ensure atomicity when updating user preferences.

15. Environment Variables

    The server is designed to be configurable via environment variables, though some sensitive data (like the JWT secret) is hardcoded in this example.

## Front-end structure
![image](https://github.com/user-attachments/assets/6273748d-5c12-478b-86bd-162570888fee)

