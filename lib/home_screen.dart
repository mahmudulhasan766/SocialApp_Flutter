import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_flutter_app/api.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';
import 'models_providers/theme_provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
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
                  crossAxisCount: 1,
                  itemCount: POST.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _nextScreen(
                        POST[index]['urls']['regular'],
                        POST[index]['user']['username'],
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Image.network(
                          POST[index]['urls']['regular'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int i) =>
                      StaggeredTile.count(1, i.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
        ),
      ),
    );
  }

  //
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
