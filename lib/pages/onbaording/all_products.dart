import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/burger_data.dart';
import '../../data/pizza_data.dart';
import '../../data/salad_data.dart';
import '../../data/drink_data.dart';
import '../../model/burger_model.dart';
import '../../model/pizza_model.dart';
import '../../model/salad_model.dart';
import '../../model/drink_model.dart';
import 'detail_page.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final List<BurgerModel> burger = getBurger();
  final List<PizzaModel> pizza = getPizza();
  final List<SaladModel> salad = getSalad();
  final List<DrinkModel> drink = getDrink();
  final List<dynamic> favorites = [];
  final List<dynamic> cart = [];

  List<dynamic> getAllProducts() {
    return [...burger, ...salad, ...drink, ...pizza];
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = getAllProducts();
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: SafeArea(
        child: Column(
          children: [
            /// Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, cart),
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              size: 28,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      FavoritesPage(favorites: favorites),
                                ),
                              );
                            },
                          ),
                          if (favorites.isNotEmpty)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${favorites.length}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              size: 28,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartPage(cart: cart),
                                ),
                              );
                            },
                          ),
                          if (cart.isNotEmpty)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.deepOrange,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${cart.length}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Product grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  itemCount: allProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = allProducts[index];

                    return ProductCard(
                      name: product.name ?? "",
                      image: product.image ?? "",
                      price: product.price ?? 0.0,
                      description: product.description ?? "",
                      isFavorited: favorites.contains(product),
                      onFavoriteToggle: () {
                        setState(() {
                          if (favorites.contains(product)) {
                            favorites.remove(product);
                          } else {
                            favorites.add(product);
                          }
                        });
                      },
                      onAddToCart: () {
                        setState(() {
                          cart.add(product);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.name} added to cart!",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        );
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              product: product,
                              cart: cart,
                              favorites: favorites,
                              onCartUpdated: () => setState(() {}),
                              onFavoriteUpdated: () => setState(() {}),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// product page
class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String description;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.isFavorited,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image + favorite
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            /// Product info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            /// Bottom row: Add to cart + rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F0FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Color.fromARGB(255, 231, 128, 128),
                        size: 20,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star_half, size: 16, color: Colors.amber),
                      Icon(Icons.star_border, size: 16, color: Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Favorites Page
class FavoritesPage extends StatelessWidget {
  final List<dynamic> favorites;
  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.deepOrange,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                "No favorites yet.",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.asset(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                );
              },
            ),
    );
  }
}

/// Cart Page
class CartPage extends StatelessWidget {
  final List<dynamic> cart;

  const CartPage({super.key, required this.cart});

  //get child => null;
  @override
  Widget build(BuildContext context) {
    /// TOTAL PRICE
    double total = cart.fold(0, (sum, item) => sum + item.price);
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: SafeArea(
        child: Column(
          children: [
            /// TOP BAR
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// BACK BUTTON
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "My Cart",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// MENU BUTTON
                  const Icon(Icons.more_vert),
                ],
              ),
            ),

            /// ITEM COUNT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${cart.length} items",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.check_box, size: 18),
                      SizedBox(width: 5),
                      Text("Select all"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// EMPTY CART
            if (cart.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    "Your cart is empty",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                ),
              )
            /// PRODUCT LIST
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final item = cart[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          /// CHECKBOX
                          const Icon(Icons.check_box, color: Colors.black),
                          const SizedBox(width: 10),

                          /// IMAGE
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),

                              child: Image.asset(item.image, fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 15),

                          /// PRODUCT INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$${item.price}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// QUANTITY
                          Row(
                            children: [
                              quantityButton(Icons.remove),
                              const SizedBox(width: 10),
                              Text(
                                "1",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              quantityButton(Icons.add, isGreen: true),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            /// BOTTOM SUMMARY
            Container(
              padding: const EdgeInsets.all(25),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  priceRow("Subtotal:", "\$${total.toStringAsFixed(2)}"),
                  const SizedBox(height: 10),
                  priceRow("Delivery:", "\$10.00"),
                  const SizedBox(height: 10),
                  priceRow("Discount:", "-\$30.00", isGreen: true),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Checkout",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// QUANTITY BUTTON
  Widget quantityButton(IconData icon, {bool isGreen = false}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isGreen ? Colors.lime : Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18),
    );
  }

  /// PRICE ROW
  Widget priceRow(String title, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 16)),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isGreen ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
