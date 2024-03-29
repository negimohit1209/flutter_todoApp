import 'package:database_intro/models/nodo.dart';
import 'package:database_intro/utils/database_client.dart';
import 'package:database_intro/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class NotodoScreen extends StatefulWidget {
  NotodoScreen({Key key}) : super(key: key);

  _NotodoScreenState createState() => _NotodoScreenState();
}

class _NotodoScreenState extends State<NotodoScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  var db = new DatabaseHelper();
  final List<NodoItem> _itemList = <NodoItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readNodoList();
  }

  void _handleSubmitted(String text) async {
    _textFieldController.clear();
    NodoItem nodoItem = NodoItem(text, dateFormatted());
    int savedItemId = await db.saveItem(nodoItem);
    NodoItem addedItem = await db.getItem(savedItemId);
    setState(() {
      _itemList.insert(0, addedItem);
    });
    print('Item saved Id: $savedItemId');
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
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: _itemList[index],
                    onLongPress: () => _updateItem(_itemList[index], index),
                    trailing: Listener(
                      key: Key(_itemList[index].itemName),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                      ),
                      onPointerDown: (pointerEvent) =>
                          _deleteNodo(_itemList[index].id, index),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
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
              Navigator.pop(context);
            },
            child: Text('save')),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancel'),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readNodoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      // NodoItem noDoItem = NodoItem.fromMap(item);
      setState(() {
        _itemList.add(NodoItem.fromMap(item));
      });
      // print("DB items: ${noDoItem.itemName}");
    });
  }

  _deleteNodo(int id, int index) async {
    debugPrint('delete Item');
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(NodoItem item, int index) {
    var alert = AlertDialog(
      title: Text("update item"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textFieldController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                hintText: "Eg. don't buy stuff",
                icon: Icon(Icons.update),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () async {
              NodoItem newItemUpdated = NodoItem.map({
                "itenName": _textFieldController.text,
                "dateCreated": dateFormatted(),
                "id": item.id,
              });
              _handleSubmitterUpdate(index, item);
              await db.updateItem(newItemUpdated);
              setState(() {
                _readNodoList();
              });
              Navigator.pop(context);
            },
            child: Text("Update")),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _handleSubmitterUpdate(int index, NodoItem item) {
    setState(() {
      _itemList.removeWhere((element){
        _itemList[index].itemName == item.itemName;
      });
    });
  }
}
