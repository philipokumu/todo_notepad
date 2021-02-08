import 'package:flutter/material.dart';
import 'package:todo_notepad/screens/add_task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Items to be listed
  final items = List<String>.generate(100, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              //Single item listed. Declared at the top
              ListTile(
                title: Text('${items[index]}'),
                subtitle: Text('uncategorized 4/2/2021'),
                trailing: Checkbox(
                  onChanged: (value) {},
                  activeColor: Theme.of(context).primaryColor,
                  value: false,
                ),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
