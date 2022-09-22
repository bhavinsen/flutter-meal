// ignore_for_file: use_build_context_synchronously, file_names
import 'package:meals/Network/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  Future<void> splashScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Get.offAndToNamed('/mealsHome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: Screens.width(context) * 1,
        height: Screens.height(context) * 1,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/splashIcon.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/image/MealMonkeyLogo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
