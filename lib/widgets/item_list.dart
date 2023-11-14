// item_list.dart
import 'package:flutter/material.dart';

class InventoryListItem {
  final String name;
  final int amount;
  final String description;

  InventoryListItem(this.name, this.amount, this.description);
}

class ItemList extends StatelessWidget {
  final List<InventoryListItem> items;

  const ItemList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text('Jumlah: ${item.amount}, Deskripsi: ${item.description}'),
        );
      },
    );
  }
}
