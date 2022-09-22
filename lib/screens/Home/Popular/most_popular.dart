import 'package:meals/Network/export.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({Key? key}) : super(key: key);

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('most');
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
                        Get.to(
                          MostPopularDetails(index: index),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 130,
                            width: 220,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    documents['most image'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documents['most name'],
                                style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    icStar,
                                    color: orange,
                                  ),
                                  Text(
                                    documents['most rate'].toString(),
                                    style: const TextStyle(
                                        color: orange, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    documents['most type'],
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              )
                            ],
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
