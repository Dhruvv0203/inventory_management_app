import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InventoryHomePage(),
    );
  }
}

class InventoryHomePage extends StatefulWidget {
  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  List<Map<String, dynamic>> _items = [];  // List to store inventory items
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Function to add an item
  void _addItem() {
    final name = _nameController.text;
    final quantity = int.tryParse(_quantityController.text);
    final price = double.tryParse(_priceController.text);

    if (name.isNotEmpty && quantity != null && price != null) {
      setState(() {
        _items.add({
          'name': name,
          'quantity': quantity,
          'price': price,
        });
      });
      _nameController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  // Function to update an item
  void _updateItem(int index) {
    final name = _nameController.text;
    final quantity = int.tryParse(_quantityController.text);
    final price = double.tryParse(_priceController.text);

    if (name.isNotEmpty && quantity != null && price != null) {
      setState(() {
        _items[index] = {
          'name': name,
          'quantity': quantity,
          'price': price,
        };
      });
      _nameController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  // Function to delete an item
  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Price'),
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Add Item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                var item = _items[index];

                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(
                      'Quantity: ${item['quantity']}, Price: \$${item['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _nameController.text = item['name'];
                          _quantityController.text = item['quantity'].toString();
                          _priceController.text = item['price'].toString();
                          _updateItem(index);  // Update item in list
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteItem(index), // Delete item
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
