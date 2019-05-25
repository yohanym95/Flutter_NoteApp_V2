import 'package:flutter/material.dart';
import 'package:flutter_newproject1/libs/crud.dart';
import 'package:flutter_newproject1/screen/note_details.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  var count;
  var note;

  crudMethods crudObj = new crudMethods();

  @override
  void initState() {
    crudObj.getData().then((result) {
      note = result;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES'),
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB CLICKED');
          navigateToDetail(note,'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getNoteList() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    if (note != null) {
      return StreamBuilder(
        stream: note,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: getPriorityColor(
                          snapshot.data.documents[i].data['notePriority']),
                      child: getPriorityIcon(
                          snapshot.data.documents[i].data['notePriority']),
                    ),
                    title: Text(
                      snapshot.data.documents[i].data['noteTitle'],
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      snapshot.data.documents[i].data['noteDescription'],
                      style: titleStyle,
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    onTap: () {},
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      return Text('Loading please wait....!');
    }
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
        break;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
        break;
    }
  }

  void navigateToDetail(selectedID,String title) async{
   Navigator.push(context, MaterialPageRoute(builder: (context) => NoteDetail(selectedID,title)));
    
  }
}
