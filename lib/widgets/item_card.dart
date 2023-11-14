import 'package:flutter/material.dart';
import 'package:inventory/screens/inventorylist_form.dart';
import 'package:inventory/screens/item_list_page.dart';


class InventoryItem {
  final String name;
  final IconData icon;
  final Color color;

  InventoryItem(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final InventoryItem item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          
          if (item.name == "Tambah Item") {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ItemFormPage()));
          }
  
          if (item.name == "Lihat Item") {
            List<InventoryListItem> getDummyItems() {
              return [
                InventoryListItem("Laptop", 2, "Bagus"),
                InventoryListItem("Earphone", 1, "Canggih"),
              ];
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemListPage(items: getDummyItems()),
                ),
              );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
