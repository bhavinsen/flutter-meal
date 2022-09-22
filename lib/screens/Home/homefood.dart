import 'package:meals/Network/export.dart';
import 'package:meals/screens/Home/food_type/chinese.dart';
import 'package:meals/screens/Home/food_type/gujarati.dart';
import 'package:meals/screens/Home/food_type/indian.dart';
import 'package:meals/screens/Home/food_type/italian.dart';
import 'package:meals/screens/Home/food_type/punjabi.dart';
import 'package:meals/screens/Home/food_type/south.dart';
import 'package:meals/screens/Home/food_type/srilankan.dart';
import 'package:meals/screens/Home/food_type/western.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('homefood');
  late Stream<QuerySnapshot> _streams;

  @override
  void initState() {
    super.initState();
    _streams = _products.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _streams,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> document = querySnapshot.docs;
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 3,
                  ),
                  itemCount: document.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot documents = document[index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Get.to(
                            () => const Italian(),
                          );
                        }
                        if (index == 1) {
                          Get.to(
                            () => const Western(),
                          );
                        }
                        if (index == 2) {
                          Get.to(
                            () => const Indian(),
                          );
                        }
                        if (index == 3) {
                          Get.to(
                            () => const Punjabi(),
                          );
                        }
                        if (index == 4) {
                          Get.to(
                            () => const Chinese(),
                          );
                        }
                        if (index == 5) {
                          Get.to(
                            () => const SriLankan(),
                          );
                        }
                        if (index == 6) {
                          Get.to(
                            () => const Gujarati(),
                          );
                        }
                        if (index == 7) {
                          Get.to(
                            () => const South(),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    documents['food image'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Text(
                            documents['food name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
