import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String imagePath;
  DetailsScreen({@required this.imagePath});
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
              'Back to Home',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
