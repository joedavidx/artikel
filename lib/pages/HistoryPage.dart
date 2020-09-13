import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget{
  @override
  State createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: new Text("History",style: new TextStyle(fontSize: 20),),
    );
  }
}