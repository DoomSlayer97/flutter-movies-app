import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {

  PageTemplate({
    Key key,
    this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {

    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: padding.top + 15.0,
          bottom: padding.bottom
        ),
        child: this.child,
      )
    );
  }
}