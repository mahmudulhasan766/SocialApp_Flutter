import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext contex, int index) {
          return Story();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: 19,
      ),
    );
  }
}

class Story extends StatelessWidget {
  int index;
  Story({this.index});
  @override
  Widget build(BuildContext context) {
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
                      "https://assetsds.cdnedge.bluemix.net/sites/default/files/styles/amp_metadata_content_image_min_696px_wide/public/feature/images/dsc_0357.jpg?itok=4w7HgGiS"),
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
        Text(
          "Hasan",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
