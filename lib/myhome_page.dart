import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_flutter_app/home_screen.dart';

import 'detail_screen.dart';
import 'models_providers/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List POST = List();
  bool showing = false;
  int index;

  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: Icon(FontAwesomeIcons.camera),
        ),
        title: Text(
          "Social App",
          style: TextStyle(
              color: themeProvider.themeModel().textColor,
              fontFamily: "Pacifico",
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.share,
              ),
              onPressed: null)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              // color: Colors.red,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  //final themeProvider = Provider.of<ThemeProvider>(context);
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    POST[index]["urls"]["regular"]),
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          index == 0
                              ? Positioned(
                                  bottom: 15,
                                  right: 5,
                                  child: CircleAvatar(
                                    radius: 10,
                                    child: Icon(
                                      Icons.add,
                                      size: 12,
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          POST[index]['user']['username'],
                          style: TextStyle(
                              color: themeProvider.themeModel().textColor),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: POST.length,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: ListView.separated(
                itemCount: POST.length,
                separatorBuilder: (BuildContext context, index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    //color: Colors.red,
                    height: MediaQuery.of(context).size.height * .6,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    child: Text("C"),
                                  ),
                                ),
                                Text(
                                  POST[index]['user']['username'],
                                  style: TextStyle(
                                    color: themeProvider.themeModel().textColor,
                                    fontFamily: "Sacramento",
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: !showing
                                ? Center(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _nextScreen(
                                        POST[index]["urls"]["regular"],
                                        POST[index]['user']['username'],
                                      );
                                    },
                                    child: Image(
                                      image: NetworkImage(
                                          POST[index]["urls"]["regular"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    ),
                                    onPressed: null),
                                IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.comment,
                                      color: Colors.white,
                                    ),
                                    onPressed: null),
                                IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.share,
                                      color: Colors.white,
                                    ),
                                    onPressed: null)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List> get_data() async {
    final response = await http.get(
        'https://api.unsplash.com/photos/?client_id=HW38Jc7lkWLwczmr_qPz7J5LqMvbAiZal1w7-YNZ-Ac');
    var data = json.decode(response.body) as List;
    POST.addAll(data);
    print(response.body.toString());
    Change_State();
    setState(() {
      showing = true;
    });
  }

  Change_State() {
    if (mounted) {
      setState(() {});
    }
  }

  _nextScreen(String imagePath, String userPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(
          imagePath: imagePath,
          userName: userPath,
        ),
      ),
    );
  }
}
