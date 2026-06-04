import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../add/add_size_quantity.dart';

class DetailPage extends StatefulWidget {
  final dynamic product;
  final List<dynamic> cart;
  final List<dynamic> favorites;
  final VoidCallback? onCartUpdated;
  final VoidCallback? onFavoriteUpdated;

  const DetailPage({
    super.key,
    required this.product,
    required this.cart,
    required this.favorites,
    this.onCartUpdated,
    this.onFavoriteUpdated,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  bool get isFavorited => widget.favorites.contains(widget.product);

  void toggleFavorite() {
    setState(() {
      if (isFavorited) {
        widget.favorites.remove(widget.product);
      } else {
        widget.favorites.add(widget.product);
      }
    });
    widget.onFavoriteUpdated?.call();
  }

  void addToCart() {
    for (int i = 0; i < quantity; i++) {
      widget.cart.add(widget.product);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.product.name} ×$quantity added to cart!"),
      ),
    );
    widget.onCartUpdated?.call();
  }

  void onIncrement() => setState(() => quantity++);
  void onDecrement() {
    if (quantity > 1) setState(() => quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F0FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Image.asset(
                        widget.product.image,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F0FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "\$${widget.product.price.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.detail ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AddSizeQuantity(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

          // Top Bar
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.arrow_back, size: 26),
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  "Detail food",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Bar
          Positioned(
            bottom: 12,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F0FF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "\$${(widget.product.price * quantity).toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: toggleFavorite,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: addToCart,
                        child: Text(
                          "Add cart 🛒",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
