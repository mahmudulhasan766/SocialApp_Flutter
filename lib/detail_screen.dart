import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String imagePath;
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
      ),
    );
  }
}
