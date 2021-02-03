import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_flutter_app/api.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List POST = List();
  List images;

  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: POST == null
              ? Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: POST.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _nextScreen(
                        POST[index]['urls']['regular'],
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        POST[index]['urls']['regular'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int i) =>
                      StaggeredTile.count(2, i.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
        ),

        //.....................
        // body: Container(
        //   color: Colors.yellow,
        //   child: ListView.builder(
        //     itemCount: POST.length,
        //     itemBuilder: (context, index) {
        //       return Container(child: Text(POST[index]['id']));
        //     },
        //   ),
        //...................
        // color: Colors.blue,
        // child: POST != null
        //     ? StaggeredGridView.countBuilder(
        //
        //         crossAxisCount: 4,
        //         itemCount: POST.length,
        //         itemBuilder: (BuildContext context, int index) => InkWell(
        //           onTap: () {
        //             _nextScreen(POST[index]['id']);
        //           },
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(8.0),
        //             child: Text(
        //               POST[index]['id'],
        //             ),
        //           ),
        //         ),
        //       )
        //     : Container(),
        //),
      ),
    );
  }

  Future<List> get_data() async {
    final response = await http.get(
        'https://api.unsplash.com/photos/?client_id=HW38Jc7lkWLwczmr_qPz7J5LqMvbAiZal1w7-YNZ-Ac');

    var data = json.decode(response.body) as List;
    POST.addAll(data);
    print(response.body.toString());
    Change_State();
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
