import 'package:flutter/material.dart';

class NotodoScreen extends StatefulWidget {
  NotodoScreen({Key key}) : super(key: key);

  _NotodoScreenState createState() => _NotodoScreenState();
}

class _NotodoScreenState extends State<NotodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("No Todo"),
        centerTitle: true,
        leading: Icon(Icons.accessibility_new),
      ),
      backgroundColor: Colors.black87,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.redAccent,
        tooltip: "Add Item",
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
      
    );
  }

  void _showFormDialog() {}
}
