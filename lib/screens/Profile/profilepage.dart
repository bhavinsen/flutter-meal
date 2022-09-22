// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:io';

import 'package:meals/Network/export.dart';
import 'package:meals/Widgets/addtoCart.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<Widget> subEntries;
  File? file;
  String? getData;

  pickImage() async {
    ImagePicker pickImg = ImagePicker();
    XFile? image = await pickImg.pickImage(source: ImageSource.gallery);
    file = File(image!.path);
  }

  pickCamera() async {
    ImagePicker pickImg = ImagePicker();
    XFile? image = await pickImg.pickImage(source: ImageSource.camera);
    file = File(image!.path);
  }

  @override
  void initState() {
    super.initState();
    subEntries = subMenuEntries();
    getData = SharedPref.getProfileImage.toString();
  }

  List<Widget> subMenuEntries() {
    return [
      Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: const Icon(icCamera),
          title: Text(camera),
          onTap: () async {
            await pickCamera();
            setState(
              () {},
            );
          },
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: const Icon(icImage),
          title: Text(gallery),
          onTap: () async {
            await pickImage();
            SharedPref.setProfileImage = file!.path.toString();
            setState(
              () {},
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(RegisterController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    profile,
                    style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  goToCart()
                ],
              ),
              const SizedBox(
                height: 90,
              ),
              if (SharedPref.getFbLoginPhoto != '' &&
                  SharedPref.getFbLoginPhoto != null)
                Center(
                  child: Badge(
                    position: BadgePosition.bottomEnd(),
                    badgeContent: StarMenu(
                      params: const StarMenuParameters(
                        linearShapeParams:
                            LinearShapeParams(alignment: LinearAlignment.right),
                        shape: MenuShape.linear,
                        openDurationMs: 1200,
                      ),
                      items: subEntries,
                      child: const Icon(icEdit),
                    ),
                    badgeColor: white,
                    child: CircleAvatar(
                      radius: 53,
                      backgroundColor: black,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  SharedPref.getFbLoginPhoto.toString(),
                                ),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                )
              else if (SharedPref.getGooglePhoto != '' &&
                  SharedPref.getGooglePhoto != null)
                Center(
                  child: Badge(
                    position: BadgePosition.bottomEnd(),
                    badgeContent: StarMenu(
                      params: const StarMenuParameters(
                        linearShapeParams:
                            LinearShapeParams(alignment: LinearAlignment.right),
                        shape: MenuShape.linear,
                        openDurationMs: 1200,
                      ),
                      items: subEntries,
                      child: const Icon(icEdit),
                    ),
                    badgeColor: white,
                    child: CircleAvatar(
                      radius: 53,
                      backgroundColor: black,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  SharedPref.getGooglePhoto.toString(),
                                ),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                )
              else if (SharedPref.getEmail != '' && SharedPref.getEmail != null)
                Center(
                  child: Badge(
                    position: BadgePosition.bottomEnd(),
                    badgeContent: StarMenu(
                      params: const StarMenuParameters(
                        linearShapeParams:
                            LinearShapeParams(alignment: LinearAlignment.right),
                        shape: MenuShape.linear,
                        openDurationMs: 1200,
                      ),
                      items: subEntries,
                      child: const Icon(icEdit),
                    ),
                    badgeColor: white,
                    child: CircleAvatar(
                      radius: 53,
                      backgroundColor: black,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(shape: BoxShape.circle,color: white),
                        child: const Icon(Icons.account_circle,size: 100,color: white,),
                      ),
                    ),
                  ),
                ),
              TextButton(
                  onPressed: () async {
                    authController.signOut();
                    Get.offAllNamed('/loginPage');
                    SharedPref.setFbLoginName = '';
                    SharedPref.setFbLoginEmail = '';
                    SharedPref.setFbLoginPhoto = '';
                    SharedPref.setProfileImage = '';
                    SharedPref.setGoogleName = '';
                    SharedPref.setGoogleEmail = '';
                    SharedPref.setGooglePhoto = '';
                    SharedPref.setEmail = '';
                    setState(() {});
                  },
                  child: Text(
                    signOut,
                    style: const TextStyle(color: grey),
                  )),
              if (SharedPref.getFbLoginName != '' &&
                  SharedPref.getFbLoginName != null)
                Container(
                  height: 40,
                  width: Screens.width(context) * 0.9,
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(SharedPref.getFbLoginName.toString()),
                    ],
                  ),
                )
              else if (SharedPref.getGoogleName != '' &&
                  SharedPref.getGoogleName != null)
                Container(
                    height: 40,
                    width: Screens.width(context) * 0.9,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(SharedPref.getGoogleName.toString()),
                      ],
                    )),

              if (SharedPref.getFbLoginEmail != '' &&
                  SharedPref.getFbLoginEmail != null)
                Container(
                    height: 40,
                    width: Screens.width(context) * 0.9,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          SharedPref.getFbLoginEmail.toString(),
                        ),
                      ],
                    ))
              else if (SharedPref.getGoogleEmail != '' &&
                  SharedPref.getGoogleEmail != null)
                Container(
                  height: 40,
                  width: Screens.width(context) * 0.9,
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        SharedPref.getGoogleEmail.toString(),
                      ),
                    ],
                  ),
                )
              else if (SharedPref.getEmail != '' && SharedPref.getEmail != null)
                Container(
                  height: 40,
                  width: Screens.width(context) * 0.9,
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(SharedPref.getEmail.toString()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
