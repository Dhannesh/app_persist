import 'dart:io';

import 'package:app_persist/utils/file_util.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Note extends StatefulWidget {
  final File? noteFile;
  const Note({super.key, this.noteFile});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final _nameTextController = TextEditingController();
  final _contentTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.noteFile != null) {
      final fileName = basename(widget.noteFile!.path);
      _nameTextController.text = fileName;
      FileUtil.readNote(fileName)
          .then((value) => {_contentTextController.text = value});
    } else {
      _nameTextController.text = 'some_note.txt';
      _contentTextController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _nameTextController,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    controller: _contentTextController,
                    decoration: null,
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              )
            ],
          ),
        ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      FileUtil.writeNote(_nameTextController.text, _contentTextController.text);
      Navigator.pop(context);
    },child: Icon(Icons.save),),);
  }
}
