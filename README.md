# Flutter Desktop Demo Application

An application where users can SignUp and Login into the User dashboard

### Screenshots
![alt text](https://user-images.githubusercontent.com/117373571/222376614-6361a558-5db3-4e1a-8572-da821d805400.png)
![alt text](https://user-images.githubusercontent.com/117373571/222378116-35976931-1b3e-41ca-9fdb-ea934b504769.png)
![alt text](https://user-images.githubusercontent.com/117373571/222377133-8c6fb1d8-b144-4737-b855-459f123bc4d3.png)
![alt text](https://user-images.githubusercontent.com/117373571/222376912-a3538838-8893-40f3-bf8e-b61b6159e7e6.png)
![alt text](https://user-images.githubusercontent.com/117373571/222378267-9b382d04-5697-488b-8d70-1a2020042d5f.png)

## Features/Functionality
- App Intro page on startup
- Login page for already registered users
- Sign up for new users
- Length and character validations for Name, Username and password
- Forgot password where users can reset their password if the name and username provided correctly
- User dashboard: India GDP Calculation using 6 params. 
- On providing values and submitting, a pie chart is generated with the provided values

## Getting Started
### Requirements
- Desktop running Mac, Linux or Windows.
- Flutter SDK installed (Flutter 3 or above)
- VSCode with flutter and dart plugin
### How to install and run
1. Clone the repo/Download as zip and extract.
2. Open in VSCode.
3. In terminal, run 'flutter pub get' in project folder
4. Run the application in the MacOS or Windows environment

## Technical tools
- Built with Flutter (v3.7.1) and MongoDB database (v5.0) for macOS.  
- Uses Cubit for state management.  
- MongoDB plugin handles all the database operations.  
- Shared preferences for user session storage.
- Syncfusion charts for the dashboard pie charts  
