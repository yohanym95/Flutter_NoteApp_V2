import 'package:flutter/material.dart';
import 'package:flutter_newproject1/libs/crud.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  var selectedID;
  //final Note note;
  NoteDetail(this.selectedID, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailState(this.selectedID, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  var priprities = ['High', 'Low'];
  int priority = 1;
  String title;
  String description;
  String appBartitle;
  var selectedId;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  crudMethods crudObj = new crudMethods();

  NoteDetailState(this.selectedId, this.appBartitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBartitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                  items: priprities.map((String dropdowmItem) {
                    return DropdownMenuItem<String>(
                      value: dropdowmItem,
                      child: Text(dropdowmItem),
                    );
                  }).toList(),
                  style: textStyle,
                  value: getPrirorityAsString(this.priority),
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint(valueSelectedByUser);
                      updatePriority(valueSelectedByUser);
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('somthing changed in title: $value');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('somthing changed in description: $value');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text('Save', textScaleFactor: 1.5),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            debugPrint('Clicked the save Button');
                            _save();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text('Delete', textScaleFactor: 1.5),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            debugPrint('Clicked the Delete Button');
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriority(String value) {
    switch (value) {
      case 'High':
        this.priority = 1;
        break;
      case 'Low':
        this.priority = 2;
        break;
      default:
        this.priority = 1;
        break;
    }
  }

  String getPrirorityAsString(int value) {
    String priority1;
    switch (value) {
      case 1:
        priority1 = priprities[0];
        break;
      case 2:
        priority1 = priprities[1];
        break;
      default:
        priority1 = priprities[0];
        break;
    }

    return priority1;
  }

  void updateTitle() {
    this.title = titleController.text;
  }

  void updateDescription() {
    this.description = descriptionController.text;
  }

  void _save() {
    String date = DateFormat.yMMMd().format(DateTime.now());
    Map<String, dynamic> noteData = {
      'notePriority': this.priority,
      'noteTitle': this.title,
      'noteDescription': this.description,
      'noteDate': date
    };
    crudObj.addData(noteData).then((result) {
      debugPrint('added data');
      titleController.text = "";
      descriptionController.text = "";
    }).catchError((e) {
      print(e);
    });
  }
}
