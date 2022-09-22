import 'package:meals/Network/export.dart';
import 'package:meals/Widgets/addtoCart.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('offer');
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
                        latestOffers,
                        style: const TextStyle(color: black, fontSize: 30),
                      ),
                      goToCart()
                    ],
                  ),
                ),
                Text(findDiscount),
                Text(mealsAndMore),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  height: 30,
                  minWidth: 150,
                  color: orange,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: orange),
                  ),
                  onPressed: () {},
                  child: Text(
                    checkOffer,
                    style: const TextStyle(color: white),
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
                              OfferDetails(index: index),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: 360,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        documents['item image'],
                                      ),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                documents['item name'],
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    icStar,
                                    color: orange,
                                  ),
                                  Text(
                                    documents['item rate'].toString(),
                                    style: const TextStyle(
                                        color: orange, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documents['item type'],
                                    style: const TextStyle(
                                        color: grey, fontSize: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
