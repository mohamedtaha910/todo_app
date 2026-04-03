import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:todo_app/constant.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: BorderDirectional(
                  start: BorderSide(
                    // color: kSecondaryColor.withAlpha(200),
                    color: Colors.grey,
                    width: 6,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
