import 'package:flutter/material.dart';

class FoodTile extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final String description;
  const FoodTile({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(
            widget.image,
            height: 130,
            width: 130,
            fit: BoxFit.contain,
          ),
          Text(
            widget.name,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              widget.description,
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
          ),
          Text(
            "\$${widget.price}",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
