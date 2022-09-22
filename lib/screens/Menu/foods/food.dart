import 'package:meals/Network/export.dart';
import 'package:meals/Widgets/addtoCart.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('food');
  late Stream<QuerySnapshot> _streams;

  @override
  void initState() {
    super.initState();
    _streams = _products.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      foods,
                      style: const TextStyle(color: black, fontSize: 30),
                    ),
                    goToCart()
                  ],
                ),
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
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      height: 3,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: document.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot documents = document[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => FoodDetails(index: index),
                          );
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            height: 300,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    documents['image'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            alignment: Alignment.bottomLeft,
                            child: ListTile(
                              title: Text(
                                documents['txt'],
                                style: const TextStyle(
                                    color: white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    icStar,
                                    color: orange,
                                  ),
                                  Text(
                                    documents['rate'].toString(),
                                    style: const TextStyle(
                                        color: orange, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
