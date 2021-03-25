import 'package:flutter/material.dart';
import 'package:todo_notepad/helpers/database.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add todo'),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                int i =
                                    await DatabaseHelper.instance.insertTask({
                                  DatabaseHelper.colTitle: title,
                                  DatabaseHelper.colDescription: description,
                                  DatabaseHelper.colDate: date,
                                });

                                // print('inserted id is $i');

                                // print(title);
                                // print(description);
                                // print(date);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Add title',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a title' : null,
                            onSaved: (val) {
                              setState(() => title = val);
                            },
                            initialValue: title,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintText: 'Add description',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a description' : null,
                            onSaved: (val) {
                              setState(() => description = val);
                            },
                            initialValue: description,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
