
# myCar Wallet
A mobile application for the Human-Computer Interaction course at Ece Ntua 2022-23, in which we developed a Car Wallet application for Android and iOS devices.


## Contributors

- [Karam Konstantinos](https://github.com/KostasKram)
- [Karampika Marina](https://github.com/marinakarampika)
- [Kolios Apostolos](https://github.com/apostolos-k)


## Tech Stack

**App Development:** [Flutter](https://flutter.dev/), [Dart](https://dart.dev/)

**Database:** [SQflite](https://pub.dev/packages/sqflite)


## Features

- `Garage` Car managment
- `Calendar` Appointment managment
- `Documents` Document upload from Camera and Gallery 
- `Maps` Google Maps directions between cities


## Screenshots

- Garage - Calendar - Add Event

![Screenshot-1](screenshots/screens-1.jpg)


- Documents - Driving License - Maps

![Screenshot-2](screenshots/screens-2.jpg)


## Installation

For the Google Maps functionality, enter your API key at these files:
- `lib/models/location_service.dart` at line 8
- `ios/Runner/AppDelegate.swift` at line 16
- `android/app/src/main/AndroidManifest.xml` at line 36

For running the application on iOS devices, install all dependencies manually with below command in the `/ios` folder, only if you have build errors when trying to run the application. 

```bash
  pod install
```
    
