import 'package:meals/Network/export.dart';

class SharedPref {
  static SharedPreferences? pref;
  static String fbLoginName = 'login Name';
  static String fbLoginEmail = 'login Email';
  static String fbLoginPhoto = 'login Photo';
  static String imgKey = 'userName';
  static String googleLoginName = 'google name';
  static String googleLoginEmail = 'google email';
  static String googleLoginPhoto = 'google photo';
  static String loginEmail = 'email';
  static String loginPass = 'pass';

  static init() async => pref = await SharedPreferences.getInstance();

  static set setFbLoginName(value) => pref!.setString(fbLoginName, value);

  static String? get getFbLoginName => pref!.getString(fbLoginName);

  static set setFbLoginEmail(value) => pref!.setString(fbLoginEmail, value);

  static String? get getFbLoginEmail => pref!.getString(fbLoginEmail);

  static set setFbLoginPhoto(value) => pref!.setString(fbLoginPhoto, value);

  static String? get getFbLoginPhoto => pref!.getString(fbLoginPhoto);

  static set setProfileImage(value) => pref!.setString(imgKey, value);

  static String? get getProfileImage => pref!.getString(imgKey);

  static set setGoogleName(value) => pref!.setString(googleLoginName, value);

  static String? get getGoogleName => pref!.getString(googleLoginName);

  static set setGoogleEmail(value) => pref!.setString(googleLoginEmail, value);

  static String? get getGoogleEmail => pref!.getString(googleLoginEmail);

  static set setGooglePhoto(value) => pref!.setString(googleLoginPhoto, value);

  static String? get getGooglePhoto => pref!.getString(googleLoginPhoto);

  static set setEmail(value) => pref!.setString(googleLoginPhoto, value);

  static String? get getEmail => pref!.getString(googleLoginPhoto);
}
