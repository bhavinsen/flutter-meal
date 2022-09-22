import 'package:meals/Network/export.dart';
import 'package:meals/Widgets/addtoCart.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text(
                  'Order',
                  style: TextStyle(color: black, fontSize: 30),
                ),
                goToCart(),
              ],
            ),
            order.isEmpty
                ? Text(yourOrderIsEmpty)
                : ListView.builder(
                    itemCount: order.length,
                    itemBuilder: (context, index) => Container(
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  order[index]['image'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order[index]['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  order[index]['rate'].toString(),
                                ),
                                Text(
                                  order[index]['description'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
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

List<Map> order = [];
