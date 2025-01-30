import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> _contact = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  _addContact() {
    if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty) {
      setState(() {
        _contact.add({
          "name": _nameController.text,
          "number": _numberController.text
        });
        _nameController.clear();
        _numberController.clear();
      });
    }
  }
  void _removeContact(int index) {
    setState(() {
      _contact.removeAt(index);
    });
  }
  void _removeAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Do you really want to delete all contact?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _contact.clear();
              });
              Navigator.of(ctx).pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Contact'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // ❌ Cancel করলে কিছু হবে না
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _contact.removeAt(index); // ✅ Contact delete হবে
              });
              Navigator.of(ctx).pop(); // Dialog বন্ধ হবে
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Color(0xFF33343b),
        title: Text(
          'Contact List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  labelText: 'Name',
                  hintText: 'Enter This Name',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.5))),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _numberController,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  labelText: 'Number',
                  hintText: 'Enter This Number',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.5))),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: _addContact,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF33343b),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minimumSize: Size(double.infinity, 50)),
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: _contact.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () => _confirmDelete(index),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              _contact[index]["name"]!,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(_contact[index]["number"]!),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.call)),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _removeAll, label: Text('Delete All',style: TextStyle(
        fontWeight: FontWeight.bold,fontSize: 16),),
        icon: Icon(Icons.delete),
      ),
    );
  }
}
