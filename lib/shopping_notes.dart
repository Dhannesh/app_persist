import 'dart:io';
import 'dart:math';

import 'package:app_persist/note.dart';
import 'package:app_persist/utils/file_util.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ShoppingNotes extends StatefulWidget {
  const ShoppingNotes({super.key});

  @override
  State<ShoppingNotes> createState() => _ShoppingNotesState();
}

class _ShoppingNotesState extends State<ShoppingNotes> {
  late Future<List<File>> notesFuture;
  @override
  void initState() {
    super.initState();
    notesFuture = FileUtil.listNotes();
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
        96, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Notes'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<File>>(
          future: notesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          FileUtil.deleteNote(
                              basename(snapshot.data![index].path));
                        },
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Note(
                                              noteFile: snapshot.data![index])))
                                  .then((value) {
                                notesFuture = FileUtil.listNotes();
                                setState(() {});
                              });
                            },
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  color: getRandomColor(),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 220,
                                    width: 220,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        basename(snapshot.data![index].path),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Note()))
              .then((value) {
            notesFuture = FileUtil.listNotes();
            setState(() {});
          });
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
