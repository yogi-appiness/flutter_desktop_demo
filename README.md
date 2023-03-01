# TechCloudPro Flutter desktop application

A demo application where users can SignUp and Login into the User dashboard


## Features/Functionality
- App Intro page on startup
- Login page for already registered users
- Sign up for new users
- Length and character validations for Name, Username and password
- Forgot password where users can reset their password if the name and username provided correctly
- User session is stored once logged in until they logout from the application.
- When the app is starting up, checks for any valid user session and then logs in that user into the application
- User dashboard


Built with Flutter (v3.7.1) and MongoDB database (v6.0)
Uses Cubit for state management. 
MongoDB plugin handles all the database operations
Shared preferences for user session storage


## Technical Requirements:
- Desktop (Mac, Linux or Windows)
- VSCode with Flutter SDK installed