import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class datadart extends StatelessWidget {
  int index;
  datadart({super.key, required this.index});

  Stream getData(int index) {
    var data = FirebaseFirestore.instance.collection('diary').snapshots();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getData(index),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text("NO DATA ");
        }

        var data = snapshot.data.docs;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(240, 230, 140, 100),
            centerTitle: true,
            title: Text('${data[index]['title']}'),
            actions: [Text("${data[index]['date']}"), SizedBox(width: 10)],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: const Color.fromARGB(106, 255, 255, 255),
              child: Text("${data[index]['content']}"),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Text("delete"),
          ),
        );
      },
    );
  }
}
