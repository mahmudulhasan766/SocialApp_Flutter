import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String imagePath, userName;
  DetailsScreen({@required this.imagePath, @required this.userName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: RaisedButton(
            color: Colors.black54,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Back home $userName",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
