# Flutter Desktop Demo Application

An application where users can SignUp and Login into the User dashboard

### Screenshots
![alt text](https://user-images.githubusercontent.com/117373571/222362720-6a2e91d5-8011-4d5b-ba13-c88b2f75c6b7.png)
![alt text](https://user-images.githubusercontent.com/117373571/222362771-6c627b0f-8726-43d4-adbe-3cc4a3de9f0b.png)
![alt text](https://user-images.githubusercontent.com/117373571/222362829-889a8703-1803-4c07-ba64-6918770fe389.png)
![alt text](https://user-images.githubusercontent.com/117373571/222362846-31b4e637-dc8d-412c-bd5e-bc1d7f73affa.png)
![alt text](https://user-images.githubusercontent.com/117373571/222362880-c8913e22-01fb-4c67-b1ba-f848402fe1e1.png)

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
