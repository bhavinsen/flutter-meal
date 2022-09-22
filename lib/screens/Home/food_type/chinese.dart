import '../../../Network/export.dart';

class Chinese extends StatefulWidget {
  const Chinese({Key? key}) : super(key: key);

  @override
  State<Chinese> createState() => _ChineseState();
}

class _ChineseState extends State<Chinese> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('chinese');
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
                child: ListView.builder(
                  itemCount: document.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot documents = document[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ChineseDetails(index: index),
                            );
                            setState(
                              () {},
                            );
                          },
                          child: Container(
                            height: 350,
                            width: 400,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    documents['chinese image'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
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
