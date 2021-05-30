import 'package:flutter/material.dart';
import 'package:movieapp/src/blocs/provider.dart';
import 'package:movieapp/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage()
      ),
    );
  }
}