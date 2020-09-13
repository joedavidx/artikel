import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget{

  @override
  State createState() => ArticlePageState();
}

class ArticlePageState extends State<ArticlePage>{

  //ditampilkan menggunakan card, tampilan sesuai dengan mockup
  Widget showArticle = Card(

  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[

          ],
        ),

      )
    );

  }


}