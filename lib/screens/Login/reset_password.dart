import 'package:meals/Network/export.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController txtEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(
      RegisterController(),
    );
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  resetPassword,
                  style: const TextStyle(
                      color: black, fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(pleaseEnterYourEmail),
              Text(linkTo),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 39, left: 30),
                child: TextFormField(
                  controller: txtEmail,
                  validator: (value) {
                    bool isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (!isEmailValid) {
                      return 'Invalid email.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: email,
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
              ),
              const SizedBox(
                height: 50,
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
                    authController.resetPassword(
                      txtEmail.text.trim(),
                    );
                  }
                  setState(
                    () {},
                  );
                },
                child: Text(
                  send,
                  style: const TextStyle(color: white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
