import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cart;
  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void updateQuantity(CartItem item, bool increase) {
    setState(() {
      if (increase) {
        item.quantity++;
      } else {
        if (item.quantity > 0) {
          item.quantity--;
        } else {
          widget.cart.remove(item);
        }
      }
    });
  }

  void deleteProduct(CartItem item) {
    setState(() {
      widget.cart.remove(item) ;
    });
  }

  double get totalPrice => widget.cart.fold(
    0,
    (sum, item) => sum + item.product.price * item.quantity,
  );

  int get totalItems => widget.cart.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 156, 165, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 140, 204),
        title: const Text('Details'),
      ),
      body:
          widget.cart.isEmpty
              ? const Center(child: Text('Details Page is empty'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (_, index) {
                        final item = widget.cart[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                            '\$${item.product.price} x ${item.quantity}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => updateQuantity(item, false),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => updateQuantity(item, true),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => deleteProduct(item),
                                color: const Color.fromARGB(255, 16, 5, 4),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(color: Color.fromARGB(255, 102, 82, 8)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          child: Text(
                            'Total: \$${totalPrice.toDouble()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
