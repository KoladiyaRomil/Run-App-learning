import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> products = [
    Product(id: '1', name: 'T-Shirt', price: 120.25),
    Product(id: '2', name: 'Shoes', price: 150.0),
    Product(id: '3', name: 'Laptop', price: 1140.25),
    Product(id: '4', name: 'Headphones', price: 380.0),
    Product(id: '5', name: 'Books', price: 40.20),
    Product(id: '6', name: 'Watch', price: 550.0),
    Product(id: '7', name: 'Airbuds', price: 110.20),
  ];

  final List<CartItem> cart = [];

  void addToCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);
    if (index !=-1) {
      cart[index].quantity++;
    } else {
      cart.add(CartItem(product: product));
    }
    setState(() {});
  }

  void removeFromCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (cart[index].quantity >1) {
        cart[index].quantity--;
      } else {
        cart.removeAt(index);
      }
    }
    setState(() {});
  }
  int getQuantity(Product product) {
    final item = cart.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    return item.quantity;
  }

  int get totalCartItems =>
      cart.fold(0, (sum, item) => sum + item.quantity);
      
    

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(cart: cart),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: const Color.fromARGB(255, 156, 165, 20),
      appBar: AppBar(
    backgroundColor:const Color.fromARGB(255, 132, 111, 27),

        title: const Text('Products List'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart,size: 30,),
                onPressed: openCart,
              ),
              if (totalCartItems > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius:10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$totalCartItems',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          final quantity = getQuantity(product);
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(product.name, style: const TextStyle(fontSize: 18)),
              subtitle:
                  Text('\$${product.price.toDouble()}', style: const TextStyle(fontSize: 16)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => removeFromCart(product),
                  ),
                  Text('$quantity', style: const TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => addToCart(product),
                  ),
                   
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
