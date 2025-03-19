import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Store',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? _data;
  Future<void> _loadData() async {
    final loadData = await rootBundle.loadString('files/about.txt');
    setState(() {
      _data = loadData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 330,
              height: 330,
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.purple[100],
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: _data == null ? const Text('?', textAlign: TextAlign.center, style: TextStyle(fontSize: 80)):
                          Text(_data!, textAlign: TextAlign.center,style: TextStyle(fontSize: 20),)
                    ),
                  ),
                ),
                      
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              ),
                onPressed: _loadData,
                child: Padding(
                    padding: EdgeInsets.all(14.0),
                  child: Text('Tap to know',style: TextStyle(fontSize: 20, color: Colors.white),),

                )
            )
          ],
        ),
      )
    );
  }
}
