import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextListScreen(),
    );
  }
}

class TextListScreen extends StatefulWidget {
  const TextListScreen({super.key});

  @override
  _TextListScreenState createState() => _TextListScreenState();
}

class _TextListScreenState extends State<TextListScreen> {
  List<Item> items = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add title",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add description",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        items.add(
                          Item(titleController.text, descriptionController.text),
                        );
                      });
                      titleController.text = '';
                      descriptionController.text = '';
                    },
                    child: const Text("Add"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ...items.map((item) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      tileColor: Colors.red[100],
                      leading: CircleAvatar(
                        backgroundColor: Colors.red[400],
                      ),
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      trailing: const Icon(Icons.arrow_forward),
                      onLongPress: () {
                        _showEditDeleteDialog(items.indexOf(item));
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _editTextItem(index);
                  },
                  child: const Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _deleteTextItem(index);
                  },
                  child: const Text('Delete'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _editTextItem(int index) {
    String editedTitle = items[index].title;
    String editedSubtitle = items[index].subtitle;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    editedTitle = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Title', border: OutlineInputBorder()),
                controller: TextEditingController(text: editedTitle),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  setState(() {
                    editedSubtitle = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Subtitle', border: OutlineInputBorder()),
                controller: TextEditingController(text: editedSubtitle),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    setState(() {
                      items[index] = Item(editedTitle, editedSubtitle);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Edit Done'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteTextItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}

class Item {
  String title;
  String subtitle;

  Item(this.title, this.subtitle);
}