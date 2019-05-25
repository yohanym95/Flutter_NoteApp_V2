import 'package:cloud_firestore/cloud_firestore.dart';

class crudMethods{

  Future<void> addData(noteData) async{

    Firestore.instance.runTransaction((Transaction crudTransaction)async{
      CollectionReference reference = await Firestore.instance.collection('notepath');
      reference.add(noteData);
    });
  }

  getData() async{
    return await Firestore.instance.collection('notepath').snapshots();

  }

  updateData(selectedDoc, newValues){
    Firestore.instance.collection('notepath').document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });
  }

  deleteData(docId){
    Firestore.instance.collection('notepath').document(docId).delete().catchError((e){
      print(e);
    });
  }
}