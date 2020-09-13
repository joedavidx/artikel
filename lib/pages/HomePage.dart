import 'package:artickle/pages/ArticlePage.dart';
import 'package:artickle/pages/FavoritesPage.dart';
import 'package:artickle/pages/HistoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = new TabController(initialIndex: 0, vsync: this, length: 3);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Artikel Kesehatan Lansia'),
          elevation: 0.7,
          actions: <Widget>[
          IconButton(
              icon: new Icon(Icons.search),
              color: Colors.white,
              onPressed: (){},
              ),
            ],
            bottom: new TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                new Tab(child: new Text("Artikel", style: Theme.of(context).textTheme.button)),
                new Tab(child: new Text("Favorit", style: Theme.of(context).textTheme.button)),
                new Tab(child: new Text("Riwayat", style: Theme.of(context).textTheme.button)),
            ],
        ),
    ),
        body: new TabBarView(
            controller: _tabController ,
            children: <Widget>[
              new ArticlePage(),
              new FavoritesPage(),
              new HistoryPage()
            ]
        ),
    );
  }
}