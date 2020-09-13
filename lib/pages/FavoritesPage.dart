import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget{
  @override
  State createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: new Text("Favorites",style: new TextStyle(fontSize: 20),),
    );
  }
}