// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, file_names, avoid_print

import 'package:meals/Network/export.dart';

class RegisterController extends GetxController {
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///Google
  String displayName = '';
  String gmailId = '';
  String gmailPhoto = '';
  final _googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  var isSignedIn = false.obs;

  ///facebook
  final _facebookLogin = FacebookAuth.instance;
  var fdAcc = Rx<FacebookAuth?>(null);
  var isSignedInFb = false.obs;
  Map<String, dynamic>? userData;
  String fbName = '';

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAllNamed('/mainPage');
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.snackbar(
        error,
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(
        e.toString(),
      );
      Get.snackbar(error, e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      googleAcc.value = await _googleSignIn.signIn();
      displayName = googleAcc.value!.displayName!;
      gmailId = googleAcc.value!.email;
      gmailPhoto = googleAcc.value!.photoUrl!;
      isSignedIn.value = true;
      Get.offAllNamed('/mealsHome');
      Get.snackbar(successfulLogIn, '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
      update();
    } catch (e) {
      Get.snackbar(loginFailed, pleaseTryAgain,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    }
  }

  signInWithFacebook(BuildContext context) async {
    try {
      fdAcc.value != await _facebookLogin.login();
      final user = await FacebookAuth.instance.getUserData();
      userData = user;
      Get.offAllNamed('/mealsHome');
      Get.snackbar(successfulLogIn, '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    } catch (e) {
      Get.snackbar(loginFailed, pleaseTryAgain,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
      Get.snackbar(successfulResetPasswordEmailSent, '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == userNotFound) {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: white,
          colorText: black);
    } catch (e) {
      Get.snackbar(errorOccurred, e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    }
  }

  signOut() async {
    try {
      await auth.signOut();
      await FirebaseAuth.instance.signOut();
      googleAcc.value = await _googleSignIn.signOut();
      displayName = '';
      gmailId = '';
      gmailPhoto = '';
      fdAcc.value != _facebookLogin.logOut();
      userData = null;
      isSignedIn.value = false;
      update();
      Get.offAll(
        () => const LoginPage(),
      );
      Get.snackbar(successfulLogOut, '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    } catch (e) {
      Get.snackbar(errorOccurred, e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orange,
          colorText: black);
    }
  }
}
