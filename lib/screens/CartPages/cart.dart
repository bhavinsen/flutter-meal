
import 'package:meals/Network/export.dart';

class Cart extends StatefulWidget {
  const Cart({Key?key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Cart',
                  style: TextStyle(color: black, fontSize: 30),
                ),
              ],
            ),
            cart.isEmpty
                ? Text(yourCartIsEmpty)
                : ListView.builder(
              shrinkWrap: true,
                    itemCount: cart.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key(
                        cart[index]['name'],
                      ),
                      direction: DismissDirection.endToStart,
                      background: slideLeftBackground(),
                      onDismissed: (direction) {
                        cart.removeAt(index);
                        Get.snackbar(
                          '', itemDelete,
                          backgroundColor:Colors.red,

                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cart[index]['image'],
                                  ),fit: BoxFit.cover,

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
                                    cart[index]['name'],
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 40,
                                    ),
                                  ),
                                  Text(
                                    cart[index]['rate'].toString(),
                                  ),
                                  Text(
                                    cart[index]['description'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
