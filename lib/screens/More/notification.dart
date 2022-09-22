import 'package:meals/Network/export.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('notification');
  late Stream<QuerySnapshot> _streams;

  @override
  void initState() {
    super.initState();
    _streams = _products.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification,
                        style: const TextStyle(color: black, fontSize: 30),
                      ),
                      const Icon(
                        icCart,
                        color: black,
                      ),
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
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: orange),
                              ),
                              title: Text(
                                documents['notification txt'],
                                style: const TextStyle(
                                    color: black, fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text(
                                documents['notification time'],
                                style: const TextStyle(color: grey),
                              ),
                            ),
                          ],
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
