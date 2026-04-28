import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String name;
  final String image;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.name,
    required this.image,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        margin: const EdgeInsets.only(right: 20, bottom: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFAD554B) : Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Image.asset(image, width: 40, height: 40),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
