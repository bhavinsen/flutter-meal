import 'package:meals/Network/export.dart';

class MealMonkey extends StatefulWidget {
  const MealMonkey({Key? key}) : super(key: key);

  @override
  State<MealMonkey> createState() => _MealMonkeyState();
}

class _MealMonkeyState extends State<MealMonkey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        height: Screens.height(context),
        width: Screens.width(context),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: CustomClipperAppBar(),
                child: Container(
                  width: double.infinity,
                  height: Screens.height(context) * 0.5,
                  decoration: const ShapeDecoration(
                    color: orange,
                    shadows: [
                      BoxShadow(
                        color: grey,
                        offset: Offset(0, 15),
                        blurRadius: 10,
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Image.asset(
                    'assets/image/login_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/image/MealMonkeyLogo.png',
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: Screens.height(context) * 0.3,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Flexible(
                      child: Text(
                        discoverBest,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      height: 44,
                      minWidth: 250,
                      color: orange,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: orange),
                      ),
                      onPressed: () {
                        Get.offAllNamed('/loginPage');
                        setState(
                          () {},
                        );
                      },
                      child: Text(
                        login,
                        style: const TextStyle(color: white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 44,
                      minWidth: 250,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: orange),
                      ),
                      onPressed: () {
                        Get.offAllNamed('signUpPage');
                        setState(() {});
                      },
                      child: Text(
                        createAccount,
                        style: const TextStyle(color: orange, fontSize: 20),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
