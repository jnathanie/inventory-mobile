import 'package:flutter/material.dart';
import 'package:inventory/widgets/item_card.dart';

class InventoryListItem {
  final String name;
  final int amount;
  final String description;

  InventoryListItem(this.name, this.amount, this.description);
}

class ItemListPage extends StatelessWidget {
  final List<InventoryListItem> items;

  const ItemListPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: ${item.amount}'),
                Text('Description: ${item.description}'),
              ],
            ),
          );
        },
      ),
    );
  }
}