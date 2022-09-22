# Meal-Monkey

A Meal-Monkey Project Created In Flutter Meal-Monkey supports both Ios and Android.

## Getting started


**Step 1**
Create A Flutter Project
```
flutter create project name
```

** Step 2**
Run a Flutter Project
```
flutter run
```

** Step 3**
Go to project root and execute the following command in console to get the required dependencies:
```
flutter pub get
```

## Meal-Monkey Features:

* Splash 
* Login
* Home
* Navigation
* Google Sign In
* Facebook Login
* Image Picker
* Shared Preferences(Data Save On Local Storage)
* Validation
* Payment Getaway
* Cloud Firestore

### Libraries & Tools Used

* [Firebase Core](https://pub.dev/packages/firebase_core)
* [Firebase Auth](https://pub.dev/packages/firebase_auth)
* [Auth Buttons](https://pub.dev/packages/auth_buttons)
* [Facebook SignIn](https://pub.dev/packages/flutter_facebook_auth)
* [Google SignIn](https://pub.dev/packages/google_sign_in)
* [Shared Preferences](https://pub.dev/packages/shared_preferences)
* [Circle Bottam NavigationBar](https://pub.dev/packages/circle_bottom_navigation_bar)
* [Cloud FireStore](https://pub.dev/packages/cloud_firestore)
* [Badges](https://pub.dev/packages/badges)
* [Star Menu](https://pub.dev/packages/star_menu)
* [Image Picker](https://pub.dev/packages/image_picker)
* [Google Pay](https://pub.dev/packages/pay)


### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- linux
|- macos
|- test
|- web
|- windows
```


### Here is the folder structure we have been using in this project

```
lib/
|- screens/
       |-Bottam_Navigation/
            |-mainPage.dart
       |-Home/
            |-home_page.dart
            |-homefood.dart
            |-most_popular.dart
       |-Login/
            |-login.dart
            |-reset_password.dart
            |-signup.dart
       |-Menu/
            |-bevagers.dart
            |-desserts.dart
            |-food.dart
            |-menu.dart
            |-promotion.dart
       |-More/
            |-my_order/
                     |-checkout.dart
                     |-my_order.dart
            |-about_us.dart
            |-inbox.dart
            |-more_page.dart
            |-notification.dart
            |-paymanet_details.dart
       |-Offer/
            |-offer_page.dart
       |-Profile/
            |-profilepage.dart
       |-Shared_pref/
            |-shared_pref.dart
       |-Splash/
            |-meal_monkey.dart
            |-splashScreen.dart
|- utils/
       |-color.dart
       |-icon.dart
       |-responsive.dart
       |-strings.dart
|-main.dart
```



### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
// import 'dart:io';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meals/screens/Splash/splashScreen.dart';
import 'package:meals/screens/shared_pref/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBhFUxeDB6O5ki3R3IoAPDPEcZWjCsGR78",
            appId: "1:358514215620:ios:fd45c3c61c94a0fa629791",
            messagingSenderId: "358514215620",
            projectId: "meals-f852f"));
  } else {
    await Firebase.initializeApp();
  }
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
```


* For Project [Github](https://github.com/maulikkanani2/GSL-Food-delivery-app-.git)