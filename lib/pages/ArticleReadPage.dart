import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleReadPage extends StatefulWidget{
  @override
  State createState() => ArticleReadPageState();
}

class ArticleReadPageState extends State<ArticleReadPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: Icon(Icons.arrow_back_ios),
          title: new Text('Artikel Kesehatan Lansia', style: new TextStyle(color: Colors.white)),
          backgroundColor: Colors.tealAccent.shade700,
          centerTitle: true,
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: FaIcon(FontAwesomeIcons.font),iconSize: 10, onPressed: () {},),
              IconButton(icon: FaIcon(FontAwesomeIcons.font),iconSize: 15, onPressed: () {},),
              IconButton(icon: FaIcon(FontAwesomeIcons.heart), onPressed: () {},),
              IconButton(icon: FaIcon(FontAwesomeIcons.arrowLeft), onPressed: () {},),
              IconButton(icon:  FaIcon(FontAwesomeIcons.arrowRight), onPressed: () {},),
            ],
          ),
        ),
    );
  }
}