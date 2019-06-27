import 'package:database_intro/models/nodo.dart';
import 'package:flutter/material.dart';

class NotodoScreen extends StatefulWidget {
  NotodoScreen({Key key}) : super(key: key);

  _NotodoScreenState createState() => _NotodoScreenState();
}

class _NotodoScreenState extends State<NotodoScreen> {
  final TextEditingController _textFieldController = TextEditingController();


  void _handleSubmitted(String text) async {
    _textFieldController.clear();
    NodoItem nodoItem = NodoItem(text, DateTime.now().toIso8601String());
  }
  
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

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textFieldController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Item",
                  hintText: 'eg. dont drink beer',
                  icon: Icon(Icons.note_add)),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              _handleSubmitted(_textFieldController.text);
              _textFieldController.clear();
            },
            child: Text('save')),
        FlatButton(onPressed: () => Navigator.pop(context) , 
        child: Text('cancel'),)
      ],
    );
    showDialog(context: context, builder: (_){
      return alert;
    });
  }
}
