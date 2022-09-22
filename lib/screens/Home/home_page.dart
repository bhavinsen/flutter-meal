import 'package:meals/Network/export.dart';
import 'package:meals/Widgets/addtoCart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('popularRestaurant');
  final CollectionReference _product =
      FirebaseFirestore.instance.collection('recent');
  late Stream<QuerySnapshot> _streams;
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _streams = _products.snapshots();
    _stream = _product.snapshots();
  }

  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        goodMorning,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      goToCart()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(deliveringTo),
                Row(
                  children: [
                    Text(
                      currentLocation,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: grey,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Icon(
                      icArrowDropDown,
                      color: orange,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: grey,
                  controller: txtSearch,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      icSearch,
                      color: grey,
                    ),
                    hintText: search,
                    hintStyle: const TextStyle(color: grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 180,
                  child: Food(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      popularRestaurants,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: black),
                    ),
                    Text(
                      viewAll,
                      style: const TextStyle(
                          color: orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )
                  ],
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
                            Get.to(() => PopularDetails(index: index));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 250,
                                width: 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      documents['popular image'],
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Text(
                                documents['popular name'],
                                style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    icStar,
                                    color: orange,
                                    size: 18,
                                  ),
                                  Text(
                                    documents['popular rate'].toString(),
                                    style: const TextStyle(
                                        color: orange, fontSize: 25),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    documents['popular type'],
                                    style: const TextStyle(
                                        color: black, fontSize: 25),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mostPopularg,
                      style: const TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text(
                      viewAll,
                      style: const TextStyle(
                          color: orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 240,
                  child: MostPopular(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      resentItem,
                      style: const TextStyle(
                          color: black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      viewAll,
                      style: const TextStyle(
                          color: orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _stream,
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
                        return ListTile(
                          onTap: () {
                            Get.to(
                              () => RecentItemDetails(index: index),
                            );
                          },
                          leading: Container(
                            // margin: const EdgeInsets.all(15),
                            height: 130,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    documents['recent image'],
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          title: Text(
                            documents['recent name'],
                            style: const TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documents['recent type'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    icStar,
                                    color: orange,
                                    size: 15,
                                  ),
                                  Text(
                                    documents['recent rate'],
                                    style: const TextStyle(
                                        color: orange, fontSize: 17),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
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
      ),
    );
  }
}
