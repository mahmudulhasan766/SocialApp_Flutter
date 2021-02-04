import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class PostList extends StatefulWidget {
  // int index;
  // PostList({this.index});
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List POST = List();
  bool showing = false;

  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: POST.length,
      itemBuilder: (BuildContext context, int index) {
        return Divider();
      },
      separatorBuilder: (BuildContext context, int index) {
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
                            color: Colors.white,
                            fontFamily: "Sacramento",
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
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
                              POST[index]['urls']['regular'],
                            );
                          },
                          child: Image(
                            image: NetworkImage(POST[index]["urls"]["regular"]),
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

  _nextScreen(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsScreen(
                imagePath: imagePath,
              )),
    );
  }
}
