import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_flutter_app/post_list.dart';
import 'package:social_flutter_app/stories.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.camera),
        title: Text(
          "Social App",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Pacifico",
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.share,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Stories()),
          Expanded(
            flex: 5,
            child: Container(child: PostList()),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
