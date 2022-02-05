import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  LikeButton(this.like);
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: IconButton(
        iconSize: 30,
        color: like == false ? Colors.grey : Colors.red,
        icon: Icon(Icons.favorite),
        onPressed: () {
          like = like == false ? true : false;
          (context as Element).markNeedsBuild();
        },
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        //createPlantFoodNotification();
        // Navigator.pushNamed(context, "miUser");
      },
    );
  }
}
