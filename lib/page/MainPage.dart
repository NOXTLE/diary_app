import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/page/ta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var title = TextEditingController();
    var date = TextEditingController();
    var content = TextEditingController();
    void addData() {
      FirebaseFirestore.instance.collection('diary').add(
          {'title': title.text, 'date': date.text, 'content': content.text});
    }

    Stream getData() {
      var data = FirebaseFirestore.instance.collection('diary').snapshots();
      return data;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(240, 230, 140, 100),
          centerTitle: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.notes_outlined),
            Text(
              "D I A R Y",
              style: GoogleFonts.novaSquare(),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Text(
                            "D I A R Y  E N T R Y",
                            style: GoogleFonts.novaSquare(),
                          ),
                          TextField(
                            controller: title,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "T I T L E"),
                          ),
                          TextField(
                            controller: date,
                            decoration: InputDecoration(hintText: "D A T E"),
                          ),
                          TextField(
                            controller: content,
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton(
                                onPressed: () {
                                  addData();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "S U B M I T",
                                  style: GoogleFonts.novaSquare(),
                                )),
                          )
                        ]),
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("N O  D A T A "),
              );
            }
            var docs = snapshot.data.docs;

            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => datadart(index: index)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        tileColor: Color.fromRGBO(240, 230, 140, 100),
                        leading: Icon(Icons.person),
                        title: Text(docs[index]['title'].toString()),
                        subtitle: Text(docs[index]['date']),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
