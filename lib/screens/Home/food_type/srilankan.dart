import '../../../Network/export.dart';

class SriLankan extends StatefulWidget {
  const SriLankan({Key? key}) : super(key: key);

  @override
  State<SriLankan> createState() => _SriLankanState();
}

class _SriLankanState extends State<SriLankan> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('srilankan');
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
                              () => SriLankanDetails(index: index),
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
                                    documents['srilankan image'],
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
