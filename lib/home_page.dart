import 'package:app_persist/utils/file_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _content;
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
    body: Padding(
        padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                  expands: true,
                decoration: InputDecoration(
                  labelText: 'Shopping notes'
                ),

              )
          ),
          ElevatedButton(onPressed: (){
            FileUtil.writeNote(_textController.text);
            _textController.clear();
          }, child: Text('Save')
          ),
          const SizedBox(
            height: 150,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(_content ?? '<Shopping notes will appear here>', style: TextStyle(fontSize: 22, color: Colors.pink),),
          ),
          ElevatedButton(
              onPressed: () async {
                _content = await FileUtil.readNote();
                setState(() {
                });
              },
              child: Text('Read from the file'))

        ],
      ),
    )
    );

  }
}
