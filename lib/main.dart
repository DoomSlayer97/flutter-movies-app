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
        theme: ThemeData(
          backgroundColor: const Color(0xfb41436a),
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xfb41436a)
          )

        ),
        home: HomePage()
      ),
    );
  }
}