import 'package:flutter/material.dart';
import 'package:todo_notepad/helpers/database.dart';
import 'package:todo_notepad/models/task.dart';
import 'package:todo_notepad/screens/add_task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> taskList = new List();

  //Items to be listed
  final items = List<String>.generate(100, (i) => "Item $i");
  // final List<Map<String,dynamic>> items = DatabaseHelper.instance.queryAll();
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
      body: FutureBuilder<List<Map>>(
          future: DatabaseHelper.instance.queryAll(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    //Single item listed. Declared at the top
                    ListTile(
                      title: Text(snapshot.data[index]['title']),
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
            );
          }),
    );
  }
}
