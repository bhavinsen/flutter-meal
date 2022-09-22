// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:meals/Network/export.dart';
import 'package:meals/Widgets/auth_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isLoading = false;
  bool darkMode = false;
  final _formKey = GlobalKey<FormState>();

  String getName = '';
  String getEmail = '';
  String getPhoto = '';
  String getGoogleName = '';
  String getGoogleEmail = '';
  String getGooglePhoto = '';
  String getEmails = '';
  String getPas = '';

  @override
  void initState() {
    super.initState();
    getName = SharedPref.getFbLoginName.toString();
    getEmail = SharedPref.getFbLoginEmail.toString();
    getPhoto = SharedPref.getFbLoginPhoto.toString();
    getGoogleName = SharedPref.getGoogleName.toString();
    getGoogleEmail = SharedPref.getGoogleEmail.toString();
    getGooglePhoto = SharedPref.getGooglePhoto.toString();
    getEmails = SharedPref.getEmail.toString();
  }

  bool passwords = true;

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(RegisterController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: Text(
                      login,
                      style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(addYourDetails),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateEmail(value),
                    controller: txtEmail,
                    decoration: InputDecoration(
                      hintText: yourEmail,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: txtPassword,
                    textInputAction: TextInputAction.next,
                    obscureText: passwords,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          passwords = !passwords;
                          setState(
                            () {},
                          );
                        },
                        icon: Icon(
                          passwords ? icVisibilityOff : icVisibility,
                          color: grey,
                        ),
                      ),
                      prefixIconColor: orange,
                      hintText: password,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return (pleaseEnterYourPassword);
                      }
                      if (!regex.hasMatch(value)) {
                        return (pleaseValidPassword);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    height: 55,
                    minWidth: 300,
                    color: orange,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: orange),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.login(
                          txtEmail.text.trim(),
                          txtPassword.text.trim(),
                        );
                        SharedPref.setEmail=txtEmail.text.trim();
                        Get.offAllNamed('/mainPage');
                      }
                    },
                    child: Text(
                      login,
                      style: const TextStyle(color: white, fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      forgetYourPassword,
                      style: const TextStyle(color: grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    orLogin,
                    style: const TextStyle(color: grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  authButton(
                      icon: const Icon(
                        icFaceBook,
                        color: white,
                      ),
                      label: Text(
                        signWithFaceBook,
                        style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      onPress: () async {
                        await authController.signInWithFacebook(context);
                        SharedPref.setFbLoginName =
                            authController.userData!['name'];
                        SharedPref.setFbLoginEmail =
                            authController.userData!['email'];
                        SharedPref.setFbLoginPhoto =
                            authController.userData!['picture']['data']['url'];
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  authButton(
                      icon: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/google.png'),
                          ),
                        ),
                      ),
                      label: Text(
                        signWithGoogle,
                        style: const TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (states) => white,
                        ),
                      ),
                      onPress: () async {
                        await authController.signInWithGoogle(context);
                        SharedPref.setGoogleName = authController.displayName;
                        SharedPref.setGoogleEmail = authController.gmailId;
                        SharedPref.setGooglePhoto = authController.gmailPhoto;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dontHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          signUp,
                          style: const TextStyle(
                              color: orange, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'Email cannot be Empty';
  }
  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}
