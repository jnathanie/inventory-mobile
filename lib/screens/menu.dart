import 'package:flutter/material.dart';
import 'package:inventory/screens/inventorylist_form.dart';
import 'package:inventory/widgets/left_drawer.dart';
import 'package:inventory/widgets/item_card.dart';
import 'package:inventory/screens/item_list_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<InventoryItem> items = [
    InventoryItem("Lihat Item", Icons.checklist, const Color(0xFF8B0000)),
    InventoryItem("Tambah Item", Icons.add_shopping_cart, const Color.fromARGB(255, 200, 39, 39)),
    InventoryItem("Logout", Icons.logout, const Color.fromARGB(241, 244, 73, 73)),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((InventoryItem item) {
                  // Iterasi untuk setiap item
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
    }
}
