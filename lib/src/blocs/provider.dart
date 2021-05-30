
import 'package:flutter/material.dart';
import 'package:movieapp/src/blocs/home_bloc.dart'; 
export 'package:movieapp/src/blocs/home_bloc.dart'; 

class Provider extends InheritedWidget {

  static Provider _instancia;

  final _homeBloc = new HomeBloc();

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider.__internal( key: key, child: child );
    }

    return _instancia;

  }

  Provider.__internal({ Key key, Widget child  })
    : super (key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HomeBloc homeBloc( BuildContext context )
    => context.dependOnInheritedWidgetOfExactType<Provider>()._homeBloc;

}