import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_flutter_app/api.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  String imagePath;
  String userName;
  HomeScreen({@required this.userName, @required this.imagePath});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List POST = List();
  // List images;
  //
  // @override
  // void initState() {
  //   get_data();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: widget.imagePath == null
              ? Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: widget.imagePath.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _nextScreen(
                        widget.imagePath, widget.userName,
                        // POST[index]['urls']['regular'],
                        // POST[index]['user']['username'],
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Image.network(
                          widget.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int i) =>
                      StaggeredTile.count(2, i.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
        ),
      ),
    );
  }
  //
  // Future<List> get_data() async {
  //   final response = await http.get(
  //       'https://api.unsplash.com/photos/?client_id=HW38Jc7lkWLwczmr_qPz7J5LqMvbAiZal1w7-YNZ-Ac');
  //
  //   var data = json.decode(response.body) as List;
  //   POST.addAll(data);
  //   print(response.body.toString());
  //   Change_State();
  // }
  //
  // Change_State() {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  _nextScreen(String imagePath, String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsScreen(
                imagePath: imagePath,
                userName: userName,
              )),
    );
  }
}
