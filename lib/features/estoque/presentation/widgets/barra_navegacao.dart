import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Icon(color: Colors.blue, Icons.inventory_2_outlined),
                  Text("Categorias", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Icon(color: Colors.blue, Icons.shopping_cart_outlined),
                  Text("Lista de Compras", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
