import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/burger_data.dart';
import '../../data/category_data.dart';
import '../../data/drink_data.dart';
import '../../data/pizza_data.dart';
import '../../data/salad_data.dart';
import '../../model/burger_model.dart';
import '../../model/category_model.dart';
import '../../model/category_tile.dart';
import '../../model/drink_model.dart';
import '../../model/food_tile.dart';
import '../../model/pizza_model.dart';
import '../../model/salad_model.dart';
import '../../service/wiget_support.dart';
import 'all_products.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  final List<dynamic> cart;
  final List<dynamic> favorites;
  final VoidCallback? onCartUpdated;
  final VoidCallback? onFavoriteUpdated;

  const Home({
    super.key,
    required this.cart,
    required this.favorites,
    this.onCartUpdated,
    this.onFavoriteUpdated,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<PizzaModel> pizza = [];
  List<SaladModel> salad = [];
  List<DrinkModel> drink = [];
  List<BurgerModel> burger = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = getCategory();
    pizza = getPizza();
    burger = getBurger();
    salad = getSalad();
    drink = getDrink();
  }

  List<dynamic> getCurrentList() {
    switch (selectedIndex) {
      case 0:
      case 1:
        return salad;
      case 2:
        return drink;
      case 3:
        return pizza;
      default:
        return pizza;
    }
  }

  @override
  Widget build(BuildContext context) {
    List categorieImages = [
      {"image": "images/bg (1).png"},
      {"image": "images/dk (1).png"},
      {"image": "images/sl (1).png"},
      {"image": "images/piz (1).png"},
      {"image": "images/dk (3).png"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FF),
      body: Column(
        children: [
          // Top Fixed Section
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 30,
              right: 20,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("images/logo.png", width: 90, height: 70),
                        Text(
                          "Order your favorite food!",
                          style: AppWidget.simpleTextFieldStyle(),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "images/hq720.jpg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Food",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryWidget(
                        image: categorieImages[index]["image"],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Food",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AllProductsPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "See All",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Category Tiles
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          name: categories[index].name,
                          image: categories[index].image,
                          index: index,
                          selectedIndex: selectedIndex,
                          onTap: () {
                            setState(() => selectedIndex = index);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Food Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: getCurrentList().length,
                    itemBuilder: (context, index) {
                      var list = getCurrentList();

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                product: list[index], // ← Fixed here
                                cart: widget.cart,
                                favorites: widget.favorites,
                                onCartUpdated: widget.onCartUpdated,
                                onFavoriteUpdated: widget.onFavoriteUpdated,
                              ),
                            ),
                          );
                        },
                        child: FoodTile(
                          name: list[index].name,
                          image: list[index].image,
                          price: list[index].price,
                          description: list[index].description,
                        ),
                      );
                    },
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

// CategoryWidget remains the same
class CategoryWidget extends StatelessWidget {
  final String image;
  const CategoryWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 120,
      height: 120,
      child: Center(
        child: Image.asset(image, fit: BoxFit.contain, height: 100, width: 100),
      ),
    );
  }
}
